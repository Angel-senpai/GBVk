//
//  vkAPI.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 25.01.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case failedRequest(message: String)
    case decodableError(message: String)
    case anotherError
}

class vkApi {
    
    private let vkURL = "https://api.vk.com/method/"
    private var networkQ = DispatchQueue.init(label: "networkQ", qos: .userInteractive, target: .global())
    private var networkQOperation = OperationQueue()
    typealias Out = Swift.Result
    
    init(){
        networkQOperation.qualityOfService = .userInteractive
        networkQOperation.name = "networkQOperation"
    }
    func serverResponse<T: Decodable>(requestURL: String,
                                      params: Parameters,
                                      completion: @escaping (Out<T, NetworkError>) -> Void){
        let request = Alamofire.request(requestURL,
                          method: .post,
                          parameters: params)
        let operation = DataRequestOperation(request: request)
        operation.completionBlock = {
            if let data = operation.data{
                do{
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                }catch{
                    completion(.failure(.decodableError(message: "ошибка при декодировании")))
                }
            }else{
                guard let error = operation.error else {
                    completion(.failure(.anotherError))
                    return
                }
                completion(.failure(error))
            }
        }
        networkQOperation.addOperation(operation)
        
    }
    
    func getNews(by token: String,_ startFrom: String = "0",result: @escaping (Out<newsResponseData, NetworkError>) -> ()) {
        let requestURL = vkURL + "newsfeed.get"
        let date = Int(Date().timeIntervalSince1970 - (60 * 60 * 24))
        let params = ["v":"5.103",
                      "access_token":token,
                      "filters":"post",
                      "start_time":String(date),
                      "start_from":startFrom,
                      "max_photoes":"5"
        ]
        serverResponse(requestURL: requestURL, params: params){
            (respond: Out<newsResponse,NetworkError>) in
            switch respond{
            case .failure(let error): result(.failure(error))
            case .success(let news): result(.success(news.response))
            }
        }
    }
    
    func getFriendList(by token: String, hundler: @escaping (Out<[UserResponse], NetworkError>) -> ()){
        let requestURL = vkURL + "friends.get"
        
        let params = ["v": "5.103",
                      "access_token":token,
                      "order":"name",
                      "fields": "city,domain,photo"] as [String:Any]
        
        serverResponse(requestURL: requestURL, params: params){
            (respond: Out<responseUser,NetworkError>) in
            switch respond{
            case .failure(let error): hundler(.failure(error))
            case .success(let users): hundler(.success(users.response.items))
            }
        }
        
    }
    
    
    
    func getProfilePhoto(by token: String, ownerId: String, hundler: @escaping (Out<UserPhoto, NetworkError>) -> ()) {
        let requestURL = vkURL + "photos.get"
        
        let params = ["v": "5.103",
                      "access_token":token,
                      "owner_id": ownerId,
                      "album_id":"-6",
                      "rev":"1",
                      "extended": "1",
                      "count":"1"]
        
        serverResponse(requestURL: requestURL, params: params){
            (respond: Out<responsePhoto,NetworkError>) in
            switch respond{
            case .failure(let error): hundler(.failure(error))
            case .success(let photo): hundler(.success(photo.response.items[0]))
            }
        }
    }
    
    func getPhoto(by token: String, ownerId: String,count: Int = 10, hundler: @escaping (Out<[UserPhoto], NetworkError>) -> ()) {
        let requestURL = vkURL + "photos.getAll"
        
        let params = ["v": "5.103",
                      "access_token":token,
                      "owner_id": ownerId,
                      "extended": "0",
                      "no_service_albums":"0",
                      "need_hidden": "0",
                      "count":"\(count)",
            "skip_hidden":"0"]
        
        serverResponse(requestURL: requestURL, params: params){
            (respond: Out<responsePhoto,NetworkError>) in
            switch respond{
            case .failure(let error): hundler(.failure(error))
            case .success(let photo): hundler(.success(photo.response.items))
            }
            
        }
    }
    
    func getProfilePhoto(url: String,completion: @escaping (UIImage?) -> Void ) {
           let _ = Alamofire.request(url, method: .get).responseData{
               response in
               switch response.result{
               case .success(let data):
                   completion(UIImage(data: data))
               case .failure:
                   completion(#imageLiteral(resourceName: "dog"))
               }
           }
           completion(nil)
       }
    
    func getUserGroup(by token: String,ownerId: String, hundler: @escaping (Out<[GroupVK], NetworkError>) -> ()){
        let requestURL = vkURL + "groups.get"
        
        let params = ["v": "5.103",
                      "access_token":token,
                      "owner_id": ownerId,
                      "extended": "1"]
        
        serverResponse(requestURL: requestURL, params: params){
            (respond: Out<responseGroup,NetworkError>) in
            switch respond{
            case .failure(let error): hundler(.failure(error))
            case .success(let photo): hundler(.success(photo.response.items))
            }
        }
    }
    
    func getSearchGroup(by token: String,
                        searchString: String,count: Int = 10,
                        hundler: @escaping (Out<[GroupVK], NetworkError>) -> ()){
        let requestURL = vkURL + "groups.search"
        
        let params = ["v": "5.103",
                      "access_token":token,
                      "count":"\(count)",
            "q": searchString,
            "sort": "0"]
        
        serverResponse(requestURL: requestURL, params: params){
            (respond: Out<responseGroup,NetworkError>) in
            switch respond{
            case .failure(let error): hundler(.failure(error))
            case .success(let photo): hundler(.success(photo.response.items))
            }
        }
    }
}

//
//  vkAPI.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 25.01.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import Foundation
import Alamofire


class VKApi {
    
    private let vkURL = "https://api.vk.com/method/"
    
    enum NetworkError: Error {
        case failedRequest(message: String)
        case decodableError
        case anotherError
    }
    
    func serverResponse<T: Decodable>(requestURL: String,
                                      params: Parameters,
                                      completion: @escaping (Swift.Result<T, NetworkError>) -> Void){
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params)
            .responseData{ (response) in
                
                switch response.result{
                case .failure(let error):
                    completion(.failure(NetworkError.failedRequest(message: error.localizedDescription)))
                case .success(let data):
                    do{
                        let response = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(response))
                    }catch{
                        completion(.failure(.decodableError))
                    }
                }
                
        }
    }
    
    func getFriendList(by token: String, hundler: @escaping (Swift.Result<[UserVK], NetworkError>) -> ()){
        let requestURL = vkURL + "friends.get"
        
        let params = ["v": "5.103",
                      "access_token":token,
                      "order":"name",
                      "fields": "city,domain"] as [String:Any]
        
        serverResponse(requestURL: requestURL, params: params){
            (respond: Swift.Result<responseUser,NetworkError>) in
            switch respond{
            case .failure(let error): hundler(.failure(error))
            case .success(let users): hundler(.success(users.response.items))
            }
        }
        
    }
    
    
    
    func getProfilePhoto(by token: String, ownerId: String, hundler: @escaping (Swift.Result<String, NetworkError>) -> ()) {
        let requestURL = vkURL + "photos.get"
        
        let params = ["v": "5.103",
                      "access_token":token,
                      "owner_id": ownerId,
                      "album_id":"profile",
                      "rev":"1",
                      "count":"1"]
        serverResponse(requestURL: requestURL, params: params){
            (respond: Swift.Result<responsePhoto,NetworkError>) in
            switch respond{
            case .failure(let error): hundler(.failure(error))
            case .success(let photo): hundler(.success(photo.response.items[0].photo[1].url))
            }
        }
    }
    
    func getPhoto(by token: String, ownerId: String,count: Int = 10, hundler: @escaping (Swift.Result<[UserPhoto], NetworkError>) -> ()) {
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
            (respond: Swift.Result<responsePhoto,NetworkError>) in
            switch respond{
            case .failure(let error): hundler(.failure(error))
            case .success(let photo): hundler(.success(photo.response.items))
            }
            
        }
    }
        
        func getUserGroup(by token: String,ownerId: String, hundler: @escaping (Swift.Result<[GroupVK], NetworkError>) -> ()){
            let requestURL = vkURL + "groups.get"
            
            let params = ["v": "5.103",
                          "access_token":token,
                          "owner_id": ownerId,
                          "extended": "1"]
            
            serverResponse(requestURL: requestURL, params: params){
                (respond: Swift.Result<responseGroup,NetworkError>) in
                switch respond{
                case .failure(let error): hundler(.failure(error))
                case .success(let photo): hundler(.success(photo.response.items))
                }
            }
        }
        
        func getSearchGroup(by token: String,
                            searchString: String,count: Int = 10,
                            hundler: @escaping (Swift.Result<[GroupVK], NetworkError>) -> ()){
            let requestURL = vkURL + "groups.search"
            
            let params = ["v": "5.103",
                          "access_token":token,
                          "count":"\(count)",
                "q": searchString,
                "sort": "0"]
            
            serverResponse(requestURL: requestURL, params: params){
                (respond: Swift.Result<responseGroup,NetworkError>) in
                switch respond{
                case .failure(let error): hundler(.failure(error))
                case .success(let photo): hundler(.success(photo.response.items))
                }
            }
        }
}

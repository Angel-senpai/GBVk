//
//  NewsPresenter.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 20.05.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import UIKit
import Alamofire

struct newsFieldInfo {
    let name: String
    let photo: UIImage
}

protocol NewsPresenter {
    func viewDidLoad()
    func getPhoto(owner id: String, completion: @escaping (UIImage?) -> Void)
    func nextPage()
    var updateClouser:(()->())?{get}
}
class NewsPresenterImplimentation: NewsPresenter {
    
    private var vkAPI:vkApi
    var updateClouser: (() -> ())?
    
    var newsFeedData: newsResponseData?
    
    var newsArray:[newsData] = []{
        didSet{
            updateClouser?()
        }
    }
    init() {
        vkAPI = vkApi()
    }

    func viewDidLoad() {
        getNews(){
            self.newsFeedData = $0
            self.newsArray = self.newsFeedData?.items ?? []
        }
    }
    
    func getInfo(owner id: String, completion: @escaping (newsFieldInfo) -> Void){
        if Int(id) ?? 0 < 0{
            newsFeedData?.groups.forEach{ group in
                if Int(group.id) == ((Int(id) ?? 0) * -1){
                    vkAPI.getProfilePhoto(url: group.photo_100){
                        completion(newsFieldInfo(name: group.name, photo: $0 ?? #imageLiteral(resourceName: "dogCoffee")))
                    }
                }
            }
        }else{
            newsFeedData?.profiles.forEach{ profile in
                if Int(profile.id) == (Int(id) ?? 0){
                    vkAPI.getProfilePhoto(url: profile.photo){
                        completion(newsFieldInfo(name: "\(profile.firstName ?? "") \(profile.lastName ?? "")", photo: $0 ?? #imageLiteral(resourceName: "dogCoffee")))
                    }
                }
            }
        }
    }
    
    func nextPage() {
        getNews(newsFeedData?.next_from ?? "0"){
            self.newsFeedData = $0
            self.newsArray += self.newsFeedData?.items ?? []
        }
    }
    
    func getPhoto(owner id: String, completion: @escaping (UIImage?) -> Void) {
        if Int(id) ?? 0 < 0{
            newsFeedData?.groups.forEach{
                if Int($0.id) == ((Int(id) ?? 0) * -1){
                    vkAPI.getProfilePhoto(url: $0.photo_100){
                        completion($0)
                    }
                }
            }
        }else{
            newsFeedData?.profiles.forEach{
                if Int($0.id) == (Int(id) ?? 0){
                    vkAPI.getProfilePhoto(url: $0.photo){
                        completion($0)
                    }
                }
            }
        }
    }
    
    func getNews(_ startFrom:String = "0",_ result: @escaping (((newsResponseData)?) -> ())) {
        vkAPI.getNews(by: Session.instance.token,startFrom){
            switch $0{
                case .failure(let error):
                    print(error.localizedDescription)
                    result(nil)
                case .success(let news): result(news)
            }
        }
    }
    
    
}

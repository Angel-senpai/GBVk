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
    var table: UITableView? { get }
    var updateClouser:(()->())?{get}
    
}
class NewsPresenterImplimentation: NewsPresenter {
    
    var table: UITableView?
    private var vkAPI:vkApi
    var dataSaver: DataSaver?
    var updateClouser: (() -> ())?
    
    var newsFeedData: newsResponseData?
    var news: [News] = []{
        didSet{
            updateClouser?()
        }
    }
    init() {
        vkAPI = vkApi()
    }
    
    func viewDidLoad() {
        getNews(){
            self.update($0)
        }
    }
    
    private func getAttachmentsURL(attachment array: [attachmentsData]) -> [String]? {
        var tempArr = [String]()
        for i in array{
            var flag = false
            guard let photoArr = i.photo else {return nil}
            for photo in photoArr.photo{
                if flag {break}
                switch photo.type {
                case .x:
                    tempArr.append(photo.url)
                    flag = true
                default:
                    tempArr.append(photo.url)
                    flag = true
                }
                
            }
        }
        return tempArr
    }
    
    func getPhoto(url: String, indexPath: IndexPath)-> UIImage?{
        return self.dataSaver?.photo(atIndexpath: indexPath, byUrl: url)
    }
    
    func nextPage() {
        getNews(newsFeedData?.next_from ?? "0"){
            self.update($0)
        }
    }
    
    private func update(_ newsR:newsResponseData?){
        self.newsFeedData = newsR
        if let newsData = self.newsFeedData?.items{
            for i in newsData{
                let tempN = News(sourceId: i.source_id, text: i.text ?? "")
                if tempN.sourceId < 0{
                    self.newsFeedData?.groups.forEach{ group in
                        if Int(group.id) == (tempN.sourceId * -1){
                            tempN.userName = group.name
                            tempN.userPhotoUrl = group.photo_100
                        }
                    }
                }else{
                    self.newsFeedData?.profiles.forEach{ profile in
                        if Int(profile.id) == tempN.sourceId{
                            tempN.userName = (profile.firstName ?? "")+" "+(profile.lastName ?? "")
                            tempN.userPhotoUrl = profile.photo
                        }
                    }
                }
                if let attachments = i.attachments{
                    tempN.urlImage = self.getAttachmentsURL(attachment: attachments)
                    tempN.newsType = .withPhoto
                }else{ tempN.newsType = .onlyText }
                self.news.append(tempN)
            }
        }else{
            self.news = []
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

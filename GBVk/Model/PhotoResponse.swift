//
//  Photo.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 29.01.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import UIKit


struct UserPhoto: Decodable {
    var id: Int
    var date: Int
    var text: String?
    var likes: Like
    var photo: [Photo]
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case photo = "sizes"
        case date
        case text
        case likes
    }
    
   /* init(from decoder: Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try mainContainer.decode(Int.self, forKey: .id)
        print(id)
        self.photo = try mainContainer.decode([Photo].self, forKey: .photo)
        print(photo)
        self.date = try mainContainer.decode(Int.self, forKey: .date)
        print(date)
        self.text = try mainContainer.decode(String.self, forKey: .text)
        self.likes = try mainContainer.decode(Like.self, forKey: .likes)
        print(likes)
    }*/
    
    struct Like: Decodable {
        var isLiked:Int
        var count: Int
        
        enum CodingKeys: String, CodingKey {
            case isLiked = "user_likes"
            case count
        }
    }
}

struct Photo: Decodable {
    let type: PhotoType
    let url: String
    let width: Int
    let height: Int
    
enum PhotoType: String, Codable{
           case m
           case o
           case p
           case q
           case r
           case s
           case w
           case x
           case y
           case z
       }
}

struct  ResponsePhotoData: Decodable  {
    var count: Int
    var items: [UserPhoto]
}

struct responsePhoto: Decodable {
    var response: ResponsePhotoData
}







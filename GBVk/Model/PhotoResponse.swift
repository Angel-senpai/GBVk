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
    var photo: [Photo]
    
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case photo = "sizes"
    }
    
    init(from decoder: Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try mainContainer.decode(Int.self, forKey: .id)
        self.photo = try mainContainer.decode([Photo].self, forKey: .photo)
    }
}

struct  ResponsePhotoData: Decodable  {
    var count: Int
    var items: [UserPhoto]
}

struct responsePhoto: Decodable {
    var response: ResponsePhotoData
}



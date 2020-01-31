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
        
        enum PhotoSizes: String, CodingKey {
            case type
            case url
            case width
            case height
        }
        
        init(from decoder: Decoder) throws {
            let mainContainer = try decoder.container(keyedBy: PhotoSizes.self)
            let photoType = try mainContainer.decode(PhotoType.self, forKey: .type)
            self.type = photoType
            self.url = try mainContainer.decode(String.self, forKey: .url)
            self.width = try mainContainer.decode(Int.self, forKey: .width)
            self.height = try mainContainer.decode(Int.self, forKey: .height)
        }
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case sizes
    }
    
    
    init(from decoder: Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
        let photoes = try mainContainer.decode([Photo].self, forKey: .sizes)
        self.id = try mainContainer.decode(Int.self, forKey: .id)
        self.photo = photoes
    }
    
}

struct  ResponsePhotoData: Decodable  {
    var count: Int
    var items: [UserPhoto]
}

struct responsePhoto: Decodable {
    var response: ResponsePhotoData
}



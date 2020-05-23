//
//  NewsResponse.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 18.05.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import Foundation

struct newsResponse: Decodable {
    var response: newsResponseData
}
struct newsResponseData: Decodable {
    var items: [newsData]
    var profiles:[profilesData]
    var groups:[groupsData]
    var next_from: String
}
struct profilesData: Decodable {
    var id: Int
    var firstName: String?
    var lastName: String?
    var photo: String
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_Name"
        case lastName = "last_Name"
        case photo = "photo_100"
    }
}
struct groupsData: Decodable {
    var id: Int
    var name: String
    var photo_100: String
}

struct newsData: Decodable {
    var source_id: Int
    var text: String?
    var attachments: [attachmentsData]?
    
    enum CodingKeys: String, CodingKey {
        case source_id
        case text
        case attachments
    }

    struct attachmentsData: Decodable {
        var id: Int?
        var photo: photoInfo?
        
        struct photoInfo: Decodable{
            var id: Int
            var photo: [Photo]
            enum CodingKeys: String, CodingKey {
                case id
                case photo = "sizes"
            }
        }
    }
    
}


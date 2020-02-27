//
//  User.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 03.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

struct UserResponse: Decodable {
    var id: Int
    var firstName: String
    var lastName: String
    var cityName: String
    var imageURL: URL?
    var fullName = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case city
    }
    
    enum CityKeys: String, CodingKey {
        case id
        case title
    }
    
    init(from decoder: Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        if mainContainer.contains(.city){
             let cityContainer = try mainContainer.nestedContainer(keyedBy: CityKeys.self, forKey: .city)
            self.cityName = try cityContainer.decode(String.self, forKey: .title)
        }else{
            self.cityName = ""
        }
        self.id = try mainContainer.decode(Int.self, forKey: .id)
        self.firstName = try mainContainer.decode(String.self, forKey: .firstName)
        self.lastName = try mainContainer.decode(String.self, forKey: .lastName)
        self.fullName = "\(firstName) \(lastName)"
    }

}

struct  ResponseUserData: Decodable  {
    var count: Int
    var items: [UserResponse]
    
    
}

struct responseUser: Decodable {
    var response: ResponseUserData
}

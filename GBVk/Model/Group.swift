//
//  Group.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 03.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

struct GroupVK: Decodable {
    var id: Int
    var name: String
    var isAdmin: Int

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isAdmin = "is_admin"
    }

    init(from decoder: Decoder) throws{
        let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try mainContainer.decode(Int.self, forKey: .id)
        self.name = try mainContainer.decode(String.self, forKey: .name)
         self.isAdmin = try mainContainer.decode(Int.self, forKey: .isAdmin)
    }
}


struct  ResponseGroupData: Decodable  {
    var count: Int
    var items: [GroupVK]
}

struct responseGroup: Decodable {
    var response: ResponseGroupData
}

class Group {
    
    var groupName:String
    var groupImage:String
    var isInGroup:Bool

    init( name: String, strImage: String = "dog" , inGroup: Bool = false) {
        
        groupName = name
        groupImage = strImage
        isInGroup = inGroup
        
    }
    
    
    
}

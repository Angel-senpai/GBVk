//
//  News.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 24.05.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import UIKit

class News {
    enum NewsType {
        case withPhoto,onlyText
    }
    
    var sourceId: Int
    var userName: String?
    var userPhotoUrl: String?
    var newsType: NewsType?
    var text: String
    var urlImage: [String]?
    
    var isLiked: Bool?
    var isReposted: Bool?
    
    init(sourceId:Int,text: String) {
        self.sourceId = sourceId
        self.text = text
    }
    
    
}

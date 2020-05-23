//
//  PhotoRealm.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 27.02.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import Foundation
import RealmSwift

/*class PhotoRealm: Object {
    @objc dynamic var albumId = 0
    @objc dynamic var date = 0
    @objc dynamic var id = 0
    @objc dynamic var ownerId = 0
    @objc dynamic var text: String = ""
    var sizes = List<PhotoSizesRealm>()
    @objc dynamic var extended: PhotoExtended =
    
    class PhotoExtended: Object{
        @objc dynamic var likes: Like?
        @objc dynamic var reposts = 0
        @objc dynamic var comments = 0
        
        class Like: Object{
            @objc dynamic var userLike = false
            @objc dynamic var count = 0
        }
    }
}

class PhotoSizesRealm: Object{
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
    
    init(type: PhotoType, url: String, width: Int , height: Int) {
        self.type = type
        self.url = url
        self.width = width
        self.height = height
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}*/



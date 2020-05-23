//
//  UserRealm.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 30.01.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import Foundation
import RealmSwift


class UserRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var cityName: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var fullName: String = ""
    
    var groups = List<GroupRealm>()
    
    override static func primaryKey() -> String? {
        return "id"
    }

}


//
//  User.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 03.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit


class User {
    
    var userName: String
    var userImage: String
    
    init( name: String, strImage: String = "dog") {
        userName = name
        userImage = strImage
    }
    
}

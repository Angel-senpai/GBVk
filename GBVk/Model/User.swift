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
    var userImage: UIImage
    
    init( name: String, image: UIImage = #imageLiteral(resourceName: "dog")) {
        userName = name
        userImage = image
    }
    
}

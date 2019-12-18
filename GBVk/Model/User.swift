//
//  User.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 03.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit


struct UserConfiguration {
    var firstName:String
    var lastName:String
    var age: Date
}

class User {
    
    var userConfig: UserConfiguration{
        willSet{
           fullName = self.userConfig.firstName + " " + self.userConfig.lastName
        }
    }
   private(set) var fullName: String = ""
    var userImage: String
    
    init( firstName: String,lastName: String,age: Date, strImage: String = "dog") {
        userConfig = UserConfiguration(firstName: firstName,
                                       lastName: lastName,
                                       age: age)
        fullName = self.userConfig.firstName + " " + self.userConfig.lastName
        userImage = strImage
    }
    
    
}

//
//  Group.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 03.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

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

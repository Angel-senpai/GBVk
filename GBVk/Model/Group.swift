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
    var groupImage:UIImage
    var isInGroup:Bool

    init( name: String, image: UIImage = #imageLiteral(resourceName: "dog") , inGroup: Bool = false) {
        
        groupName = name
        groupImage = image
        isInGroup = inGroup
        
    }
    
    
    
}

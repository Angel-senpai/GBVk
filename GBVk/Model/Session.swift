//
//  Session.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 16.01.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import Foundation

class  Session {
    static let instance = Session()
    
    private init(){}
    
    var token: String = ""
    var userId: String = ""
}

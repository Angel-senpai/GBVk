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
    @objc dynamic var fullName = ""
    
    var groups = List<GroupRealm>()
}


class UsersRepositoryRealm{
    func addUser(id: Int,firstName: String, lastName: String) {
        let realm = try? Realm()
        let newUser = UserRealm()
        newUser.id = id
        newUser.firstName = firstName
        newUser.lastName = lastName
        newUser.fullName = "\(firstName) \(lastName)"
        
        try? realm?.write {
            realm?.add(newUser)
        }
    }
    
    func getUser(id:Int) -> UserRealm?
    {
        let realm = try! Realm()
        return realm.objects(UserRealm.self).filter("id == %@",id).first
    }
}

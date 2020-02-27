//
//  UserRepository.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 03.02.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import RealmSwift

class UsersRepositoryRealm{
    
    func addUser(id: Int,
                 firstName: String,
                 lastName: String,
                 city: String,
                 photoURL: URL?) {
        let realm = try? Realm()
        let newUser = UserRealm()
        newUser.id = id
        newUser.firstName = firstName
        newUser.lastName = lastName
        newUser.cityName = city
        newUser.fullName = "\(firstName) \(lastName)"
        newUser.imageURL = photoURL
        try? realm?.write {
            realm?.add(newUser, update: .modified)
        }
        
    }
    
    
    func getUsers() -> [UserRealm] {
        let realm = try! Realm()
        let result = realm.objects(UserRealm.self)
        let arr: [UserRealm] = {
            var temp = [UserRealm]()
            result.forEach { (user) in
                temp.append(user)
            }
            return temp
        }()
        return arr
    }
    
    func getUser(id:Int) -> UserRealm?
    {
        let realm = try! Realm()
        return realm.objects(UserRealm.self).filter("id == %@",id).first
    }
}

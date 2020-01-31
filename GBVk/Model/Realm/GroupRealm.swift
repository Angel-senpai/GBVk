//
//  GroupRealm.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 31.01.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import Foundation
import RealmSwift

class GroupRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
}


class GroupRepositoryRealm{
    func addGroup(id: Int,name: String) {
        let realm = try? Realm()
        let newGroup = GroupRealm()
        newGroup.id = id
        newGroup.name = name
        
        try? realm?.write {
            realm?.add(newGroup)
        }
    }
    
    func getGropt(id:Int) -> GroupRealm?
    {
        let realm = try! Realm()
        return realm.objects(GroupRealm.self).filter("id == %@",id).first
    }
}

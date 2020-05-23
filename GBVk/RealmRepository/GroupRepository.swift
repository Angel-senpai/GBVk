//
//  GroupRepository.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 03.02.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import RealmSwift

class GroupRepositoryRealm{
    
    func addGroup(id: Int,name: String) {
        let realm = try? Realm()
        let newGroup = GroupRealm()
        newGroup.id = id
        newGroup.name = name
        
        try? realm?.write {
            realm?.add(newGroup,update: .modified)
        }
    }
    
    func getGroup() -> [GroupRealm] {
        let realm = try! Realm()
        let result = realm.objects(GroupRealm.self)
        let arr: [GroupRealm] = {
            var temp = [GroupRealm]()
            result.forEach { (group) in
                temp.append(group)
            }
            return temp
        }()
        return arr
    }
    
    func getGroup(id:Int) -> GroupRealm?
    {
        let realm = try! Realm()
        return realm.objects(GroupRealm.self).filter("id == %@",id).first
    }
}

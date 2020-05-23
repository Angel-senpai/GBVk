//
//  FriendsPresenter.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 29.02.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

protocol FriendsPresenter {
    
    var uiTable: UITableView! { get set }
    func viewDidLoad()
    func removeFriend(index: Int)
    func filterContentForSearchText(_ searchText: String)
    func getFiltredSection() -> [UserRealm]
    func getFriendSection() -> [UserRealm]
    func getUserProfilePhoto(user: UserRealm,completion: @escaping (UIImage?) -> Void )
}

struct Section<T> {
    var title: String
    var items: [T]
}

class FriendsPresenterImplementation: FriendsPresenter {
    func getUserProfilePhoto(user: UserRealm, completion: @escaping (UIImage?) -> Void) {
        vkAPI.getProfilePhoto(url: user.imageURL){
            completion($0)
        }
    }
    
    var uiTable: UITableView!

    func filterContentForSearchText(_ searchText: String){
        filteredFriend = friendList.filter{ (user) -> Bool in
            return user.fullName.lowercased().contains(searchText.lowercased())
        }
        /*
        filteredFriend = friendList.filter{
           return !$0.items.filter{ (user:UserRealm) -> Bool in
                return user.fullName.lowercased().contains(searchText.lowercased())
            }.isEmpty
        }*/
    }
    
    func removeFriend(index: Int) {
        dataBase.removeUser(user: friendList[index])
        friendList.remove(at: index)
    }

    func getFiltredSection() -> [UserRealm]{
        return filteredFriend
    }
    
    func getFriendSection() -> [UserRealm]{
        return friendList
    }
    
    
    
    private var vkAPI:vkApi
    private var dataBase:UsersRepositoryRealm
    //var friendSection = [Section<UserRealm>]()
    //var filtredSection = [Section<UserRealm>]()
    var friendList:[UserRealm] = []
    var filteredFriend: [UserRealm] = []
    var token: NotificationToken?
    
    init() {
        vkAPI = vkApi()
        dataBase = UsersRepositoryRealm()
    }
    
    func viewDidLoad() {
        getUsersDataBase()
        getUsersApi()
        friendList = dataBase.getUsers()
        
        let realm = try! Realm()
        let result = realm.objects(UserRealm.self)
        
        self.token = result.observe{ (changes: RealmCollectionChange) in
            self.friendList = self.dataBase.getUsers()
            switch changes{
            case .initial:
                self.uiTable.reloadData()
            case let .update(_, deletions, insertions, modifications):
                self.uiTable.beginUpdates()
                self.uiTable.insertRows(at: insertions.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                self.uiTable.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                self.uiTable.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                self.uiTable.endUpdates()
            case .error(let error):
                print(error)
            }
            
        }
    }
    func getUsersApi(){
            self.vkAPI.getFriendList(by: Session.instance.token, hundler: {
                switch $0{
                case .success(let users):
                    let userRep = UsersRepositoryRealm()
                    users.forEach{ user in
                        
                        if user.deactivated == nil{
                            userRep.addUser(id: user.id,
                            firstName: user.firstName,
                            lastName: user.lastName,
                            city: user.cityName,
                            photoURL: user.imageURL)
                        }
                    }
                case .failure:
                    break;
                }
            })
    }
    func getUsersDataBase(){
        friendList = dataBase.getUsers()
    }
    
}

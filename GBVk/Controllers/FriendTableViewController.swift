//
//  TableViewController.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 03.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

struct Section<T> {
    var title: String
    var items: [T]
}

class FriendTableViewController: UITableViewController {

    var friendSection = [Section<User>]()
    
    var list:[User] = [User(firstName: "Ivan",lastName: "Govorunov",age: Date(),strImage: "catWorking"), User(firstName: "Petya",lastName: "Boburov",age: Date())]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let friendDictionary = Dictionary.init(grouping: list){
            $0.userConfig.lastName.prefix(1)
        }
        
        friendSection = friendDictionary.map{Section(title: String($0.key), items: $0.value)}
        friendSection.sort{ $0.title < $1.title }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendSection.count
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendSection[section].items.count
    }
    
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell

        
        //cell.imageV.image = UIImage(named: list[indexPath.row].userImage)
        
        
        cell.shadowAvatar.image.image = UIImage(named: friendSection[indexPath.section].items[indexPath.row].userImage)
        cell.friendLabel.text = friendSection[indexPath.section].items[indexPath.row].fullName
        cell.friendImageView.layer.cornerRadius = cell.friendImageView.frame.width / 2
        cell.friendImageView.contentMode = .scaleAspectFit
        cell.friendImageView.layer.masksToBounds = true

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = list[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "PhotoCollection") as! PhotoCollectionController
        viewController.images.append(obj.userImage)
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendSection[section].title
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            
            self.list.remove(at: indexPath.row)
            self.tableView.reloadData()
            completionHandler(true)
        }
        delete.backgroundColor = #colorLiteral(red: 0.2656514049, green: 0.5078089237, blue: 0.7403514981, alpha: 1)
        let swipeAction = UISwipeActionsConfiguration(actions: [delete])
        //swipeAction.performsFirstActionWithFullSwipe = false // This is the line which disables full swipe
        return swipeAction
    }

}


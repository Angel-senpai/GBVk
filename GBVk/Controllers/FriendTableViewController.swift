//
//  TableViewController.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 03.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController {


    @IBAction func tap(_ sender: Any) {
        (sender as! LikeButton).like()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var list:[User] = [User(name: "Ivan",strImage: "catWorking"), User(name: "Petya")]

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        self.tableView.reloadData()
    }
    
    
    var index = 0
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell

        
        //cell.imageV.image = UIImage(named: list[indexPath.row].userImage)
        cell.shadowAvatar.image.image = UIImage(named: list[indexPath.row].userImage)
        cell.fLabel.text = list[indexPath.row].userName
        cell.imageV.layer.cornerRadius = cell.imageV.frame.width / 2
        cell.imageV.contentMode = .scaleAspectFit
        cell.imageV.layer.masksToBounds = true

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = list[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "PhotoCollection") as! PhotoCollectionController
        viewController.images.append(obj.userImage)
        self.navigationController?.pushViewController(viewController, animated: true)
        
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


//
//  GroupTableViewController.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 05.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {

    
    @IBAction func tapToButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "GlobalGroupTableViewController") as! GlobalGroupTableViewController
        
        viewController.tableList = groupList.filter{$0.isInGroup == false}
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    var groupList: [Group] = {
        var tempList: [Group] = []
        let strArr = ["Technologi","News","Memes"]
        let imageArr = ["catWorking","dogfacepalm","dogCoffee"]
        
        for _ in 0...20{
            tempList.append(Group(name: strArr.randomElement() ?? "Test",strImage: imageArr.randomElement() ?? "dog"))
        }
        
        return tempList
    }()
    
    
    var noInformationView: UIView!
    var tableList:[Group] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableList = groupList.filter{$0.isInGroup == true}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableList = groupList.filter{$0.isInGroup == true}
        tableView.reloadData()
    }

    
    func showNoInformationView() {
        noInformationView = UIView(frame: CGRect(origin: self.tableView.frame.origin,
                                                 size: self.tableView.frame.size))
        
    }

    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return tableList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell

        cell.groupImageV.image = UIImage(named:  tableList[indexPath.row].groupImage)
        cell.groupLabel.text = tableList[indexPath.row].groupName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
             
         let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            
             self.tableList[indexPath.row].isInGroup = false
             self.tableList.remove(at: indexPath.row)
             self.tableView.reloadData()
             completionHandler(true)
         }

         delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
         let swipeAction = UISwipeActionsConfiguration(actions: [delete])
         swipeAction.performsFirstActionWithFullSwipe = false // This is the line which disables full swipe
         return swipeAction
     }
    
    
}






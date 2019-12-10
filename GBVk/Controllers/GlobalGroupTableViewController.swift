//
//  GlobalGroupTableViewController.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 06.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

class GlobalGroupTableViewController: UITableViewController {


    var tableList:[Group] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return tableList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        

        cell.groupImageV.image = UIImage(named: tableList[indexPath.row].groupImage)
        cell.groupLabel.text = tableList[indexPath.row].groupName
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableList[indexPath.row].isInGroup = true
    }
    

}

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

    var friendSection = [Section<UserVK>]()
    var filtredSection = [Section<UserVK>]()
    let searchController = UISearchController(searchResultsController: nil)
    
    var friendList:[UserVK] = []
    var filteredFriend: [UserVK] = []
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Friends"
        searchController.searchBar.searchBarStyle = .minimal
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
        let friendDictionary = Dictionary.init(grouping: friendList){
            $0.fullName.prefix(1)
        }
        
        friendSection = friendDictionary.map{Section(title: String($0.key), items: $0.value)}
        friendSection.sort{ $0.title < $1.title }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return filtredSection.count
        }
        return friendSection.count
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filtredSection[section].items.count
        }
        return friendSection[section].items.count
    }
    
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        friendList.remove(at: indexPath.row)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell

        
        //cell.imageV.image = UIImage(named: list[indexPath.row].userImage)
        let user: UserVK
        
        if isFiltering{
            user = filtredSection[indexPath.section].items[indexPath.row]
        }else{
            user = friendSection[indexPath.section].items[indexPath.row]
        }
        
        //cell.shadowAvatar.image.image = UIImage(named: user.userImage)
        cell.friendLabel.text = user.fullName


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user:UserVK
        
        if isFiltering{
            user = filtredSection[indexPath.section].items[indexPath.row]
        }else{
            user = friendSection[indexPath.section].items[indexPath.row]
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "PhotoCollection") as! PhotoCollectionController
        //viewController.images.append(user.userImage)
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendSection[section].title
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            
            self.friendList.remove(at: indexPath.row)
            self.tableView.reloadData()
            completionHandler(true)
        }
        delete.backgroundColor = #colorLiteral(red: 0.2656514049, green: 0.5078089237, blue: 0.7403514981, alpha: 1)
        let swipeAction = UISwipeActionsConfiguration(actions: [delete])
        //swipeAction.performsFirstActionWithFullSwipe = false // This is the line which disables full swipe
        return swipeAction
    }
}

extension FriendTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    guard let searchBarText = searchBar.text else {return}
    filterContentForSearchText(searchBarText)
  }
    func filterContentForSearchText(_ searchText: String) {
        filtredSection = friendSection.filter{
           return !$0.items.filter{ (user:UserVK) -> Bool in
                return user.fullName.lowercased().contains(searchText.lowercased())
            }.isEmpty
        }
      
      tableView.reloadData()
    }
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
}

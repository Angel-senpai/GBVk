//
//  TableViewController.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 03.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit


class FriendTableViewController: UITableViewController {


    let searchController = UISearchController(searchResultsController: nil)
   
    
    var presenter: FriendsPresenter?
    
    
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FriendsPresenterImplementation()
        presenter?.viewDidLoad()
        presenter?.uiTable = self.tableView
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Friends"
        searchController.searchBar.searchBarStyle = .minimal
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return 1
        }
        return 1
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return presenter?.getFiltredSection().count ?? 0
        }
        return presenter?.getFriendSection().count ?? 0
    }
    
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let unpresentor = presenter else {
            return
        }
        unpresentor.removeFriend(index: indexPath.row)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell

        
        //cell.imageV.image = UIImage(named: list[indexPath.row].userImage)
        let user: UserRealm
        guard let unpresentor = presenter else {return UITableViewCell()}
            
        if isFiltering{
            user = unpresentor.getFiltredSection()[indexPath.row]
        }else{
            user = unpresentor.getFriendSection()[indexPath.row]
        }
        
        //cell.shadowAvatar.image.image = UIImage(named: user.userImage)
        cell.friendLabel.text = user.fullName
        presenter?.getUserProfilePhoto(user: user){
            cell.shadowAvatar.imageView.image = $0
        }
         return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var user: UserRealm
        guard let unpresentor = presenter else {return}
        if isFiltering{
            user = unpresentor.getFiltredSection()[indexPath.row]
        }else{
            user = unpresentor.getFriendSection()[indexPath.row]
        }
        print(user)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "PhotoCollection") as! PhotoCollectionController
        //viewController.images.append(user.userImage)
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let unpresentor = presenter else {return nil}
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            
            unpresentor.removeFriend(index: indexPath.row)
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
    guard let unpresentor = presenter else {return}
    unpresentor.filterContentForSearchText(searchBarText)
    tableView.reloadData()
  }
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
}

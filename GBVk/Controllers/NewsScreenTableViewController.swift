    //
//  new.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 17.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//


import UIKit

class NewsScreenTableViewController: UITableViewController {


    var newsCount = 1

    
    let user = User(firstName: "Petya", lastName: "Smirnov", age: Date(), strImage: "catWorking")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return newsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath) as! NewsViewCell
        
        cell.avatarShadow.image.image = UIImage(named: user.userImage)
        cell.userName.text = user.fullName
        cell.userImageView.layer.cornerRadius = cell.userImageView.frame.width / 2
        cell.userImageView.contentMode = .scaleAspectFit
        cell.userImageView.layer.masksToBounds = true
        
        cell.configure(with: UIImage(named: user.userImage)!)
        
        return cell
    }
    
    
    
}
    


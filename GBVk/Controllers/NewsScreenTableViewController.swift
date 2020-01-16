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
        let nib = UINib.init(nibName: "NewsViewCellWithPhoto", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsViewCellWithPhoto")
    }
    

    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return newsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCellWithPhoto", for: indexPath) as! NewsViewCellWithPhoto
        
        guard let image = UIImage(named: user.userImage) else {return cell}
        
        cell.configure(name:  user.fullName, with: image, collection: [image,image,image,image,image])
        
        return cell
    }
    
    
    
}
    


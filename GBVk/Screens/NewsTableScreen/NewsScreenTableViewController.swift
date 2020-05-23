    //
//  new.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 17.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//


import UIKit

class NewsScreenTableViewController: UITableViewController {


    var presenter: NewsPresenterImplimentation?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NewsPresenterImplimentation()
        presenter?.viewDidLoad()
        presenter?.updateClouser = {
            self.tableView.reloadData()
        }
        let nib = UINib.init(nibName: "NewsViewCellWithPhoto", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsViewCellWithPhoto")
    }
    

    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return presenter?.newsArray.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCellWithPhoto", for: indexPath) as! NewsViewCellWithPhoto
        if indexPath.row == (presenter?.newsArray.count ?? 1) - 1{
            presenter?.nextPage()
        }
        guard let news = presenter?.newsArray[indexPath.row] else {return cell}
        //guard let image = UIImage(named: user.userImage) else {return cell}
        presenter?.getInfo(owner: "\(news.source_id)" ){
            cell.configure(name: $0.name, with: $0.photo, collection: [])
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
    
}
    


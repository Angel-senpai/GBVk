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
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        let nibPhoto = UINib.init(nibName: "NewsViewCellWithPhoto", bundle: nil)
        tableView.register(nibPhoto, forCellReuseIdentifier: "NewsViewCellWithPhoto")
        
        let nib = UINib.init(nibName: "NewsViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsViewCell")
    }
    

    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return presenter?.news.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter?.dataSaver = DataSaver(container: tableView)
        if indexPath.row == (presenter?.news.count ?? 1) - 1{
            presenter?.nextPage()
        }
        
        guard let news = presenter?.news[indexPath.row] else {return UITableViewCell()}
        switch news.newsType {
        case .withPhoto:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCellWithPhoto", for: indexPath) as! NewsViewCellWithPhoto
            cell.configure(name: news.userName ?? "", with: presenter?.getPhoto(url: news.userPhotoUrl ?? "", indexPath: indexPath), text: news.text, collection: news.urlImage ?? [])
            print(cell.avatar.imageView.image)
            cell.selectionStyle = .none
            
            return cell
        case .onlyText:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath) as! NewsViewCell
            let userPhoto = presenter?.dataSaver?.photo(atIndexpath: indexPath, byUrl: news.userName ?? "")
            cell.configure(name: news.userName ?? "", with:userPhoto ?? UIImage(), text: news.text)
            cell.selectionStyle = .none
            
            return cell
        default:
            return UITableViewCell()
        }

    }
    
    
    
}
    


//
//  NewsViewCell.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 17.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var avatarShadow: CircleShadowImage!
    @IBOutlet weak var collectionView: UINewsCollectionView!
    
    var userImage: UIImage!
    
    func configure(with image: UIImage) {
        self.userImage = image
         self.collectionView.reloadData()
         self.collectionView.layoutIfNeeded()
     }
 
    
    @IBAction func like(_ sender: Any) {
        (sender as! LikeButton).like()
    }
    
    @IBAction func comment(_ sender: Any) {
         (sender as! CommentButton).commentary()
    }
    
    @IBAction func repost(_ sender: Any) {
        (sender as! RepostButton).repost()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension NewsViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionCell", for: indexPath) as! NewsCollectionViewCell
        cell.photoView.image = userImage
        return cell
    }
    
}



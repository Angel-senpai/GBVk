//
//  NewsViewCellWithPhoto.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 10.01.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import UIKit

class NewsViewCellWithPhoto: UITableViewCell {

    @IBOutlet weak var avatar: CircleShadowImage!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var likeButton: LikeButton!
    @IBOutlet weak var commentButton: CommentButton!
    @IBOutlet weak var repostButton: RepostButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isHeightCalculated: Bool = false
    var photoCollection: [UIImage] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoNewsCollection")
        
        // Initialization code
    }
    
    func configure(name: String,with image: UIImage, collection images: [UIImage]) {
        userName.text = name
        avatar.imageView.image = image
        photoCollection = images
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

extension NewsViewCellWithPhoto: UICollectionViewDelegate, UICollectionViewDataSource{
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoNewsCollection", for: indexPath) as! NewsCollectionViewCell
        cell.configurate(image: photoCollection[indexPath.row])
        return cell
    }

    func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
    
}

//
//  NewsViewCell.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 24.05.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {

   
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var avatarShadow: CircleShadowImage!
    @IBOutlet weak var newsTextLabel: UILabel!
    func configure(name: String,with image: UIImage, text: String) {
       userName?.text = name
       avatarShadow?.imageView.image = image
       newsTextLabel?.text = text
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





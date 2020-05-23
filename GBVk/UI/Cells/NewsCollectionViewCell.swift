//
//  NewsCollectionCell.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 10.01.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    var image: UIImage!{
        didSet{
            photo.image = image
        }
    }
    var photo: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photo = UIImageView(frame: self.frame)
        photo.frame.origin = CGPoint(x: 0, y: 0)
        addSubview(photo)
    }
    
    
    func configurate(image: UIImage) {
        self.image = image

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






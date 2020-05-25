//
//  NewsCollectionCell.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 10.01.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    var loadingView: LoadingView!
    var photo: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photo = UIImageView(frame: self.frame)
        photo.frame.origin = CGPoint(x: 0, y: 0)
        addSubview(photo)
        loadingView = LoadingView(frame: photo.frame)
        addSubview(loadingView)
    }
    
    override func prepareForReuse() {
        photo.image = UIImage()
    }
    
    func configurate(image: UIImage) {
        loadingView?.removeFromSuperview()
        self.photo.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






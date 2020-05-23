//
//  CircleShadowImage.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 10.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

class CircleShadowImage: UIView {
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .none
        addImage()
    }
    
    func changeImage(strUrl : String) {
        self.imageView = UIImageView(image: UIImage(contentsOfFile: strUrl))
        self.layoutSubviews()
    }
    
    private func addImage() {
        imageView = UIImageView(image: #imageLiteral(resourceName: "dog"))
       addSubview(imageView)
    }
    
    override func layoutSubviews() {
        imageView.frame = bounds
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4.0
        layer.shadowOffset = CGSize(width: 0, height: 1)
        
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.layer.masksToBounds = true
        
        
    }
}

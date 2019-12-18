//
//  CircleShadowImage.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 10.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

class CircleShadowImage: UIView {
    var image: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .none
        addImage()
    }
    
    func addImage() {
        image = UIImageView(image: #imageLiteral(resourceName: "dog"))
       addSubview(image)
    }
    
    override func layoutSubviews() {
        image.frame = bounds
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4.0
        layer.shadowOffset = CGSize(width: 0, height: 1)
        
        image.layer.cornerRadius = image.bounds.height / 2
        image.layer.masksToBounds = true
        
        
    }
}

//
//  likeButton.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 10.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

class LikeButton: UIButton {
    @IBInspectable var liked: Bool = false
    
    @IBInspectable var likeCount: Int = 0{
        didSet{
            setupDefault()
        }
    }
    
    func like() {
        liked.toggle()
        
        if liked{
            setLiked()
        }else{
            disableLike()
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupDefault()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefault()
    }

    private func setupDefault(){
        setImage(UIImage(named: "heart"), for: .normal)
        imageView?.backgroundColor = liked ? .red : .gray
        setTitle(String(describing: likeCount), for: .normal)
        tintColor = .red
        
        
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)
        imageView?.contentMode = .scaleAspectFit
        
    }
    
    private func setLiked(){
        likeCount += 1
        imageView?.backgroundColor = .red
        tintColor = .red
    }
    private func disableLike(){
        likeCount -= 1
        imageView?.backgroundColor = .gray
        tintColor = .gray
    }
}

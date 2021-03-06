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
        
        if liked{
            setImage(UIImage(systemName:  "heart.fill"), for: .normal)
            tintColor = .red
        }else{
            setImage(UIImage(systemName: "heart"), for: .normal)
            tintColor = .gray
        }
        
        
        setTitle(String(describing: likeCount), for: .normal)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        imageView?.contentMode = .scaleAspectFit
        
        
        
    }
    
    private func setLiked(){
        likeCount += 1
        setImage(UIImage(systemName:  "heart.fill"), for: .normal)

        tintColor = .red
    }
    private func disableLike(){
        likeCount -= 1
        
        setImage(UIImage(systemName: "heart"), for: .normal)

        tintColor = .gray
    }
}

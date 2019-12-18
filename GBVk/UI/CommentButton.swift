    //
//  CommentvIEW.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 18.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit
    
    
    
    class CommentButton: UIButton {
        @IBInspectable var comment: Bool = false
        
        @IBInspectable var commentCount: Int = 0{
            didSet{
                setupDefault()
            }
        }
        
        func commentary() {
            comment.toggle()
            
            if comment{
                setComment()
            }else{
                setUnComment()
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
            
            if comment{
                setImage(UIImage(systemName: "text.bubble"), for: .normal)
                tintColor = .blue
            }else{
                setImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
                tintColor = .gray
            }
            
            
            setTitle(String(describing: commentCount), for: .normal)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            imageView?.contentMode = .scaleAspectFit
            
            
            
        }
        
        private func setComment(){
            commentCount += 1
            setImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
            
            tintColor = .blue
        }
        private func setUnComment(){
            commentCount -= 1
            setImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
            
            tintColor = .gray
        }
    }

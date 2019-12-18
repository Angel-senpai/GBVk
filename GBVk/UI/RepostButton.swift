//
//  RepostView.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 18.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

class RepostButton: UIButton {
    
    @IBInspectable var reposted: Bool = false
    
    @IBInspectable var repostCount: Int = 0{
        didSet{
            setupDefault()
        }
    }
    
    func repost() {
        reposted.toggle()
        
        if reposted{
            setReposted()
        }else{
            unReposted()
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
        
        if reposted{
            setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
            tintColor = .blue
        }else{
            setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
            tintColor = .gray
        }
        
        
        setTitle(String(describing: repostCount), for: .normal)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        imageView?.contentMode = .scaleAspectFit
        
        
        
    }
    
    private func setReposted(){
        repostCount += 1
        setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        
        tintColor = .blue
    }
    private func unReposted(){
        repostCount -= 1
        setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        
        tintColor = .gray
    }
}

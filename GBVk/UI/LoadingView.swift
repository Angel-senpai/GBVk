//
//  LoadingView.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 18.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    
    var loadingViewLarge:CGFloat = 0.3

    private(set) var isAnimation = false{
        willSet(newValue){
            if newValue{
                self.isAnimation = newValue
                animation()
            }
        }
    }
    var firstView: UIView!
    var secondView: UIView!
    var thirdView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configuration()
    }
    
    
    func configuration(){
        createLoadingViews()
        startAnimation()
        print(isAnimation)
    }
    
    func createLoadingViews() {
        
        let frameViewWidth = self.bounds.width * loadingViewLarge
        
        firstView = UIView(frame: CGRect(origin: CGPoint(),
                                         size: CGSize(width: frameViewWidth,
                                                      height: frameViewWidth)))
        
        secondView =  UIView(frame: CGRect(origin: CGPoint(),
                                                size: CGSize(width: frameViewWidth,
                                                             height: frameViewWidth)))
        thirdView =  UIView(frame: CGRect(origin: CGPoint(),
                                                size: CGSize(width: frameViewWidth,
                                                             height: frameViewWidth)))
        
        let viewColor = #colorLiteral(red: 0.2656514049, green: 0.5078089237, blue: 0.7403514981, alpha: 1)
        firstView.backgroundColor = viewColor
        firstView.frame.origin.x = self.bounds.minX + frameViewWidth * 0.07
        firstView.center.y = self.frame.height / 2
        firstView.layer.cornerRadius = firstView.frame.height / 2
        firstView.layer.masksToBounds = true
        firstView.alpha = 0
        
        secondView.backgroundColor = viewColor
        secondView.frame.origin.x = firstView.frame.maxX + frameViewWidth * 0.1
        secondView.center.y = firstView.center.y
        secondView.layer.cornerRadius = secondView.frame.height / 2
        secondView.layer.masksToBounds = true
        secondView.alpha = 0
        
        thirdView.backgroundColor = viewColor
        thirdView.frame.origin.x = secondView.frame.maxX + frameViewWidth * 0.1
        thirdView.center.y = secondView.center.y
        thirdView.layer.cornerRadius = thirdView.frame.height / 2
        thirdView.layer.masksToBounds = true
        thirdView.alpha = 0
        
        
        self.addSubview(firstView)
        self.addSubview(secondView)
        self.addSubview(thirdView)
        
    }
    
    func startAnimation() {
        isAnimation = true
    }
    func stopAnimation() {
        isAnimation = false
    }
    
    func animation(){
        if isAnimation{
        UIView.animate(withDuration: 0.6,
                       animations: {self.firstView.alpha = 1.0 ; self.thirdView.alpha = 0 },
                       completion: { _ in
            if self.isAnimation{
                        UIView.animate(withDuration: 0.6,
                                       animations: { self.secondView.alpha = 1 ; self.firstView.alpha = 0},
                                       completion: { _ in
                            if self.isAnimation{
                                        UIView.animate(withDuration: 0.6,
                                                       animations: { self.thirdView.alpha = 1 ; self.secondView.alpha = 0},
                                                       completion: {  _ in
                                                        self.animation()
                                        })
                                        }})
                        
                        }})
        }}
}

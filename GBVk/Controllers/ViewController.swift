//
//  ViewController.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 25.11.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logginButton: UIButton!
    @IBOutlet weak var loginBox: UITextField!
    
    @IBOutlet weak var passwordBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logginButton.layer.backgroundColor = #colorLiteral(red: 0.2656514049, green: 0.5078089237, blue: 0.7403514981, alpha: 1)
        logginButton.layer.shadowRadius = 4
        logginButton.layer.shadowOpacity = 0.2
        logginButton.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        logginButton.layer.cornerRadius = logginButton.frame.height / 5
        
        loginBox.attributedPlaceholder = NSAttributedString(string: loginBox.placeholder!, attributes: [.foregroundColor : #colorLiteral(red: 0.5803921569, green: 0.5960784314, blue: 0.6156862745, alpha: 1)])
        passwordBox.attributedPlaceholder = NSAttributedString(string: passwordBox.placeholder!, attributes: [.foregroundColor : #colorLiteral(red: 0.5803921569, green: 0.5960784314, blue: 0.6156862745, alpha: 1)])
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonTouch(_ sender: Any){
        print("touch")
    }


}


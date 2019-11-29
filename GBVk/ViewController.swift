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
        
        logginButton.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        logginButton.layer.shadowRadius = 4
        logginButton.layer.shadowOpacity = 0.2
        logginButton.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        logginButton.layer.cornerRadius = logginButton.frame.height / 2
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonTouch(_ sender: Any){
        print("touch")
    }


}


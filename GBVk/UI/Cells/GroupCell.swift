//
//  GroupCell.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 05.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell  {
    

    @IBOutlet weak var groupImageV: UIImageView!
    @IBOutlet weak var groupLabel: UILabel!
    var button: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        
    }
    
}

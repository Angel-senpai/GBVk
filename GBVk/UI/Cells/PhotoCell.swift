//
//  GroupCell.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 03.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit



class PhotoCell: UICollectionViewCell  {
    
    
    @IBAction func tap(_ sender: Any) {
        print("tap")
    }
    
    @IBOutlet weak var photoView: UIImageView!

    
    
    
    override func prepareForReuse() {
        photoView = nil
    }
    
    
}

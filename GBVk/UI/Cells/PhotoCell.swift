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
        self.button.like()
    }
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var button: LikeButton!
    
    override func prepareForReuse() {
        photoView = nil
    }
    
}

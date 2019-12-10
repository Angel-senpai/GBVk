//
//  PhotoCollectionController.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 05.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

class PhotoCollectionController: UICollectionViewController {
    

    var images: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        if images.count > 0 { cell.photoView.image = UIImage(named: images[0])  }
        return cell
    }
}

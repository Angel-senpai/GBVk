//
//  UINewsCollectionView.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 19.12.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit

class UINewsCollectionView: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }

    }
    override var intrinsicContentSize: CGSize{
        return contentSize
    }

}

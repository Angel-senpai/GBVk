//
//  CustomFlow.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 13.01.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import UIKit

class  CustomCollectionViewLayout: UICollectionViewLayout {

    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
                                          // Хранит атрибуты для заданных индексов

    var columnsCount = 2                  // Количество столбцов

    private var totalCellsHeight: CGFloat = 0 // Хранит суммарную высоту всех ячеек
    

    override func prepare() {
        self.cacheAttributes = [:] // Инициализируем атрибуты
     
        // Проверяем наличие collectionView
        guard let collectionView = self.collectionView else { return }
        
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        // Проверяем, что в секции есть хотя бы одна ячейка
        guard itemsCount > 0 else { return }
        var cellWidth:CGFloat = 0.0
        var cellHeight: CGFloat = 0.0
        let temp:CGFloat = CGFloat(1.0 / Double(itemsCount))
        switch itemsCount {
        case 1:
            cellWidth = collectionView.frame.width
            cellHeight = collectionView.frame.height
        case 2:
            cellWidth = collectionView.frame.width * temp
            cellHeight = collectionView.frame.height
        case 3:
            cellWidth = collectionView.frame.width * 0.5
            cellHeight = cellWidth
        case 4:
            cellWidth = collectionView.frame.width * 0.5
            cellHeight = cellWidth
        default:
            cellWidth = collectionView.frame.width * 0.5
            cellHeight = cellWidth
            break
        }


        var lastY: CGFloat = 0
        var lastX: CGFloat = 0
        
        for index in 0..<itemsCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            if itemsCount == 3 && index == 2{
                cellWidth = collectionView.frame.width
                lastX = 0
                cellHeight = cellWidth / 2
            }
            attributes.frame = CGRect(x: lastX, y: lastY,
                                      width: cellWidth, height: cellHeight)
            
            let isLastColumn = (index + 2) % (self.columnsCount + 1) == 0 || index == itemsCount - 1
            if isLastColumn {
                lastY += cellHeight
                lastX = 0
            } else {
                lastX += attributes.frame.maxX
            }
            
            
            
            cacheAttributes[indexPath] = attributes
            
            self.totalCellsHeight = lastY
        }
        
        
        
        
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttributes.values.filter { attributes in
            return rect.intersects(attributes.frame)
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttributes[indexPath]
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView?.frame.width ?? 0,
                      height: self.totalCellsHeight)
    }

    
}

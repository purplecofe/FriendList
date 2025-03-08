//
//  OverlapLayout.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/6.
//

import UIKit

class OverlapLayout: UICollectionViewLayout {
    
    private var attributesArray: [UICollectionViewLayoutAttributes] = []
    private var contentSize: CGSize = .zero
    
    var cardSize = CGSize(width: 100, height: 80)
    var overlapOffset: CGFloat = 10
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let itemCount = collectionView.numberOfItems(inSection: 0)
        attributesArray.removeAll()
        
        var maxY: CGFloat = 0
        
        for item in 0..<itemCount {
            let scale: CGFloat = (item == 0) ? 1.0 : 0.95
            let indexPath = IndexPath(item: item, section: 0)
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let itemWidth = cardSize.width * scale
            let itemHeight = cardSize.height
            
            let xPos: CGFloat = (collectionView.bounds.width - itemWidth) / 2
            let yPos: CGFloat = 4 + CGFloat(item) * overlapOffset
            
            attrs.frame = CGRect(x: xPos, y: yPos, width: itemWidth, height: itemHeight)
            
            attrs.zIndex = itemCount - item
            
            let bottomY = yPos + cardSize.height
            if bottomY > maxY {
                maxY = bottomY
            }
            
            attributesArray.append(attrs)
        }
        contentSize = CGSize(width: cardSize.width, height: maxY)
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesArray[indexPath.item]
    }
}

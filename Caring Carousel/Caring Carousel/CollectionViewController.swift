//
//  ViewController.swift
//  Caring Carousel
//
//  Created by Admin on 25.07.2023.
//

import UIKit

class Layout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .horizontal
        itemSize = .init(width: 280, height: 400)
        sectionInsetReference = .fromLayoutMargins
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else {return
            super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)}
        
        let horizontalOffset = proposedContentOffset.x
        let targetRect = CGRect.init(origin: .init(x: proposedContentOffset.x, y: 0), size: collectionView.bounds.size)
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        
        
        for layoutAttributes in super.layoutAttributesForElements(in: targetRect)! {
            let itemOffset = layoutAttributes.frame.origin.x
            if abs(itemOffset - horizontalOffset) < abs(offsetAdjustment) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        }
//        var newOffset = proposedContentOffset
//
//               if velocity.x > 0 {
//                   newOffset.x += offsetAdjustment + 10
//               } else if velocity.x < 0 {
//                   newOffset.x -= offsetAdjustment + 10
//               } else {
//                   let currentCenter = collectionView.contentOffset.x + collectionView.bounds.width / 2
//                   if currentCenter > (collectionView.contentSize.width - collectionView.bounds.width) / 2 {
//                       newOffset.x = collectionView.contentSize.width - collectionView.bounds.width
//                   } else {
//                       newOffset.x = 0
//                   }
//               }
//
//               let visibleRect = CGRect(x: newOffset.x, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height)
//               guard let newLayoutAttributes = layoutAttributesForElements(in: visibleRect) else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
//
//               var smallestDistance = CGFloat.greatestFiniteMagnitude
//               for layoutAttributes in newLayoutAttributes {
//                   let itemCenter = layoutAttributes.frame.origin.x
//                   let distance = abs(itemCenter - horizontalOffset)
//                   if distance < smallestDistance {
//                       smallestDistance = distance
//                       newOffset.x = layoutAttributes.frame.origin.x - 10
//                   }
//               }
//
//               return newOffset

        return CGPoint.init(x: proposedContentOffset.x + offsetAdjustment - collectionView.layoutMargins.left, y: proposedContentOffset.y)
        }
}




class CollectionViewController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: Layout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Collection"
        
        view.preservesSuperviewLayoutMargins = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
       
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGroupedBackground
        cell.layer.cornerCurve = .continuous
        cell.layer.cornerRadius = 12
        return cell
    }
}


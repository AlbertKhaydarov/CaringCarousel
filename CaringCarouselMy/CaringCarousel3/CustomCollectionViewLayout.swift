//
//  PagingCollectionViewLayout.swift
//  CaringCarousel3
//
//  Created by Admin on 27.07.2023.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    private let numberTargetScroll: CGFloat = 2
    private let numberOfItemsPerPage: CGFloat = 1

    override init() {
        super.init()
        self.itemSize = CGSize(width: 300, height: 400)
        self.minimumLineSpacing = 16
        self.scrollDirection = .horizontal
        self.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }

        let pageLength: CGFloat
        let approxPage: CGFloat
        let currentPage: CGFloat
        let speed: CGFloat

        if scrollDirection == .horizontal {
            pageLength = (self.itemSize.width + self.minimumLineSpacing) * numberOfItemsPerPage
            approxPage = collectionView.contentOffset.x / pageLength
            speed = velocity.x}
    else {
            pageLength = (self.itemSize.height + self.minimumLineSpacing) * numberOfItemsPerPage
            approxPage = collectionView.contentOffset.y / pageLength
            speed = velocity.y
        }

        if speed < 0 {
            currentPage = ceil(approxPage)
        } else if speed > 0 {
            currentPage = floor(approxPage)
        } else {
            currentPage = round(approxPage)
        }

        guard speed != 0 else {
            if scrollDirection == .horizontal {
                return CGPoint(x: currentPage * pageLength, y: 0)
            } else {
                return CGPoint(x: 0, y: currentPage * pageLength)
            }
        }

        var nextPage: CGFloat = currentPage + (speed > 0 ? 1 : -1)

        let increment = speed / numberTargetScroll
        nextPage += (speed < 0) ? ceil(increment) : floor(increment)

        if scrollDirection == .horizontal {
            return CGPoint(x: nextPage * pageLength, y: 0)
        } else {
            return CGPoint(x: 0, y: nextPage * pageLength)
        }
    }
}

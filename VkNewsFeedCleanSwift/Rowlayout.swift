//
//  Rowlayout.swift
//  VkNewsFeedCleanSwift
//
//  Created by Артем Орлов on 27.11.2022.
//

import UIKit

protocol RowLayoutDelegate: AnyObject {

    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize

}

class Rowlayout: UICollectionViewLayout {

    weak var delegate: RowLayoutDelegate!

    fileprivate var numbersOfRows = 1
    fileprivate var cellPadding: CGFloat = 8

    fileprivate var cache = [UICollectionViewLayoutAttributes]()

    fileprivate var contentWidth: CGFloat = 0
    fileprivate var contentHeigh: CGFloat {

        guard let collectionView = collectionView else { return 0 }

        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: contentHeigh)
    }

    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else { return }

        var  photos = [CGSize]()
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photos.append(photoSize)
        }

        let superVeiwWidth = collectionView.frame.width

        guard let rowHeight = self.rowHeightCounter(superViewWidth: superVeiwWidth, photosArray: photos) else { return }
    }

    private func rowHeightCounter(superViewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat? {
        var rowHeigh: CGFloat

        let photoWidthMinRatio = photosArray.min { first, second in
            (first.height / first.width) < (second.height / second.width)
        }

        guard let myPhotoWidthMinRatio = photoWidthMinRatio else { return nil }

        let difference = superViewWidth / myPhotoWidthMinRatio.width

        rowHeigh = myPhotoWidthMinRatio.height * difference

        return rowHeigh
    }
}

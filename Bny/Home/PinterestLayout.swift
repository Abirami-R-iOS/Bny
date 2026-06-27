//
//  PinterestLayout.swift
//  Bny
//
//  Created by Abirami on 24/06/26.
//

import Foundation
import UIKit

protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {

    weak var delegate: PinterestLayoutDelegate?

    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 8

    private var cache: [UICollectionViewLayoutAttributes] = []

    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {

        guard cache.isEmpty, let collectionView = collectionView else {
            return
        }

        let columnWidth = contentWidth / CGFloat(numberOfColumns)

        var xOffset: [CGFloat] = []

        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }

        var column = 0

        var yOffset = Array(repeating: CGFloat(0), count: numberOfColumns)

        for item in 0..<collectionView.numberOfItems(inSection: 0) {

            let indexPath = IndexPath(item: item, section: 0)

            let photoHeight = delegate?.collectionView(collectionView, heightForPhotoAt: indexPath) ?? 180

            let annotationHeight: CGFloat = 120

            let height = cellPadding * 2 + photoHeight + annotationHeight

            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)

            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

            attributes.frame = insetFrame

            cache.append(attributes)

            contentHeight = max(contentHeight, frame.maxY)

            yOffset[column] = yOffset[column] + height

            column = yOffset[0] < yOffset[1] ? 0 : 1
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        return cache.filter {
            $0.frame.intersects(rect)
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

        return cache[indexPath.item]
    }
}

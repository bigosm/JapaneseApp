//
//  CharacterCollectionLayout.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 06/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final class CharacterCollectionLayout: UICollectionViewLayout {
    
    private var cachedAttributes: [UICollectionViewLayoutAttributes] = []
    private var contentBounds: CGRect!
    
    override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }
    
//    override func prepare() {
//        super.prepare()
//
//        guard let collectionView = collectionView else { return }
//
//        // Reset cached information.
//        cachedAttributes.removeAll()
//        contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
//
//        // For every item in the collection view:
//        //  - Prepare the attributes.
//        //  - Store attributes in the cachedAttributes array.
//        //  - Combine contentBounds with attributes.frame.
//        let count = collectionView.numberOfItems(inSection: 0)
//
//        var currentIndex = 0
//        var segment: MosaicSegmentStyle = .fullWidth
//        var lastFrame: CGRect = .zero
//
//        let cvWidth = collectionView.bounds.size.width
//
//        while currentIndex < count {
//            let segmentFrame = CGRect(x: 0, y: lastFrame.maxY + 1.0, width: cvWidth, height: 200.0)
//
//            var segmentRects = [CGRect]()
//            switch segment {
//            case .fullWidth:
//                segmentRects = [segmentFrame]
//
//            case .fiftyFifty:
//                let horizontalSlices = segmentFrame.dividedIntegral(fraction: 0.5, from: .minXEdge)
//                segmentRects = [horizontalSlices.first, horizontalSlices.second]
//
//            case .twoThirdsOneThird:
//                let horizontalSlices = segmentFrame.dividedIntegral(fraction: (2.0 / 3.0), from: .minXEdge)
//                let verticalSlices = horizontalSlices.second.dividedIntegral(fraction: 0.5, from: .minYEdge)
//                segmentRects = [horizontalSlices.first, verticalSlices.first, verticalSlices.second]
//
//            case .oneThirdTwoThirds:
//                let horizontalSlices = segmentFrame.dividedIntegral(fraction: (1.0 / 3.0), from: .minXEdge)
//                let verticalSlices = horizontalSlices.first.dividedIntegral(fraction: 0.5, from: .minYEdge)
//                segmentRects = [verticalSlices.first, verticalSlices.second, horizontalSlices.second]
//            }
//
//            // Create and cache layout attributes for calculated frames.
//            for rect in segmentRects {
//                let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: currentIndex, section: 0))
//                attributes.frame = rect
//
//                cachedAttributes.append(attributes)
//                contentBounds = contentBounds.union(lastFrame)
//
//                currentIndex += 1
//                lastFrame = rect
//            }
//
//            // Determine the next segment style.
//            switch count - currentIndex {
//            case 1:
//                segment = .fullWidth
//            case 2:
//                segment = .fiftyFifty
//            default:
//                switch segment {
//                case .fullWidth:
//                    segment = .fiftyFifty
//                case .fiftyFifty:
//                    segment = .twoThirdsOneThird
//                case .twoThirdsOneThird:
//                    segment = .oneThirdTwoThirds
//                case .oneThirdTwoThirds:
//                    segment = .fiftyFifty
//                }
//            }
//        }
//    }
}

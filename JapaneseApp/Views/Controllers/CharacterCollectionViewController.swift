//
//  CharacterCollectionView.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 06/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class CharacterCollectionViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    private var cellIdentifier = "cellIdentifier"
    public var collectionView: UICollectionView {
        return self.view as! UICollectionView
    }
    
    public var content: [String] = ["僕","の","名前","は","ミ","ハ","ル","や","さ","い","す","み","ま","せ","ん","こ","何","を"]
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        self.view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        self.collectionView.register(CharacterCollectionCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.setupView()
    }
    
    // MARK: - Instance Methods
    
    // MARK: - View Position Layout
    
    private func setupView() {

    }
}

extension CharacterCollectionViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.content.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! CharacterCollectionCell
        
        cell.titleLabel.text = content[indexPath.row]
        switch indexPath.row {
        case 0: cell.someLabel.text = "ぼく"
        case 2: cell.someLabel.text = "なまえ"
        case 16: cell.someLabel.text = "なに"
        default:
            ()
        }
        
        return cell
    }
    
    
}

extension CharacterCollectionViewController: UICollectionViewDelegate {
    
}



//
//  CharacterCollectionCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 06/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class CharacterCollectionCell: UICollectionViewCell {

    // MARK: - Instance Properties
    
    private let chracaterVC = PracticeCharacterViewController()

    // MARK: - Object Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Instance Methods
    
    public func configureWith(characterAtIndex index: Int) {
        self.chracaterVC.configureWith(characterAtIndex: index)
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.addSubview(self.chracaterVC.view)

        self.chracaterVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.chracaterVC.view.topAnchor.constraint(equalTo: self.topAnchor),
            self.chracaterVC.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.chracaterVC.view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.chracaterVC.view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
}



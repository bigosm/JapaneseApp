//
//  CharacterCollectionCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 06/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class CharacterCollectionCell: UICollectionViewCell {
    
    // MARK: - Object Lifecycle
    
    public var titleLabel = UILabel()
    public var someLabel = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel.font = .systemFont(ofSize: 30)
        self.someLabel.font = .systemFont(ofSize: 20)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.someLabel)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.someLabel.bottomAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.someLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.someLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.someLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.someLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.someLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}



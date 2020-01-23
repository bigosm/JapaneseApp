//
//  AnswerCollectionCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class AnswerCollectionCell: UICollectionViewCell {
    
    // MARK: - Theme
    
    private var themeBackgroundColor = Theme.secondaryBackgroundColor
    private var themeSelectedColor = Theme.tertiaryBackgroundColor
    
    // MARK: - Instance Properties
    
    public var answerLabel = UILabel()
    
    public override var isSelected: Bool {
        didSet {
            self.backgroundColor = self.isSelected
                ? self.themeSelectedColor
                : self.themeBackgroundColor
        }
    }
    
    // MARK: - Object Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = self.themeBackgroundColor
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
        self.answerLabel.adjustsFontSizeToFitWidth = true
        self.answerLabel.font = .preferredFont(forTextStyle: .largeTitle)
        self.answerLabel.textAlignment = .center

        self.setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    public func configure(with answer: String) {
        self.answerLabel.text = answer
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.addSubview(self.answerLabel)
        
        self.answerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.answerLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.answerLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.answerLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.answerLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
}


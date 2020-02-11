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
    
    private let viewModel: CharacterCellViewModelType = CharacterCellViewModel()
    
    public let characterView = CharacterView(readingAidDirection: .vertical)
    
    // MARK: - Object Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.characterView.titleLabel.font = .systemFont(ofSize: 25)
        self.characterView.readingAidLabel.font = .systemFont(ofSize: 17)
        self.characterView.underlineView.backgroundColor = Theme.tertiaryBackgroundColor
        
        self.setupView()
        self.bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.viewModel.inputs.prepareForReuse()
    }
    
    // MARK: Instance Methods
    
    public func configureWith(characterAtIndex index: Int) {
        self.viewModel.inputs.configureWith(characterAtIndex: index)
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        self.viewModel.outputs.title.addObserver(self, options: [.new]) { [weak self] value, _ in
            self?.characterView.titleLabel.text = value
        }
        
        self.viewModel.outputs.readingAid.addObserver(self, options: [.new]) { [weak self] value, _ in
            self?.characterView.readingAidLabel.text = value
        }
        
        self.viewModel.outputs.readingAidVisibility.addObserver(self, options: [.initial, .new]) { [weak self] value, _ in
            guard let self = self else { return }
            self.characterView.isReadingAidVisible = value
        }
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.addSubview(self.characterView)

        self.characterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.characterView.topAnchor.constraint(equalTo: self.topAnchor),
            self.characterView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.characterView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.characterView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
}



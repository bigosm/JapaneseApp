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
    
    public let stackView = UIStackView()
    public let titleLabel = UILabel()
    public let readingAidLabel = UILabel()
    public let underlineView = UIView()
    
    // MARK: - Object Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.stackView.axis = .vertical
        self.titleLabel.font = .systemFont(ofSize: 25)
        self.readingAidLabel.font = .systemFont(ofSize: 17)
        
        self.underlineView.backgroundColor = Theme.tertiaryBackgroundColor
        
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
            self?.titleLabel.text = value
        }
        
        self.viewModel.outputs.readingAid.addObserver(self, options: [.new]) { [weak self] value, _ in
            self?.readingAidLabel.text = value
        }
        
        self.viewModel.outputs.readingAidVisibility.addObserver(self, options: [.initial, .new]) { [weak self] value, _ in
            guard let self = self else { return }
            self.readingAidLabel.isHidden = !value
             if value && !self.stackView.arrangedSubviews.contains(self.readingAidLabel) {
                self.stackView.insertArrangedSubview(self.readingAidLabel, at: 0)
            } else if !value {
                self.stackView.removeArrangedSubview(self.readingAidLabel)
            }
        }
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.addSubview(self.underlineView)
    
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        self.readingAidLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.readingAidLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
 
        self.underlineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.underlineView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 2),
            self.underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            self.underlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            self.underlineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            self.underlineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
}



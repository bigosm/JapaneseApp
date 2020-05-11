//
//  SelectAnswerCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 27/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class SelectAnswerCell: UITableViewCell {
    
    // MARK: - Instance Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: SelectAnswerCellViewModelType = SelectAnswerCellViewModel()
    
    private let container = UIView()
    public let answerFeedLabel = UILabel()
    
    public override var isSelected: Bool {
        didSet {
            self.container.backgroundColor = self.isSelected
                ? Theme.primaryColor
                : Theme.secondaryBackgroundColor
        }
    }
    
    // MARK: - Object Lifecycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.container.layer.cornerRadius = 20
        self.container.backgroundColor = Theme.secondaryBackgroundColor
        self.answerFeedLabel.font = .systemFont(ofSize: 20)
        
        self.setupView()
        self.bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Instance Methods
    
    public func configureWith(answerFeedAtIndex index: Int) {
        self.viewModel.inputs.configureWith(answerFeedAtIndex: index)
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel.outputs.answerFeed.bind { [weak self] value in
            self?.answerFeedLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.isSelected.bind { [weak self] value in
            self?.isSelected = value
        }.disposed(by: disposeBag)
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.addSubview(self.container)
        self.container.addSubview(answerFeedLabel)
        
        self.container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.container.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.answerFeedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.answerFeedLabel.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 15),
            self.answerFeedLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 15),
            self.answerFeedLabel.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -15),
            self.answerFeedLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -15)
        ])
    }
    
}

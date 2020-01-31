//
//  QuestionHistoryCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 23/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class QuestionHistoryCell: UITableViewCell {
    
    // MARK: - Theme
    
    private var themeBackgroundColor = Theme.secondaryBackgroundColor
    private var themeAlertBackgroundColor = Theme.alertColor
    private var themeTintColor = Theme.primaryColor
    
    // MARK: - Instance Properties
    
    public var titleLabel = UILabel()
    public var selectedAnswerLabel = UILabel()
    public var isCorrect: Bool! {
        didSet {
            self.isCorrectImageView.image = self.isCorrect
                ? UIImage(named: "round_done_24pt")
                : UIImage(named: "round_clear_24pt")
            self.backgroundColor = self.isCorrect
                ? self.themeBackgroundColor
                : self.themeAlertBackgroundColor
        }
    }
    public var isCorrectImageView = UIImageView()
    
    // MARK: - Object Lifecycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.titleLabel.font = .preferredFont(forTextStyle: .headline)
        self.titleLabel.numberOfLines = 0
        self.isCorrectImageView.tintColor = self.themeTintColor
        
        self.setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.selectedAnswerLabel)
        self.addSubview(self.isCorrectImageView)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
        
        self.selectedAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.selectedAnswerLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.selectedAnswerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.selectedAnswerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.selectedAnswerLabel.trailingAnchor.constraint(equalTo: self.isCorrectImageView.leadingAnchor, constant: -10)
        ])
        
        self.isCorrectImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.isCorrectImageView.topAnchor.constraint(equalTo: self.selectedAnswerLabel.topAnchor),
            self.isCorrectImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
}

//
//  QuestionCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 21/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class QuestionCell: UICollectionViewCell {
    
    // MARK: - Theme
    
    private var themeBackgroundColor = Theme.primaryBackgroundColor
    
    // MARK: - Instance Properties
    
    public var promptController = PromptViewController()
    public var answerController = AnswerViewController()
    
    // MARK: - Object Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = self.themeBackgroundColor
        
        self.setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    public func configure(with question: Question, feed: [String]) {
        self.promptController.set(prompt: question.prompt)
        self.answerController.configure(with: feed)
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        let promptView = self.promptController.view!
        let answerView = self.answerController.view!
        self.addSubview(promptView)
        self.addSubview(answerView)

        promptView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            promptView.topAnchor.constraint(equalTo: self.topAnchor,constant: 20),
            promptView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            promptView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
            promptView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])

        answerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerView.topAnchor.constraint(equalTo: promptView.bottomAnchor, constant: 20),
            answerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            answerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            answerView.heightAnchor.constraint(equalToConstant: 420)
        ])
    }
    
}

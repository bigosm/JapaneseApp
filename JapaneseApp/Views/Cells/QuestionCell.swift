//
//  QuestionCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 21/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class QuestionCell: UICollectionViewCell {
    
    // MARK: - Instance Properties
    
    public var promptController = PromptViewController()
    public var answerController = AnswerViewController()
    
    // MARK: - Object Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        let promptView = self.promptController.view!
        self.addSubview(promptView)
        promptView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            promptView.topAnchor.constraint(equalTo: self.topAnchor,constant: 20),
            promptView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            promptView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            promptView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20)
        ])
        
        let answerView = self.answerController.view!
        self.addSubview(answerView)
        answerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerView.topAnchor.constraint(equalTo: promptView.bottomAnchor, constant: 20),
            answerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            answerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            answerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

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
    
}

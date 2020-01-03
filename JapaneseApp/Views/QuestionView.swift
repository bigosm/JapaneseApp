//
//  QuestionView.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class QuestionView: UIView {
    
    public var prompLabel = UILabel()
    public var answerLabel = UILabel()
    
    public var correctButton = UIButton()
    public var correctLabel = UILabel()
    public var incorrectButton = UIButton()
    public var incorrectLabel = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.prompLabel.textAlignment = .center
        self.prompLabel.numberOfLines = 0
        self.prompLabel.font = .preferredFont(forTextStyle: .largeTitle)
        self.answerLabel.textAlignment = .center
        self.answerLabel.numberOfLines = 0
        self.answerLabel.font = .preferredFont(forTextStyle: .headline)
        
        self.correctButton.setImage(UIImage(named: "round_done_48pt"), for: .normal)
        self.correctButton.tintColor = UIColor.init(named: "primaryColor")
        self.incorrectButton.setImage(UIImage(named: "round_clear_48pt"), for: .normal)
        self.incorrectButton.tintColor = UIColor.init(named: "primaryColor")
        
        self.correctLabel.textAlignment = .center
        self.correctLabel.font = .boldSystemFont(ofSize: 20)
        self.incorrectLabel.textAlignment = .center
        self.incorrectLabel.font = .boldSystemFont(ofSize: 20)
        
        self.addSubview(self.prompLabel)
        self.prompLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.prompLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            self.prompLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.prompLabel.heightAnchor.constraint(equalToConstant: 50),
            self.prompLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.addSubview(self.answerLabel)
        self.answerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.answerLabel.topAnchor.constraint(equalTo: self.prompLabel.bottomAnchor),
            self.answerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.answerLabel.heightAnchor.constraint(equalToConstant: 50),
            self.answerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.addSubview(self.correctButton)
        self.correctButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.correctButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            self.correctButton.widthAnchor.constraint(equalToConstant: 80),
            self.correctButton.heightAnchor.constraint(equalToConstant: 80),
            self.correctButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.addSubview(self.correctLabel)
        self.correctLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.correctLabel.bottomAnchor.constraint(equalTo: self.correctButton.topAnchor, constant: -5),
            self.correctLabel.widthAnchor.constraint(equalTo: self.correctButton.widthAnchor),
            self.correctLabel.heightAnchor.constraint(equalToConstant: 30),
            self.correctLabel.leadingAnchor.constraint(equalTo: self.correctButton.leadingAnchor)
        ])
        
        self.addSubview(self.incorrectButton)
        self.incorrectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.incorrectButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            self.incorrectButton.widthAnchor.constraint(equalToConstant: 80),
            self.incorrectButton.heightAnchor.constraint(equalToConstant: 80),
            self.incorrectButton.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        self.addSubview(self.incorrectLabel)
        self.incorrectLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.incorrectLabel.bottomAnchor.constraint(equalTo: self.incorrectButton.topAnchor, constant: -5),
            self.incorrectLabel.widthAnchor.constraint(equalTo: self.incorrectButton.widthAnchor),
            self.incorrectLabel.heightAnchor.constraint(equalToConstant: 30),
            self.incorrectLabel.leadingAnchor.constraint(equalTo: self.incorrectButton.leadingAnchor)
        ])
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

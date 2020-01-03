//
//  QuestionViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class QuestionViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    public var questionGroup = QuestionGroup.katakana()
    public var questionIndex = 0
    public var correctCount = 0
    public var incorrectCount = 0
    
    public var questionView = QuestionView()

    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(named: "background")
        
        self.view.addSubview(self.questionView)
        self.questionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.questionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.questionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.questionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.questionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        self.questionView.correctButton.addTarget(self, action: #selector(self.handleCorrect(_:)), for: .touchUpInside)
        self.questionView.incorrectButton.addTarget(self, action: #selector(self.handleIncorrect(_:)), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.toggleAnsweLabel(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.showQuestion()
    }
    
    // MARK: - Actions
    
    @objc func handleCorrect(_ sender: Any) {
        self.correctCount += 1
        self.showNextQuestion()
    }
    @objc func handleIncorrect(_ sender: Any) {
        self.incorrectCount += 1
        self.showNextQuestion()
    }
    
    @objc func toggleAnsweLabel(_ sender: Any) {
        self.questionView.answerLabel.isHidden.toggle()
    }
 
    // MARK: - Private
    
    private func showQuestion() {
        let question = self.questionGroup.questions[questionIndex]
        self.questionView.prompLabel.text = question.prompt
        self.questionView.answerLabel.text = question.answer
        self.questionView.correctLabel.text = "\(self.correctCount)"
        self.questionView.incorrectLabel.text = "\(self.incorrectCount)"
        self.questionView.answerLabel.isHidden = true
    }
    
    private func showNextQuestion() {
        self.questionIndex += 1
        
        guard self.questionIndex < self.questionGroup.questions.count else {
            /// - TODO: Handle this...!
            return
        }
        
        self.showQuestion()
    }

}


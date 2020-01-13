//
//  QuestionViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

// MARK: - QuestionViewControllerDelegate

public protocol QuestionViewControllerDelegate: AnyObject {
    
    func questionViewController(
        _ controller: QuestionViewController,
        didCancel questionStrategy: QuestionStrategy)
    
    func questionViewController(
        _ controller: QuestionViewController,
        didComplete questionStrategy: QuestionStrategy)
    
}

public class QuestionViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    public var questionStrategy: QuestionStrategy! {
        didSet {
            self.navigationItem.title = self.questionStrategy.title
        }
    }

    public var questionView = QuestionView()
    
    public weak var delegate: QuestionViewControllerDelegate?
    
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = item
        return item
    }()

    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(self.handleCancelButton(_:)))
        
        self.showQuestion()
    }
    
    // MARK: - Instance Methods
    
    @objc func handleCorrect(_ sender: Any) {
        self.questionStrategy.markQuestionCorrect(self.questionStrategy.currentQuestion())
        self.showNextQuestion()
    }
    
    @objc func handleIncorrect(_ sender: Any) {
         self.questionStrategy.markQuestionIncorrect(self.questionStrategy.currentQuestion())
        self.showNextQuestion()
    }
    
    @objc func toggleAnsweLabel(_ sender: Any) {
        self.questionView.hintLabel.isHidden.toggle()
        self.questionView.answerLabel.isHidden.toggle()
    }
    
    @objc func handleCancelButton(_ sender: Any) {
        self.delegate?.questionViewController(self, didCancel: self.questionStrategy)
    }

    // MARK: - Private Methods
    
    private func showQuestion() {
        
        let question = self.questionStrategy.currentQuestion()
        
        self.questionIndexItem.title = self.questionStrategy.questionIndexTitle()
    
        self.questionView.prompLabel.text = question.prompt
        self.questionView.hintLabel.text = question.hint
        self.questionView.answerLabel.text = question.answer
        self.questionView.correctLabel.text = "\(self.questionStrategy.correctCount)"
        self.questionView.incorrectLabel.text = "\(self.questionStrategy.incorrectCount)"
        
        self.questionView.hintLabel.isHidden = true
        self.questionView.answerLabel.isHidden = true
    }
    
    private func showNextQuestion() {
        guard self.questionStrategy.advanceToNextQuestion() else {
            self.delegate?.questionViewController(self, didComplete: self.questionStrategy)
            return
        }
        
        self.showQuestion()
    }

}

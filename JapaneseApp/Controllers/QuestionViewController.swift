//
//  QuestionViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public protocol QuestionViewControllerDelegate: AnyObject {
    
    func questionViewController(
        _ controller: QuestionViewController,
        didCancel questionGroup: QuestionGroup,
        at questionIndex: Int)
    
    func questionViewController(
        _ controller: QuestionViewController,
        didComplete questionGroup: QuestionGroup)
    
}

public class QuestionViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    public var questionGroup: QuestionGroup! {
        didSet {
            self.navigationItem.title = self.questionGroup.title
        }
    }
    
    public var questionIndex = 0
    public var correctCount = 0
    public var incorrectCount = 0
    
    public var questionView = QuestionView()
    
    public weak var delegate: QuestionViewControllerDelegate?
    
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = UIColor(named: "primaryColor")
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.handleCancelButton(_:)))
        
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
        self.questionView.hintLabel.isHidden.toggle()
        self.questionView.answerLabel.isHidden.toggle()
    }
    
    @objc func handleCancelButton(_ sender: Any) {
        self.delegate?.questionViewController(self, didCancel: self.questionGroup, at: self.questionIndex)
    }

    // MARK: - Private
    
    private func showQuestion() {
        
        self.questionIndexItem.title = "\(questionIndex + 1)/\(questionGroup.questions.count)"
        
        let question = self.questionGroup.questions[questionIndex]
        self.questionView.prompLabel.text = question.prompt
        self.questionView.hintLabel.text = question.hint
        self.questionView.answerLabel.text = question.answer
        self.questionView.correctLabel.text = "\(self.correctCount)"
        self.questionView.incorrectLabel.text = "\(self.incorrectCount)"
        
        self.questionView.hintLabel.isHidden = true
        self.questionView.answerLabel.isHidden = true
    }
    
    private func showNextQuestion() {
        self.questionIndex += 1
        
        guard self.questionIndex < self.questionGroup.questions.count else {
            self.delegate?.questionViewController(self, didComplete: self.questionGroup)
            return
        }
        
        self.showQuestion()
    }

}


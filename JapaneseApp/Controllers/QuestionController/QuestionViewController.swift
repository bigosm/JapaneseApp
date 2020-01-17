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
    
    private var promptController = PromptViewController()
    private var answerController = AnswerViewController()
    private var questionNavigationController = QuestionNavigationViewController()

    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "background")
        
        self.createView(with: [
            self.promptController,
            self.answerController,
            self.questionNavigationController
        ])
        
        let promptView = self.promptController.view!
        promptView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            promptView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            promptView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            promptView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            promptView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        let answerView = self.answerController.view!
        answerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerView.topAnchor.constraint(equalTo: promptView.bottomAnchor, constant: 20),
            answerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            answerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            answerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        let questionNavigationView = self.questionNavigationController.view!
        questionNavigationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionNavigationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            questionNavigationView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            questionNavigationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            questionNavigationView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
        
        self.answerController.selectedAnswerHandler = { [weak self] selectedAnswer in
            guard let _ = selectedAnswer else {
                self?.questionNavigationController.checkButton.isEnabled = false
                return
            }
            
            self?.questionNavigationController.checkButton.isEnabled = true
        }
        
        self.questionNavigationController.skipButtonAction = { [weak self] in
            self?.showNextQuestion()
        }
        
        self.questionNavigationController.checkButtonAction = { [weak self] in
            if let selectedAnswer = self?.answerController.selectedAnswer {
                return self?.questionStrategy.checkAnswer(selected: selectedAnswer)
            }
            
            return nil
        }
        
        self.questionNavigationController.continueButtonAction = { [weak self] in
            self?.showNextQuestion()
        }

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(self.handleCancelButton(_:)))
        
        self.showQuestion()
    }
    
    // MARK: - Instance Methods
    
    @objc func toggleAnsweLabel(_ sender: Any) {
        self.questionView.hintLabel.isHidden.toggle()
        self.questionView.answerLabel.isHidden.toggle()
    }
    
    @objc func handleCancelButton(_ sender: Any) {
        self.delegate?.questionViewController(self, didCancel: self.questionStrategy)
    }

    // MARK: - Private Methods
    
    private func createView(with controllers: [UIViewController]) {
        controllers.forEach {
            self.addChild($0)
            self.view.addSubview($0.view)
            $0.didMove(toParent: self)
        }
    }
    
    private func showQuestion() {
        
        let question = self.questionStrategy.currentQuestion()
        self.answerController.configure(with: self.questionStrategy.getAnswersForCurrentQuestion(amount: 4))
        self.questionIndexItem.title = self.questionStrategy.questionIndexTitle()
    
        self.promptController.set(prompt: question.prompt)
        self.questionNavigationController.set(correctAnswer: question.answer)
    }
    
    private func showNextQuestion() {
        guard self.questionStrategy.advanceToNextQuestion() else {
            self.delegate?.questionViewController(self, didComplete: self.questionStrategy)
            return
        }
        
        self.showQuestion()
    }

}

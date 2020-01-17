//
//  QuestionNavigationViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class QuestionNavigationViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    public var answerView: UIView!
    public var skipButtonAction: (() -> ())?
    public var skipButton: UIButton!
    public var statusMessage: UILabel!
    public var correctAnswerLabel: UILabel!
    public var reportButton: UIButton!
    
    public var checkView: UIView!
    public var checkButtonAction: (() -> (Bool?))?
    public var checkButton: UIButton!
    public var continueButtonAction: (() -> ())?
    public var continueButton: UIButton!

    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.answerView = UIView()
        self.answerView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        self.answerView.isHidden = true
        
        self.statusMessage = UILabel()
        self.statusMessage.text = "Correct answer:"
        self.statusMessage.font = .preferredFont(forTextStyle: .headline)
        
        self.correctAnswerLabel = UILabel()
        self.correctAnswerLabel.text = "123"
        self.correctAnswerLabel.font = .preferredFont(forTextStyle: .subheadline)
        
        self.reportButton = UIButton()
        self.reportButton.setTitle("Report", for: .normal)
        self.reportButton.backgroundColor = .black
        
        self.continueButton = UIButton()
        self.continueButton.setTitle("continue", for: .normal)
        self.continueButton.backgroundColor = .black
        self.continueButton.layer.cornerRadius = 10
        
        self.checkView = UIView()
        self.checkView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        
        self.checkButton = UIButton()
        self.checkButton.setTitle("check", for: .normal)
        self.checkButton.setTitleColor(.darkGray, for: .disabled)
        self.checkButton.backgroundColor = .black
        self.checkButton.isEnabled = false
        self.checkButton.layer.cornerRadius = 10
        
        self.skipButton = UIButton()
        self.skipButton.setTitle("skip", for: .normal)
        self.skipButton.backgroundColor = .black
        self.skipButton.layer.cornerRadius = 10
        
        // MARK: Answer View
        
        self.view.addSubview(self.answerView)
        self.answerView.addSubview(self.statusMessage)
        self.answerView.addSubview(self.correctAnswerLabel)
        self.answerView.addSubview(self.reportButton)
        self.answerView.addSubview(self.continueButton)

        self.answerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.answerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.answerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.answerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.answerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        self.statusMessage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.statusMessage.topAnchor.constraint(equalTo: self.answerView.topAnchor, constant: 10),
            self.statusMessage.leadingAnchor.constraint(equalTo: self.answerView.leadingAnchor, constant: 10),
            self.statusMessage.trailingAnchor.constraint(equalTo: self.reportButton.leadingAnchor, constant: -10)
        ])
        
        self.correctAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.correctAnswerLabel.topAnchor.constraint(equalTo: self.statusMessage.bottomAnchor, constant: 5),
            self.correctAnswerLabel.leadingAnchor.constraint(equalTo: self.answerView.leadingAnchor, constant: 10),
            self.correctAnswerLabel.trailingAnchor.constraint(equalTo: self.reportButton.leadingAnchor, constant: -10)
        ])

        self.reportButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.reportButton.topAnchor.constraint(equalTo: self.answerView.topAnchor, constant: 10),
            self.reportButton.trailingAnchor.constraint(equalTo: self.answerView.trailingAnchor, constant: -10),
            self.reportButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        self.continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.continueButton.topAnchor.constraint(equalTo: self.correctAnswerLabel.bottomAnchor, constant: 10),
            self.continueButton.leadingAnchor.constraint(equalTo: self.answerView.leadingAnchor, constant: 10),
            self.continueButton.bottomAnchor.constraint(equalTo: self.answerView.bottomAnchor, constant: -10),
            self.continueButton.trailingAnchor.constraint(equalTo: self.answerView.trailingAnchor, constant: -10)
        ])
        
        // MARK: Check View
        
        self.view.addSubview(self.checkView)
        self.checkView.addSubview(self.skipButton)
        self.checkView.addSubview(self.checkButton)

        self.checkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.checkView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.checkView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.checkView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        self.skipButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.skipButton.topAnchor.constraint(equalTo: self.checkView.topAnchor, constant: 10),
            self.skipButton.leadingAnchor.constraint(equalTo: self.checkView.leadingAnchor, constant: 10),
            self.skipButton.bottomAnchor.constraint(equalTo: self.checkView.bottomAnchor, constant: -10),
            self.skipButton.widthAnchor.constraint(equalToConstant: 70)
        ])

        self.checkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.checkButton.topAnchor.constraint(equalTo: self.checkView.topAnchor, constant: 10),
            self.checkButton.leadingAnchor.constraint(equalTo: self.skipButton.trailingAnchor, constant: 5),
            self.checkButton.bottomAnchor.constraint(equalTo: self.checkView.bottomAnchor, constant: -10),
            self.checkButton.trailingAnchor.constraint(equalTo: self.checkView.trailingAnchor, constant: -10)
        ])

        self.skipButton.addTarget(self, action: #selector(self.handleSkipButton), for: .touchUpInside)
        self.checkButton.addTarget(self, action: #selector(self.handleCheckButton(_:)), for: .touchUpInside)
        self.continueButton.addTarget(self, action: #selector(self.handleContinueButton), for: .touchUpInside)
    }
    
    // MARK: - Instance Methods
    
    @objc func handleSkipButton(_ sender: Any) {
        self.skipButtonAction?()
    }
    
    @objc func handleCheckButton(_ sender: Any) {
        guard let answerCheckResult = self.checkButtonAction?() else {
            return
        }
        
        if case answerCheckResult = true {
            self.correctAnswerLabel.isHidden = true
            self.statusMessage.text = "You are correct!"
        } else {
            self.correctAnswerLabel.isHidden = false
            self.statusMessage.text = "Correct answer:"
        }
        
        self.toggleNaviagtionState()
    }
    
    @objc func handleContinueButton(_ sender: Any) {
        self.toggleNaviagtionState()
        self.continueButtonAction?()
    }
    
    public func set(correctAnswer: String) {
        self.correctAnswerLabel.text = correctAnswer
    }
    
    // MARK: - Private Methods
    
    private func toggleNaviagtionState() {
        self.answerView.isHidden.toggle()
        self.checkView.isHidden.toggle()
    }
 
}

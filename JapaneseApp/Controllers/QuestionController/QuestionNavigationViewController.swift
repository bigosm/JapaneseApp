//
//  QuestionNavigationViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class QuestionNavigationViewController: UIViewController {
    
    // MARK: - Theme
    
    private var themeBackgroundColor = Theme.secondaryBackgroundColor
    private var themeAlertColor = Theme.alertColor
    private var themeSuccessColor = Theme.successColor
    private var themeClearColor = UIColor.clear
    private var themePrimaryColor = Theme.primaryColor
    private var themeButtonColor = Theme.primaryButtonColor
    private var themeButtonTitleColor = Theme.primaryButtonTitleColor
    private var themeDidabledButtonTitleColor = Theme.disabledButtonTitleColor
    
    private var themeButtonFont = UIFont.systemFont(ofSize: 20)
    
    private var themeBasicCornerRadius: CGFloat = 10
    
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
        
        self.view.backgroundColor = .clear
        
        self.checkView = UIView()
        self.checkView.backgroundColor = self.themeBackgroundColor
        
        self.checkButton = UIButton(type: .system)
        self.checkButton.setTitle("check", for: .normal)
        self.checkButton.setTitleColor(self.themeDidabledButtonTitleColor, for: .disabled)
        self.checkButton.backgroundColor = self.themeButtonColor
        self.checkButton.tintColor = self.themeButtonTitleColor
        self.checkButton.titleLabel?.font = self.themeButtonFont
        self.checkButton.layer.cornerRadius = self.themeBasicCornerRadius
        self.checkButton.isEnabled = false
        
        self.skipButton = UIButton(type: .system)
        self.skipButton.setTitle("skip", for: .normal)
        self.skipButton.backgroundColor = self.themeButtonColor
        self.skipButton.tintColor = self.themeButtonTitleColor
        self.skipButton.titleLabel?.font = self.themeButtonFont
        self.skipButton.layer.cornerRadius = self.themeBasicCornerRadius
        
        self.answerView = UIView()
        self.answerView.backgroundColor = self.themeBackgroundColor
        self.answerView.isHidden = true
        
        self.statusMessage = UILabel()
        self.statusMessage.font = .preferredFont(forTextStyle: .headline)
        
        self.correctAnswerLabel = UILabel()
        self.correctAnswerLabel.font = .preferredFont(forTextStyle: .subheadline)
        
        self.reportButton = UIButton(type: .system)
        self.reportButton.setTitle(" Report", for: .normal)
        self.reportButton.setImage(UIImage(named: "baseline_report_black_18pt"), for: .normal)
        self.reportButton.tintColor = self.themePrimaryColor

        self.continueButton = UIButton(type: .system)
        self.continueButton.setTitle("continue", for: .normal)
        self.continueButton.backgroundColor = self.themeButtonColor
        self.continueButton.tintColor = self.themeButtonTitleColor
        self.continueButton.titleLabel?.font = self.themeButtonFont
        self.continueButton.layer.cornerRadius = self.themeBasicCornerRadius

        self.skipButton.addTarget(self, action: #selector(self.handleSkipButton), for: .touchUpInside)
        self.checkButton.addTarget(self, action: #selector(self.handleCheckButton(_:)), for: .touchUpInside)
        self.continueButton.addTarget(self, action: #selector(self.handleContinueButton), for: .touchUpInside)
        
        self.setupView()
    }
    
    // MARK: - Instance Methods
    
    @objc func handleSkipButton(_ sender: Any) {
        self.skipButtonAction?()
    }
    
    @objc func handleCheckButton(_ sender: Any) {
        guard let answerCheckResult = self.checkButtonAction?() else {
            return
        }
        self.continueButton.isEnabled = true
        self.checkButton.isEnabled = false
        
        if case answerCheckResult = true {
            self.correctAnswerLabel.isHidden = true
            self.statusMessage.text = "You are correct!"
            self.answerView.backgroundColor = self.themeSuccessColor
        } else {
            self.correctAnswerLabel.isHidden = false
            self.statusMessage.text = "Correct answer:"
            self.answerView.backgroundColor = self.themeAlertColor
        }
        
        self.toggleNaviagtionState()
    }
    
    @objc func handleContinueButton(_ sender: Any) {
        self.continueButton.isEnabled = false
        self.toggleNaviagtionState()
        self.continueButtonAction?()
    }
    
    public func set(correctAnswer: String) {
        self.correctAnswerLabel.text = correctAnswer
    }
    
    // MARK: - Private Methods
    
    private func toggleNaviagtionState() {
        let transformOffScreen = CGAffineTransform(translationX: 0, y: self.answerView.frame.height)
        
        if self.answerView.isHidden {
            self.answerView.transform = transformOffScreen
            self.answerView.isHidden.toggle()
            
            UIView.animate(withDuration: 0.3, animations: {
                self.answerView.transform = .identity
            }, completion: nil)
        } else {
            self.answerView.transform = .identity

            UIView.animate(withDuration: 0.3, animations: {
                self.answerView.transform = transformOffScreen
            }, completion: { finished in
                self.answerView.isHidden.toggle()
            })
        }
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.view.addSubview(self.checkView)
        self.checkView.addSubview(self.skipButton)
        self.checkView.addSubview(self.checkButton)
        self.view.addSubview(self.answerView)
        self.answerView.addSubview(self.statusMessage)
        self.answerView.addSubview(self.correctAnswerLabel)
        self.answerView.addSubview(self.reportButton)
        self.answerView.addSubview(self.continueButton)
        
        // MARK: Check View

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
            self.skipButton.bottomAnchor.constraint(equalTo: self.checkView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.skipButton.widthAnchor.constraint(equalToConstant: 70)
        ])

        self.checkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.checkButton.topAnchor.constraint(equalTo: self.checkView.topAnchor, constant: 10),
            self.checkButton.leadingAnchor.constraint(equalTo: self.skipButton.trailingAnchor, constant: 5),
            self.checkButton.bottomAnchor.constraint(equalTo: self.checkView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.checkButton.trailingAnchor.constraint(equalTo: self.checkView.trailingAnchor, constant: -10)
        ])
        
        // MARK: Answer View
    
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
            self.reportButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        self.continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.continueButton.topAnchor.constraint(equalTo: self.correctAnswerLabel.bottomAnchor, constant: 10),
            self.continueButton.leadingAnchor.constraint(equalTo: self.answerView.leadingAnchor, constant: 10),
            self.continueButton.bottomAnchor.constraint(equalTo: self.answerView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.continueButton.trailingAnchor.constraint(equalTo: self.answerView.trailingAnchor, constant: -10)
        ])
    }
 
}

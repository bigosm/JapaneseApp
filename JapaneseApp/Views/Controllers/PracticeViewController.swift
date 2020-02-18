//
//  PracticeViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 06/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public protocol PracticeSubjectViewController: UIViewController { }
public protocol PracticeAnswerViewController: UIViewController { }

public final class PracticeViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    private let viewModel: PracticeViewModelType = PracticeViewModel()
    
    public let questionLabel = UILabel()
    public let practiceSubject: PracticeSubjectViewController = CharacterCollectionViewController()
    public let practiceAnswer: PracticeAnswerViewController = TypeInAnswerViewController()
    public let listenButton = Button(customType: .primary)
    public let readingAidVisibilityButton = Button(customType: .primary)
    public let checkButton = Button(customType: .primaryRounded)
    public let continueButton = Button(customType: .primaryRounded)
    
    private var bottomConstraint: NSLayoutConstraint?

    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Theme.primaryBackgroundColor
        
        self.questionLabel.text = "Select the correct character(s) for:"
        self.questionLabel.numberOfLines = 0
        self.questionLabel.font = .boldSystemFont(ofSize: 20)
        
        self.listenButton.setImage(UIImage(named: "round_music_note_black_36pt"), for: .normal)
        self.readingAidVisibilityButton.imageView?.contentMode = .scaleAspectFit
        self.listenButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        self.readingAidVisibilityButton.setImage(UIImage(named: "round_visibility_black_36pt"), for: .normal)
        self.readingAidVisibilityButton.setImage(UIImage(named: "round_visibility_off_black_36pt"), for: .selected)
        self.readingAidVisibilityButton.imageView?.contentMode = .scaleAspectFit
        self.readingAidVisibilityButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        self.checkButton.setTitle("Check", for: .normal)
        self.continueButton.setTitle("Continue", for: .normal)
        
        self.listenButton.addTarget(self, action: #selector(handleListenButton(_:)), for: .touchUpInside)
        self.readingAidVisibilityButton.addTarget(self, action: #selector(handleReadingAidVisibilityButton(_:)), for: .touchUpInside)
        self.checkButton.addTarget(self, action: #selector(handleCheckButton(_:)), for: .touchUpInside)
        self.continueButton.addTarget(self, action: #selector(handleContinueButton(_:)), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                target: self,
                                                                action: #selector(handleCancelButton(_:)))
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.setupView()
        self.bindViewModel()
        self.viewModel.inputs.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.inputs.viewWillAppear()
        self.view.layoutIfNeeded()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.viewModel.inputs.viewWillDisappear()
    }
    
    // MARK: - Instance Methods

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            self.bottomConstraint?.constant == -20 {
            self.bottomConstraint?.constant -= (keyboardSize.height - self.view.safeAreaInsets.bottom)
            
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.bottomConstraint?.constant != -20 {
            self.bottomConstraint?.constant = -20

            self.navigationController?.setNavigationBarHidden(false, animated: true)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func handleCancelButton(_ sender: Any) {
        self.view.endEditing(true)
        self.viewModel.inputs.cancelButtonTapped()
    }
    
    @objc func handleListenButton(_ sender: Any) {
        self.viewModel.inputs.listenButtonTapped()
    }
    
    @objc func handleReadingAidVisibilityButton(_ sender: Any) {
        self.readingAidVisibilityButton.isSelected.toggle()
        self.viewModel.inputs.readingAidVisibilityButtonTapped()
    }
    
    @objc func handleCheckButton(_ sender: Any) {
        self.view.endEditing(true)
        self.viewModel.inputs.checkButtonTapped()
    }
    
    @objc func handleContinueButton(_ sender: Any) {
        self.viewModel.inputs.continueButtonTapped()
    }

    // MARK: - Binding
    
    private func bindViewModel() {
        self.viewModel.outputs.title.addObserver(self, options: [.new]) { [weak self] value, options in
            self?.title = value
        }
        
        self.viewModel.outputs.question.addObserver(self, options: [.new]) { [weak self] value, options in
            self?.questionLabel.text = value
        }
        
        self.viewModel.outputs.isReadingAidButtonHidden.addObserver(self, options: [.new]) { [weak self] value, options in
            self?.readingAidVisibilityButton.isHidden = value
        }
        
        self.viewModel.outputs.isCheckButtonHidden.addObserver(self, options: [.new]) { [weak self] value, options in
            self?.checkButton.isHidden = value
        }
        
        self.viewModel.outputs.isCheckButtonEnabled.addObserver(self, options: [.new]) { [weak self] value, options in
            self?.checkButton.isEnabled = value
        }
        
        self.viewModel.outputs.isContinueButtonHidden.addObserver(self, options: [.new]) { [weak self] value, options in
            self?.continueButton.isHidden = value
        }
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.view.addSubview(self.questionLabel)
        self.addChild(self.practiceSubject)
        self.practiceSubject.didMove(toParent: self)
        self.view.addSubview(self.practiceSubject.view)
        self.view.addSubview(self.listenButton)
        self.view.addSubview(self.readingAidVisibilityButton)
        self.addChild(self.practiceAnswer)
        self.practiceAnswer.didMove(toParent: self)
        self.view.addSubview(self.practiceAnswer.view)
        self.view.addSubview(self.checkButton)
        self.view.addSubview(self.continueButton)
        
        self.questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.questionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.questionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.questionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        self.practiceSubject.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.practiceSubject.view.topAnchor.constraint(equalTo: self.questionLabel.bottomAnchor, constant: 20),
            self.practiceSubject.view.leadingAnchor.constraint(equalTo: self.questionLabel.leadingAnchor),
            self.practiceSubject.view.trailingAnchor.constraint(equalTo: self.questionLabel.trailingAnchor)
        ])
        
        self.listenButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.listenButton.topAnchor.constraint(equalTo: self.practiceSubject.view.bottomAnchor, constant: 20),
            self.listenButton.leadingAnchor.constraint(equalTo: self.questionLabel.leadingAnchor),
            self.listenButton.heightAnchor.constraint(equalToConstant: self.listenButton.buttonHeight),
            self.listenButton.widthAnchor.constraint(equalToConstant: self.listenButton.buttonHeight)
        ])
        
        self.readingAidVisibilityButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.readingAidVisibilityButton.topAnchor.constraint(equalTo: self.listenButton.topAnchor),
            self.readingAidVisibilityButton.leadingAnchor.constraint(equalTo: self.listenButton.trailingAnchor),
            self.readingAidVisibilityButton.heightAnchor.constraint(equalToConstant: self.readingAidVisibilityButton.buttonHeight),
            self.readingAidVisibilityButton.widthAnchor.constraint(equalToConstant: self.readingAidVisibilityButton.buttonHeight)
        ])
        
        self.practiceAnswer.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.practiceAnswer.view.topAnchor.constraint(equalTo: self.readingAidVisibilityButton.bottomAnchor, constant: 20),
            self.practiceAnswer.view.leadingAnchor.constraint(equalTo: self.questionLabel.leadingAnchor),
            self.practiceAnswer.view.trailingAnchor.constraint(equalTo: self.questionLabel.trailingAnchor)
        ])
        
        self.checkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.checkButton.topAnchor.constraint(equalTo: self.practiceAnswer.view.bottomAnchor, constant: 20),
            self.checkButton.leadingAnchor.constraint(equalTo: self.questionLabel.leadingAnchor),
            self.checkButton.trailingAnchor.constraint(equalTo: self.questionLabel.trailingAnchor),
            self.checkButton.heightAnchor.constraint(equalToConstant: self.checkButton.buttonHeight)
        ])
        
        self.continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.continueButton.leadingAnchor.constraint(equalTo: self.checkButton.leadingAnchor),
            self.continueButton.bottomAnchor.constraint(equalTo: self.checkButton.bottomAnchor),
            self.continueButton.trailingAnchor.constraint(equalTo: self.checkButton.trailingAnchor),
            self.continueButton.heightAnchor.constraint(equalToConstant: self.continueButton.buttonHeight)
        ])
        
        self.bottomConstraint = self.checkButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        self.bottomConstraint?.isActive = true
    }
}

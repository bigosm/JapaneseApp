//
//  AnswerCheckViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 18/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class AnswerCompletionViewController: UIViewController, PracticeAnswerCompletionViewController {
    
    // MARK: - Instance Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: AnswerCompletionViewModelType = AnswerCompletionViewModel()
    
    public let titleLabel = UILabel()
    public let answerStack = UIStackView()
    public let correctAnswerLabel = UILabel()
    public let meaningLabel = UILabel()
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.cornerRadius = 20
        self.answerStack.axis = .vertical
        self.answerStack.spacing = 5
        self.titleLabel.font = .boldSystemFont(ofSize: 22)
        self.correctAnswerLabel.numberOfLines = 0
        self.correctAnswerLabel.font = .systemFont(ofSize: 20)
        self.meaningLabel.numberOfLines = 0
        self.meaningLabel.font = .systemFont(ofSize: 17)
        
        self.setupView()
        self.bindViewModel()
        self.viewModel.inputs.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.inputs.viewWillAppear()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.viewModel.inputs.viewWillDisappear()
    }
    
    // MARK: - Instance Methods
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel.outputs.title.bind { [weak self] value in
            self?.titleLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.correctAnswer.bind { [weak self] value in
            self?.correctAnswerLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.meaing.bind { [weak self] value in
            self?.meaningLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.isAnswerCorrect.bind { [weak self] value in
            self?.view.backgroundColor = value
                ? Theme.successColor
                : Theme.alertColor
        }.disposed(by: disposeBag)
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.answerStack)
        self.answerStack.addArrangedSubview(self.correctAnswerLabel)
        self.answerStack.addArrangedSubview(self.meaningLabel)

        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20)
        ])
        
        self.answerStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.answerStack.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.answerStack.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.answerStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            self.answerStack.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ])
    }
}

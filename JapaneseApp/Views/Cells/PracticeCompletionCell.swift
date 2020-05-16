//
//  PracticeCompletionCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 24/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class PracticeCompletionCell: UITableViewCell {
    
    // MARK: - Instance Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: PracticeCompletionCellViewModelType = PracticeCompletionCellViewModel()
    
    public let stackView = UIStackView()
    
    // MARK: Header
    public let mainView = UIView()
    public let titleLabel = UILabel()
    public let correctImage = UIImageView()
    public let experienceLabel = UILabel()
    
    // MARK: Body
    public let toggleView = UIView()
    public let promptLabel = UILabel()
    public let subjectLabel = UILabel()
    public let subjectHeader = UILabel()
    public let answerLabel = UILabel()
    public let answerHeader = UILabel()
    public let correctAnswerLabel = UILabel()
    public let correctAnswerHeader = UILabel()
    public let meaningLabel = UILabel()
    public let meaningHeader = UILabel()
    
    // MARK: - Object Lifecycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = Theme.Background.primaryColor
        self.selectionStyle = .none
        
        self.stackView.axis = .vertical
        
        // MARK: Header View
        
        self.titleLabel.font = .preferredFont(forTextStyle: .headline)
        
        // MARK: Body View
        
        self.subjectHeader.text = "Subject"
        self.answerHeader.text = "Answer"
        self.correctAnswerHeader.text = "Correct"
        self.meaningHeader.text = "Meaning"
        
        self.toggleView.isHidden = true
        self.promptLabel.font = .preferredFont(forTextStyle: .headline)
        [[self.subjectHeader, self.subjectLabel],
         [self.answerHeader, self.answerLabel],
         [self.correctAnswerHeader, self.correctAnswerLabel],
         [self.meaningHeader, self.meaningLabel]
            ].forEach { row in
                let header = row[0]
                let label = row[1]
                header.font = .preferredFont(forTextStyle: .caption1)
                header.alpha = 0.5
                label.numberOfLines = 0
        }
        self.correctAnswerLabel.textColor = Theme.successColor
        
        self.setupView()
        self.bindViewModel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        viewModel.inputs.prepareForReuse()
    }
    
    public func configureWith(practiceAnswerAtIndex index: Int) {
        viewModel.inputs.configureWith(practiceAnswerAtIndex: index)
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel.outputs.isCorrect.bind{ [weak self] value in
            self?.correctImage.image = value
                ? UIImage(named: "round_done_36pt")
                : UIImage(named: "round_clear_36pt")
            
            self?.correctImage.tintColor = value
                ? Theme.successColor
                : Theme.alertColor
        }.disposed(by: disposeBag)
        
        viewModel.outputs.title.bind { [weak self] value in
            self?.titleLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.experience.bind { [weak self] value in
            self?.experienceLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.prompt.bind { [weak self] value in
            self?.promptLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.subject.bind { [weak self] value in
            guard let self = self else { return }
            self.subjectLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.answer.bind { [weak self] value in
            guard let self = self else { return }
            self.answerLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.correctAnswer.bind { [weak self] value in
            guard let self = self else { return }
            self.correctAnswerLabel.text = value
            self.setHidden(for: self.correctAnswerLabel, isHidden: value == nil)
            self.answerLabel.textColor = value == nil ? Theme.successColor : Theme.alertColor
        }.disposed(by: disposeBag)
        
        viewModel.outputs.meaning.bind { [weak self] value in
            guard let self = self else { return }
            self.meaningLabel.text = value
            self.setHidden(for: self.meaningLabel, isHidden: value == nil)
        }.disposed(by: disposeBag)
        
        viewModel.outputs.isSelected.bind { [weak self] value in
            self?.isSelected = value
            self?.toggleView.isHidden = !value
        }.disposed(by: disposeBag)
    }
    
    // MARK: - View Position Layout
    
    private func setHidden(for view: UIView, isHidden: Bool) {
        self.toggleView.subviews.first?
            .subviews.first(where: { $0.subviews.contains(where: { $0 === view }) })?
            .isHidden = isHidden
    }
    private func setupView() {
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.mainView)
        self.stackView.addArrangedSubview(self.toggleView)
        self.mainView.addSubview(self.correctImage)
        self.mainView.addSubview(self.titleLabel)
        self.mainView.addSubview(self.experienceLabel)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        let stackViewBottom =  self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackViewBottom,
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        stackViewBottom.priority = .init(rawValue: 999)
        
        // MARK: Header
        
        self.correctImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.correctImage.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 20),
            self.correctImage.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.correctImage.widthAnchor.constraint(equalToConstant: 30),
            self.correctImage.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 5),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -5),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.correctImage.trailingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.experienceLabel.leadingAnchor, constant: -10),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        self.experienceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.experienceLabel.bottomAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.experienceLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -20)
        ])
        
        // MARK: Body
        
        let container = UIStackView()
        self.toggleView.addSubview(container)
        self.toggleView.addSubview(self.promptLabel)
        container.axis = .vertical
        container.spacing = 15
        
        let stack = [
            [self.subjectHeader, self.subjectLabel],
            [self.answerHeader, self.answerLabel],
            [self.correctAnswerHeader, self.correctAnswerLabel],
            [self.meaningHeader, self.meaningLabel]
        ]
        
        stack.enumerated().forEach { (key, row) in
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.alignment = .firstBaseline
            let header = row[0]
            let label = row[1]
            rowStack.addArrangedSubview(header)
            rowStack.addArrangedSubview(label)
            container.addArrangedSubview(rowStack)
            header.translatesAutoresizingMaskIntoConstraints = false
            header.widthAnchor.constraint(equalToConstant: 60).isActive = true
        }
        
        self.promptLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.promptLabel.topAnchor.constraint(equalTo: self.toggleView.topAnchor, constant: 20),
            self.promptLabel.leadingAnchor.constraint(equalTo: self.toggleView.leadingAnchor, constant: 20),
            self.promptLabel.trailingAnchor.constraint(equalTo: self.toggleView.trailingAnchor, constant: -20)
        ])
        
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.promptLabel.bottomAnchor, constant: 20),
            container.leadingAnchor.constraint(equalTo: self.promptLabel.leadingAnchor),
            container.bottomAnchor.constraint(equalTo: self.toggleView.bottomAnchor, constant: -20),
            container.trailingAnchor.constraint(equalTo: self.promptLabel.trailingAnchor)
        ])
    }
}

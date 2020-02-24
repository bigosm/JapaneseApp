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
        
        self.backgroundColor = Theme.primaryBackgroundColor
        self.selectionStyle = .none
        
        self.stackView.axis = .vertical

        // MARK: Header View
        
        self.titleLabel.font = .preferredFont(forTextStyle: .headline)

        // MARK: Body View
        
        self.toggleView.isHidden = true
        
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
        self.viewModel.inputs.prepareForReuse()
    }
    
    public func configureWith(practiceAnswerAtIndex index: Int) {
        self.viewModel.inputs.configureWith(practiceAnswerAtIndex: index)
    }

    
    // MARK: - Binding
    
    private func bindViewModel() {
        self.viewModel.outputs.isCorrect.addObserver(self, options: [.new]) { [weak self] value, _ in
            self?.correctImage.image = value
            ? UIImage(named: "round_done_36pt")
            : UIImage(named: "round_clear_36pt")
            
            self?.correctImage.tintColor = value
                ? Theme.successColor
                : Theme.alertColor
        }
        
        self.viewModel.outputs.title.addObserver(self, options: [.new]) { [weak self] value, _ in
            self?.titleLabel.text = value
        }

        self.viewModel.outputs.experience.addObserver(self, options: [.new]) { [weak self] value, _ in
            self?.experienceLabel.text = value
        }
        
        self.viewModel.outputs.prompt.addObserver(self, options: [.new]) { [weak self] value, _ in
            self?.promptLabel.text = value
        }
        
        self.viewModel.outputs.subject.addObserver(self, options: [.new]) { [weak self] value, _ in
            self?.subjectLabel.text = value
            self?.subjectLabel.isHidden = value == nil
            self?.subjectHeader.text = value == nil ? nil : "Subject"
            self?.subjectHeader.isHidden = value == nil
        }

        self.viewModel.outputs.answer.addObserver(self, options: [.new]) { [weak self] value, _ in
            self?.answerLabel.text = value
            self?.answerLabel.isHidden = value == nil
            self?.answerHeader.text = value == nil ? nil : "Answer"
            self?.answerHeader.isHidden = value == nil
        }

        self.viewModel.outputs.correctAnswer.addObserver(self, options: [.new]) { [weak self] value, _ in
            self?.correctAnswerLabel.text = value
            self?.correctAnswerLabel.isHidden = value == nil
            self?.correctAnswerHeader.text = value == nil ? nil : "Correct"
            self?.correctAnswerHeader.isHidden = value == nil
        }
        
        self.viewModel.outputs.meaning.addObserver(self, options: [.new]) { [weak self] value, _ in
            self?.meaningLabel.text = value
            self?.meaningLabel.isHidden = value == nil
            self?.meaningHeader.text = value == nil ? nil : "Meaning"
            self?.meaningHeader.isHidden = value == nil
        }
        
        self.viewModel.outputs.isSelected.addObserver(self, options: [.new]) { [weak self] value, _ in
            self?.isSelected = value
            self?.toggleView.isHidden = !value
        }
    }
    
    // MARK: - View Position Layout
    
    private func redraw() {
        
    }
    
    private func setupView() {
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.mainView)
        self.stackView.addArrangedSubview(self.toggleView)
        self.mainView.addSubview(self.correctImage)
        self.mainView.addSubview(self.titleLabel)
        self.mainView.addSubview(self.experienceLabel)
        
        self.toggleView.addSubview(self.promptLabel)
//        let stack = [
//            [self.subjectHeader,
//             self.answerHeader,
//             self.correctAnswerHeader,
//             self.meaningHeader],
//            [self.subjectLabel,
//             self.answerLabel,
//             self.correctAnswerLabel,
//             self.meaningLabel]
//        ]
//
//        let nestedStackView = UIStackView()
//        nestedStackView.axis = .horizontal
//        nestedStackView.spacing = 10
//
//        let leftStackView = UIStackView()
//        leftStackView.axis = .vertical
//        leftStackView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//        leftStackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//
//        stack[0].forEach {
//            leftStackView.addArrangedSubview($0)
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
//            $0.font = .preferredFont(forTextStyle: .caption1)
//            $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        }
//
//        let rightStackView = UIStackView()
//        rightStackView.axis = .vertical
//        rightStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        rightStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
//
//        stack[1].forEach {
//            rightStackView.addArrangedSubview($0)
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
//            $0.font = .preferredFont(forTextStyle: .headline)
//            $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//            $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        }
//
//        nestedStackView.addArrangedSubview(leftStackView)
//        nestedStackView.addArrangedSubview(rightStackView)
        
        self.promptLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.promptLabel.topAnchor.constraint(equalTo: self.toggleView.topAnchor, constant: 20),
            self.promptLabel.leadingAnchor.constraint(equalTo: self.toggleView.leadingAnchor, constant: 20),
            self.promptLabel.trailingAnchor.constraint(equalTo: self.toggleView.trailingAnchor, constant: -20)
        ])
        
        let stack = [
            [self.subjectHeader, self.subjectLabel],
            [self.answerHeader, self.answerLabel],
            [self.correctAnswerHeader, self.correctAnswerLabel],
            [self.meaningHeader, self.meaningLabel]
        ]
        
        stack.enumerated().forEach { (key, row) in
            let header = row[0]
            let label = row[1]
            header.font = .preferredFont(forTextStyle: .caption1)
            label.font = .preferredFont(forTextStyle: .headline)
            label.numberOfLines = 0
            self.toggleView.addSubview(header)
            self.toggleView.addSubview(label)
            header.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            if key == 0 {
                label.topAnchor.constraint(equalTo: self.promptLabel.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: stack[key - 1][1].bottomAnchor, constant: 10).isActive = true
            }
            NSLayoutConstraint.activate([
                header.firstBaselineAnchor.constraint(equalTo: label.firstBaselineAnchor),
                header.leadingAnchor.constraint(equalTo: self.promptLabel.leadingAnchor),
                header.widthAnchor.constraint(equalToConstant: 60),
                label.leadingAnchor.constraint(equalTo: header.trailingAnchor),
                label.trailingAnchor.constraint(equalTo: self.promptLabel.trailingAnchor),
            ])
            
            if key == stack.count - 1 {
                label.bottomAnchor.constraint(equalTo: self.toggleView.bottomAnchor, constant: -20).isActive = true
            }
        }

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
        
//        toggleStackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            toggleStackView.topAnchor.constraint(equalTo: self.toggleView.topAnchor, constant: 10),
//            toggleStackView.leadingAnchor.constraint(equalTo: self.toggleView.leadingAnchor, constant: 20),
//            toggleStackView.bottomAnchor.constraint(equalTo: self.toggleView.bottomAnchor, constant: -20),
//            toggleStackView.trailingAnchor.constraint(equalTo: self.toggleView.trailingAnchor, constant: -20)
//        ])
        
//        self.promptLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.promptLabel.topAnchor.constraint(equalTo: self.toggleView.topAnchor, constant: 10),
//            self.promptLabel.leadingAnchor.constraint(equalTo: self.toggleView.leadingAnchor, constant: 20),
//            self.promptLabel.trailingAnchor.constraint(equalTo: self.toggleView.trailingAnchor, constant: -20)
//        ])
//
//        self.answerLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.answerLabel.topAnchor.constraint(equalTo: self.promptLabel.bottomAnchor, constant: 10),
//            self.answerLabel.leadingAnchor.constraint(equalTo: self.promptLabel.leadingAnchor),
//            self.answerLabel.trailingAnchor.constraint(equalTo: self.promptLabel.trailingAnchor)
//        ])
//
//        self.correctAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.correctAnswerLabel.topAnchor.constraint(equalTo: self.answerLabel.bottomAnchor, constant: 10),
//            self.correctAnswerLabel.leadingAnchor.constraint(equalTo: self.promptLabel.leadingAnchor),
//            self.correctAnswerLabel.trailingAnchor.constraint(equalTo: self.promptLabel.trailingAnchor)
//        ])
//
//        self.meaningLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.meaningLabel.topAnchor.constraint(equalTo: self.correctAnswerLabel.bottomAnchor, constant: 10),
//            self.meaningLabel.leadingAnchor.constraint(equalTo: self.promptLabel.leadingAnchor),
//            self.meaningLabel.bottomAnchor.constraint(equalTo: self.toggleView.bottomAnchor, constant: -20),
//            self.meaningLabel.trailingAnchor.constraint(equalTo: self.promptLabel.trailingAnchor)
//        ])
    }
}

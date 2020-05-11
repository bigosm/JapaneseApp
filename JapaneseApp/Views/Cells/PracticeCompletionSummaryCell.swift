//
//  PracticeCompletionSummaryCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 25/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class PracticeCompletionSummaryCell: UITableViewCell {
    
    // MARK: - Instance Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: PracticeCompletionSummaryCellViewModelType = PracticeCompletionSummaryCellViewModel()
    
    public let stackView = UIStackView()
    
    // MARK: Header
    public let titleLabel = UILabel()
    public let experienceLabel = UILabel()
    public let completeButton = Button(customType: .primaryRounded)
    
    // MARK: - Object Lifecycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = Theme.primaryBackgroundColor
        self.selectionStyle = .none
        
        self.titleLabel.text = "Total"
        self.titleLabel.font = .preferredFont(forTextStyle: .headline)
        self.titleLabel.textAlignment = .right
        self.experienceLabel.font = .preferredFont(forTextStyle: .headline)
        
        self.completeButton.setTitle("Complete", for: .normal)
        
        self.completeButton.addTarget(self, action: #selector(handleCompleteButton(_:)), for: .touchUpInside)

        self.setupView()
        self.bindViewModel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    public func configure() {
        self.viewModel.inputs.configure()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel.inputs.prepareForReuse()
    }
    
    @objc public func handleCompleteButton(_ sender: UIButton) {
        self.viewModel.inputs.completeButtonTapped()
    }

    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel.outputs.experience.bind { [weak self] value in
            self?.experienceLabel.text = value
        }.disposed(by: disposeBag)
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.experienceLabel)
        self.addSubview(self.completeButton)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.completeButton.topAnchor, constant: -20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.experienceLabel.leadingAnchor, constant: -10),
        ])

        self.experienceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.experienceLabel.topAnchor.constraint(equalTo: self.titleLabel.topAnchor),
            self.experienceLabel.bottomAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.experienceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        self.completeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.completeButton.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.completeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.completeButton.trailingAnchor.constraint(equalTo: self.experienceLabel.trailingAnchor),
            self.completeButton.heightAnchor.constraint(equalToConstant: self.completeButton.buttonHeight)
        ])
    }
}

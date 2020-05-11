//
//  PracticeCharacterViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 11/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class PracticeCharacterViewController: UIViewController, PracticeSubjectViewController {
    
    // MARK: - Instance Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: PracticeCharacterViewModelType = PracticeCharacterViewModel()
    
    public let characterView = CharacterView(readingAidDirection: .horizontal)
    public let characterContainerView = UIView()
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()

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
    
    public func configureWith(characterAtIndex index: Int) {
        self.viewModel.inputs.configureWith(characterAtIndex: index)
        
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel.outputs.value.bind { [weak self] value in
            self?.characterView.titleLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.readingAid.bind { [weak self] value in
            self?.characterView.readingAidLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.readingAidVisibility.bind { [weak self] value in
            self?.characterView.isReadingAidVisible = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.configuration.bind { [weak self] value in
            self?.configureView(configuration: value)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - View Position Layout
    
    private func configureView(configuration: CharacterConfiguartion) {
        switch configuration {
        case .subject:
            self.characterView.isHideable = false
            self.characterView.titleLabel.font = .systemFont(ofSize: 60)
            self.characterView.titleLabel.adjustsFontSizeToFitWidth = true
            self.characterView.readingAidLabel.font = .systemFont(ofSize: 17)
            self.characterView.readingAidDirection = .horizontal
            self.characterView.underlineView.backgroundColor = Theme.tertiaryBackgroundColor
        case .sentenceElement:
            self.characterView.isHideable = true
            self.characterView.titleLabel.font = .systemFont(ofSize: 25)
            self.characterView.titleLabel.adjustsFontSizeToFitWidth = false
            self.characterView.readingAidLabel.font = .systemFont(ofSize: 17)
            self.characterView.readingAidDirection = .horizontal
            self.characterView.underlineView.backgroundColor = Theme.tertiaryBackgroundColor
        }
    }
    
    private func setupView() {
        self.view.addSubview(self.characterView)

        self.characterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.characterView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.characterView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.characterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.characterView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.characterView.widthAnchor.constraint(lessThanOrEqualToConstant: 150)
        ])
    }
}

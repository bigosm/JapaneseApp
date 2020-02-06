//
//  PracticeViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 06/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class PracticeViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    private let viewModel: PracticeViewModelType = PracticeViewModel()
    
    public let questionLabel = UILabel()
    public let questionSubject = CharacterCollectionViewController()

    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionLabel.text = "Select the correct character(s) for:"
        self.questionLabel.numberOfLines = 0
        self.questionLabel.font = .boldSystemFont(ofSize: 20)
        
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
        self.viewModel.outputs.title.addObserver(self, options: [.new]) { value, options in
            self.title = value
        }
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.view.addSubview(self.questionLabel)
        self.addChild(self.questionSubject)
        self.questionSubject.didMove(toParent: self)
        self.view.addSubview(self.questionSubject.view)
        
        self.questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.questionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.questionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.questionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        self.questionSubject.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.questionSubject.view.topAnchor.constraint(equalTo: self.questionLabel.bottomAnchor, constant: 20),
            self.questionSubject.view.leadingAnchor.constraint(equalTo: self.questionLabel.leadingAnchor),
            self.questionSubject.view.trailingAnchor.constraint(equalTo: self.questionLabel.trailingAnchor),
            self.questionSubject.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

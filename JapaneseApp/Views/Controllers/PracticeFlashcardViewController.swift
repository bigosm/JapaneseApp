//
//  PracticeFlashcardViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 29/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final class PracticeFlashcardViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    private let viewModel: PracticeFlashcardViewModelType = PracticeFlashcardViewModel()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.Background.primaryColor
        self.setupView()
        
        navigationItem.title = "Practice"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didTapCancelButton))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .bookmarks,
            target: self,
            action: #selector(didTapInfoButton))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.inputs.viewWillAppear()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.inputs.viewWillDisappear()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: - Instance Methods
    
    @objc func didTapCancelButton() {
        viewModel.inputs.didTapCancelButton()
    }
    
    @objc func didTapInfoButton() {
        viewModel.inputs.didTapInfoButton()
    }
    
    // MARK: = View Properties
    
    lazy var partitions: [FlashcardPartitionViewController] = {
        [
            FlashcardPartitionViewController(),
            FlashcardPartitionViewController(),
            FlashcardPartitionViewController(),
            FlashcardPartitionViewController(),
            FlashcardPartitionViewController(),
        ]
    }()
    
    lazy var partitionConatiner: UIStackView = {
        let x = UIStackView(arrangedSubviews: partitions.map { $0.view })
        x.distribution = .fillEqually
        x.spacing = 10
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var flashcardController: FlashcardViewType = {
        let x = FlashcardViewController()
        addChild(x)
        x.didMove(toParent: self)
        x.view.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    // MARK: - View Position Layout
    
    private func setupView() {
        partitions.forEach {
            addChild($0)
            $0.didMove(toParent: self)
        }
        partitions[0].isCurrent = true
        view.addSubview(partitionConatiner)
        view.addSubview(flashcardController.view)
        let padding = Theme.Size.Padding.standard
        NSLayoutConstraint.activate([
            partitionConatiner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            partitionConatiner.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            partitionConatiner.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            partitionConatiner.heightAnchor.constraint(equalToConstant: 100),
            
            flashcardController.view.topAnchor.constraint(equalTo: partitionConatiner.bottomAnchor, constant: padding),
            flashcardController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            flashcardController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            flashcardController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
        ])
    }
}

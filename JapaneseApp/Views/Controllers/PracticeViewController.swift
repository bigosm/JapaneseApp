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
    public let listenButton = Button(customType: .primaryRounded)
    public let readingAidVisibilityButton = Button(customType: .primary)

    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Theme.primaryBackgroundColor
        
        self.questionLabel.text = "Select the correct character(s) for:"
        self.questionLabel.numberOfLines = 0
        self.questionLabel.font = .boldSystemFont(ofSize: 20)
        
        self.listenButton.setTitle("listen", for: .normal)
        self.listenButton.setImage(UIImage(named: "round_music_note_black_24pt"), for: .normal)
        self.listenButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 2)
        self.listenButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: -2)
        self.listenButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8+2, bottom: 8, right: 16+2)
        
        self.readingAidVisibilityButton.setImage(UIImage(named: "round_visibility_black_36pt"), for: .normal)
        self.readingAidVisibilityButton.imageView?.contentMode = .scaleAspectFit
        self.readingAidVisibilityButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)
        
        self.listenButton.addTarget(self, action: #selector(handleListenButton(_:)), for: .touchUpInside)
        self.readingAidVisibilityButton.addTarget(self, action: #selector(handleReadingAidVisibilityButton(_:)), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                target: self,
                                                                action: #selector(handleCancelButton(_:)))
        
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
    
    @objc func handleCancelButton(_ sender: Any) {
        self.viewModel.inputs.cancelButtonTapped()
    }
    
    @objc func handleListenButton(_ sender: Any) {
        self.viewModel.inputs.listenButtonTapped()
    }
    
    @objc func handleReadingAidVisibilityButton(_ sender: Any) {
        self.viewModel.inputs.readingAidVisibilityButtonTapped()
    }

    // MARK: - Binding
    
    private func bindViewModel() {
        self.viewModel.outputs.title.addObserver(self, options: [.new]) { [weak self] value, options in
            self?.title = value
        }
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.view.addSubview(self.questionLabel)
        self.addChild(self.questionSubject)
        self.questionSubject.didMove(toParent: self)
        self.view.addSubview(self.questionSubject.view)
        self.view.addSubview(self.listenButton)
        self.view.addSubview(self.readingAidVisibilityButton)
        
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
            self.questionSubject.view.trailingAnchor.constraint(equalTo: self.questionLabel.trailingAnchor)
        ])
        
        self.listenButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.listenButton.topAnchor.constraint(equalTo: self.questionSubject.view.bottomAnchor, constant: 20),
            self.listenButton.leadingAnchor.constraint(equalTo: self.questionLabel.leadingAnchor),
            self.listenButton.heightAnchor.constraint(equalToConstant: self.listenButton.buttonHeight)
        ])
        
        self.readingAidVisibilityButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.readingAidVisibilityButton.topAnchor.constraint(equalTo: self.listenButton.topAnchor),
            self.readingAidVisibilityButton.leadingAnchor.constraint(equalTo: self.listenButton.trailingAnchor, constant: 10),
            self.readingAidVisibilityButton.heightAnchor.constraint(equalToConstant: self.readingAidVisibilityButton.buttonHeight),
            self.readingAidVisibilityButton.widthAnchor.constraint(equalToConstant: self.readingAidVisibilityButton.buttonHeight)
        ])
    }
}

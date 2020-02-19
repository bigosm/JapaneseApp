//
//  TypeInAnswerCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 11/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class TypeInAnswerViewController: UIViewController, PracticeAnswerViewController {
    
    // MARK: - Instance Properties
    
    fileprivate let viewModel = TypeInAnswerViewModel()
    
    public let textInput = UITextView()
    public let placeholder = UILabel()

    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textInput.backgroundColor = Theme.secondaryBackgroundColor
        self.textInput.font = .systemFont(ofSize: 20)
        self.textInput.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.textInput.textContainerInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        self.textInput.delegate = self

        self.textInput.layer.cornerRadius = 20
        
        self.placeholder.font = .systemFont(ofSize: 20)
        self.placeholder.text = "Type in..."
        self.placeholder.alpha = 0.5
        
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
        self.viewModel.outputs.textInput.addObserver(self, options: [.new]) { [weak self] value, _ in
            self?.placeholder.isHidden = !(value?.isEmpty ?? true)
            self?.textInput.text = value
        }
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.view.addSubview(self.textInput)
        self.view.addSubview(self.placeholder)

        self.textInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.textInput.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.textInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.textInput.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.textInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        self.placeholder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.placeholder.topAnchor.constraint(equalTo: self.textInput.topAnchor, constant: 20),
            self.placeholder.leadingAnchor.constraint(equalTo: self.textInput.leadingAnchor, constant: 20),
            self.placeholder.trailingAnchor.constraint(equalTo: self.textInput.trailingAnchor, constant: -20)
        ])
    }
    
}

extension TypeInAnswerViewController: UITextViewDelegate {
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return self.viewModel.outputs.canChangeTextInput
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return self.viewModel.outputs.canChangeTextInput
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        self.viewModel.inputs.textInput(text: textView.text)
    }

}

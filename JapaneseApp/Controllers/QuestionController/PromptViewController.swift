//
//  PromptViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 14/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class PromptViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    public var promptLabel: UILabel!
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.promptLabel = UILabel()
        self.promptLabel.textAlignment = .left
        self.promptLabel.numberOfLines = 0
        self.promptLabel.font = .preferredFont(forTextStyle: .largeTitle)
        
        self.view.addSubview(self.promptLabel)
        self.promptLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.promptLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.promptLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.promptLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.promptLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    // MARK: - Instance Methods
    
    public func set(prompt: String) {
        self.promptLabel.text = prompt
    }
        
}

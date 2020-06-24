//
//  FlashcardPartitionViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 06/06/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final class FlashcardPartitionViewController: UIViewController, FlashcardViewType {
    
    // MARK: - View Lifecycle
    
    var isCurrent: Bool = false {
        didSet {
            view.layer.borderColor = isCurrent ?
                Theme.primaryColor?.withAlphaComponent(0.3).cgColor :
                Theme.Background.secondaryColor?.cgColor
        }
    }
    
    var pendingFlashcards: Int = 0 {
        didSet {
            pendingFlashcardsLabel.text = String(pendingFlashcards)
        }
    }
    
    var doneFlashcards: Int = 0 {
        didSet {
            doneFlashcardsLabel.text = String(doneFlashcards)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        view.backgroundColor = Theme.Background.primaryColor
        view.layer.cornerRadius = 20
        view.layer.borderColor = Theme.Background.secondaryColor?.cgColor
        view.layer.borderWidth = 5.0
        view.clipsToBounds = true
    }

    // MARK: - Instance Methods
    
    func addFlashcardToDone(animation: Bool) {
        if isCurrent {
            pendingFlashcards -= 1
        }
        
        doneFlashcards += 1
    }
    
    // MARK: - View Properties

    private lazy var container: UIStackView = {
        let x = UIStackView(arrangedSubviews: [
            pendingFlashcardsLabel,
            doneFlashcardsLabel,
        ])
        x.axis = .vertical
        x.distribution = .fillEqually
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    private lazy var pendingFlashcardsLabel: UILabel = {
        let x = UILabel()
        x.text = String(pendingFlashcards)
        x.textAlignment = .center
        x.font = UIFont.boldSystemFont(ofSize: 20)
        x.textColor = Theme.Text.Color.primary
        return x
    }()
    
    private lazy var doneFlashcardsLabel: UILabel = {
        let x = UILabel()
        x.text = String(doneFlashcards)
        x.textAlignment = .center
        x.textColor = Theme.Text.Color.secondary
        return x
    }()

    // MARK: - View Position Layout
    
    private func setupView() {
        view.backgroundColor = .clear
        
        view.addSubview(container)
        container.fillSuperview()
    }
}


//
//  FlashcardViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 29/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

protocol FlashcardViewType: UIViewController {
    
}

final class FlashcardViewController: UIViewController, FlashcardViewType {
    
    // MARK: - View Lifecycle
    
    var isFlipped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    // MARK: - Instance Methods
    
    @objc func flipFlashcard() {
        isFlipped.toggle()
        UIView.transition(
            with: view,
            duration: 1,
            options: [.transitionFlipFromRight],
            animations: {
                self.awers.isHidden = self.isFlipped
                self.rewers.isHidden = !self.isFlipped
        }, completion: nil)
    }
    
    // MARK: - View Properties
    // MARK: - Awers
    
    lazy var awers: UIView = {
        let x = UIView()
        x.backgroundColor = Theme.Background.primaryColor
        x.layer.cornerRadius = 20
        x.layer.borderColor = Theme.Background.secondaryColor?.cgColor
        x.layer.borderWidth = 5.0
        x.clipsToBounds = true
        x.translatesAutoresizingMaskIntoConstraints = false
        x.addSubview(container)
        container.fillSuperview(padding: Theme.Size.Padding.standard)
        return x
    }()
    
    lazy var container: UIStackView = {
        let x = UIStackView(arrangedSubviews: [
            questionLabel,
            inputAnswerController.view,
            checkButton,
        ])
        x.axis = .vertical
        x.spacing = Theme.Size.Spacing.base
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var questionLabel: UILabel = {
        let x = UILabel()
        x.text = "What is a character of 'a' sound?"
        x.textAlignment = .center
        x.textColor = Theme.Text.Color.primary
        return x
    }()

    lazy var inputAnswerController: UIViewController = {
        let x = DrawingViewController()
        x.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(x)
        x.didMove(toParent: self)
        return x
    }()
    
    lazy var checkButton: Button = {
        let x = Button(customType: .primaryRounded)
        x.setTitle("check", for: .normal)
        x.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        x.addTarget(self, action: #selector(flipFlashcard), for: .touchUpInside)
        x.translatesAutoresizingMaskIntoConstraints = false
        x.heightAnchor.constraint(equalToConstant: x.buttonHeight).isActive = true
        return x
    }()
    
    // MARK: - Rewers
    
    lazy var rewers: UIView = {
        let x = UIView()
        x.backgroundColor = Theme.Background.primaryColor
        x.layer.cornerRadius = 20
        x.layer.borderColor = Theme.Background.secondaryColor?.cgColor
        x.layer.borderWidth = 5.0
        x.clipsToBounds = true
        x.translatesAutoresizingMaskIntoConstraints = false
        x.addSubview(rewersContainer)
        rewersContainer.fillSuperview(padding: Theme.Size.Padding.standard)
        return x
    }()
    
    lazy var rewersContainer: UIStackView = {
        let x = UIStackView(arrangedSubviews: [
            answerValue,
            continueButton,
        ])
        x.axis = .vertical
        x.spacing = Theme.Size.Spacing.base
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var answerValue: UILabel = {
        let x = UILabel()
        x.text = "あ"
        x.font = UIFont.systemFont(ofSize: 180, weight: .thin)
        x.textAlignment = .center
        x.textColor = Theme.Text.Color.primary
        return x
    }()
    
    lazy var continueButton: Button = {
        let x = Button(customType: .primaryRounded)
        x.setTitle("continue", for: .normal)
        x.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        x.addTarget(self, action: #selector(flipFlashcard), for: .touchUpInside)
        x.translatesAutoresizingMaskIntoConstraints = false
        x.heightAnchor.constraint(equalToConstant: x.buttonHeight).isActive = true
        return x
    }()

    // MARK: - View Position Layout
    
    private func setupView() {
        view.backgroundColor = .clear
        
        view.addSubview(awers)
        awers.fillSuperview()
        
        view.addSubview(rewers)
        rewers.fillSuperview()
        rewers.isHidden = true
    }
}

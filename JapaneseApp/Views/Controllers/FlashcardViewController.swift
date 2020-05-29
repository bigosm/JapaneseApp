//
//  FlashcardViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 29/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final class FlashcardViewController: UIViewController {
    
    // MARK: - View Lifecycle
    
    var isFlipped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    // MARK: - Instance Methods
    
    @objc func flipFlashcard() {
        let toView = isFlipped ? awers : rewers
        UIView.transition(
            from: isFlipped ? rewers : awers,
            to: toView,
            duration: 1,
            options: [.transitionFlipFromRight],
            completion: nil)
        toView.translatesAutoresizingMaskIntoConstraints = false
        toView.fillSuperview()
        isFlipped.toggle()
    }
    
    // MARK: - View Properties
    // MARK: - Awers
    
    lazy var awers: UIView = {
        let x = UIView()
        x.backgroundColor = Theme.Background.primaryColor
        x.translatesAutoresizingMaskIntoConstraints = false
        x.addSubview(awersContainer)
        awersContainer.fillSuperview(padding: Theme.Size.Padding.standard)
        return x
    }()
    
    lazy var awersContainer: UIStackView = {
        let x = UIStackView(arrangedSubviews: [
            questionLabel,
            inputAnswerController.view,
            checkButton,
        ])
        x.axis = .vertical
        x.spacing = Theme.Size.Spacing.section
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
        x.spacing = Theme.Size.Spacing.section
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
        view.backgroundColor = Theme.Background.primaryColor
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        
        view.addSubview(awers)
        awers.fillSuperview()
    }
}

//
//  QuestionGroupCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class QuestionGroupCell: UITableViewCell {
    
    // MARK: - Instance Properties
    
    override public var isSelected: Bool {
        didSet {
            self.toggleView.isHidden = !self.isSelected
        }
    }
    
    public var stackView = UIStackView()
    
    // MARK: Header
    
    public var mainView = UIView()
    public var groupImage = UIImageView()
    public var titleLabel = UILabel()
    public var levelLabel = UILabel()
    public var experienceLabel = UILabel()
    
    // MARK: Body
    
    public var toggleView = UIView()
    public var historyButton = Button(customType: .primary)
    public var practiceButton = Button(customType: .primaryRounded)
    public var timePracticeButton = Button(customType: .primaryRounded)
    
    // MARK: - Object Lifecycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = Theme.primaryBackgroundColor
        self.selectionStyle = .none
        
        self.stackView.axis = .vertical

        // MARK: Header View
        
        self.groupImage.image = UIImage(named: "hiragana-1")
        self.titleLabel.font = .preferredFont(forTextStyle: .headline)

        // MARK: Body View
        
        self.toggleView.isHidden = true
        
        self.historyButton.setImage(UIImage(named: "baseline_history_black_36pt"), for: .normal)
        self.historyButton.imageView?.contentMode = .scaleAspectFit
        self.historyButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)

        self.practiceButton.setTitle("practice", for: .normal)
        self.practiceButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        self.timePracticeButton.setTitle(" practice", for: .normal)
        self.timePracticeButton.setImage(UIImage(named: "baseline_timer_black_24pt"), for: .normal)
        self.timePracticeButton.imageView?.contentMode = .scaleAspectFit
        self.timePracticeButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 16)
        self.timePracticeButton.isEnabled = false

        self.historyButton.addTarget(self, action: #selector(self.handleHistoryButton(_:)), for: .touchUpInside)
        self.practiceButton.addTarget(self, action: #selector(self.handlePracticeButton(_:)), for: .touchUpInside)
        self.timePracticeButton.addTarget(self, action: #selector(self.handleTimePracticeButton(_:)), for: .touchUpInside)
        
        self.setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    @objc func handleHistoryButton(_ sender: Any) {
        print("handleHistoryButton ")
    }
    
    @objc func handlePracticeButton(_ sender: Any) {
        print("handlePracticeButton ")
    }
    
    @objc func handleTimePracticeButton(_ sender: Any) {
        print("handleTimePracticeButton ")
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.mainView)
        self.stackView.addArrangedSubview(self.toggleView)
        self.mainView.addSubview(self.groupImage)
        self.mainView.addSubview(self.titleLabel)
        self.mainView.addSubview(self.levelLabel)
        self.mainView.addSubview(self.experienceLabel)
        self.toggleView.addSubview(self.historyButton)
        self.toggleView.addSubview(self.practiceButton)
        self.toggleView.addSubview(self.timePracticeButton)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        let stackViewBottom =  self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackViewBottom,
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        stackViewBottom.priority = .init(rawValue: 999)
        
        // MARK: Header
        
        self.groupImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.groupImage.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 20),
            self.groupImage.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 20),
            self.groupImage.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -20),
            self.groupImage.widthAnchor.constraint(equalToConstant: 100),
            self.groupImage.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.groupImage.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.groupImage.trailingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -20)
        ])
        
        self.levelLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.levelLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.levelLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.levelLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ])
        
        self.experienceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.experienceLabel.topAnchor.constraint(equalTo: self.levelLabel.bottomAnchor, constant: 5),
            self.experienceLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.experienceLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ])
        
        // MARK: Body
        
        self.practiceButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.practiceButton.topAnchor.constraint(equalTo: self.toggleView.topAnchor),
            self.practiceButton.bottomAnchor.constraint(equalTo: self.toggleView.bottomAnchor, constant: -20),
            self.practiceButton.trailingAnchor.constraint(equalTo: self.toggleView.trailingAnchor, constant: -20),
            self.practiceButton.heightAnchor.constraint(equalToConstant: self.practiceButton.buttonHeight)
        ])
        
        self.timePracticeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.timePracticeButton.bottomAnchor.constraint(equalTo: self.practiceButton.bottomAnchor),
            self.timePracticeButton.trailingAnchor.constraint(equalTo: self.practiceButton.leadingAnchor, constant: -10),
            self.timePracticeButton.heightAnchor.constraint(equalToConstant: self.timePracticeButton.buttonHeight)
        ])
        
        self.historyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.historyButton.bottomAnchor.constraint(equalTo: self.practiceButton.bottomAnchor),
            self.historyButton.trailingAnchor.constraint(equalTo: self.timePracticeButton.leadingAnchor, constant: -10),
            self.historyButton.heightAnchor.constraint(equalToConstant: self.historyButton.buttonHeight),
            self.historyButton.widthAnchor.constraint(equalToConstant: self.historyButton.buttonHeight)

        ])
    }
    
}

//
//  QuestionGroupCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class QuestionGroupCell: UITableViewCell {
    
    // MARK: - Theme

    private var themePrimaryColor = Theme.primaryColor
    private var themeBackgroundColor = Theme.secondaryBackgroundColor
    private var themeButtonColor = Theme.primaryButtonColor
    private var themeButtonTitleColor = Theme.primaryButtonTitleColor
    private var themeButtonFont = UIFont.systemFont(ofSize: 20)
    
    private var themeBasicCornerRadius: CGFloat = 10
    
    // MARK: - Instance Properties
    
    public var stackView = UIStackView()
    
    // MARK: Header
    
    public var headerView = UIView()
    public var titleLabel = UILabel()
    public var levelLabel = UILabel()
    
    // MARK: Body
    
    public var bodyView = UIView()
    public var experienceLabel = UILabel()
    public var historyButton = UIButton(type: .system)
    public var historyButtonHandler: (() -> Void)?
    public var startButton = UIButton(type: .system)
    public var startButtonHandler: (() -> Void)?
    
    // MARK: - Object Lifecycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = self.themeBackgroundColor
        
        self.stackView.axis = .vertical

        // MARK: Header View
        
        self.titleLabel.font = .preferredFont(forTextStyle: .headline)
        self.levelLabel.textAlignment = .right

        // MARK: Body View
        
        self.bodyView.isHidden = true
        
        self.historyButton.setTitle("history", for: .normal)
        self.historyButton.setImage(UIImage(systemName: "history"), for: .normal)
        self.historyButton.setTitleColor(self.themePrimaryColor, for: .normal)
        self.startButton.setTitle("practice", for: .normal)
        self.startButton.backgroundColor = self.themeButtonColor
        self.startButton.tintColor = self.themeButtonTitleColor
        self.startButton.titleLabel?.font = self.themeButtonFont
        self.startButton.layer.cornerRadius = self.themeBasicCornerRadius

        self.historyButton.addTarget(self, action: #selector(self.handleHistoryButton(_:)), for: .touchUpInside)
        self.startButton.addTarget(self, action: #selector(self.handleStartButton(_:)), for: .touchUpInside)
        
        self.setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    public func toggleBody() {
        self.bodyView.isHidden.toggle()
    }
    
    @objc func handleHistoryButton(_ sender: Any) {
        self.historyButtonHandler?()
    }
    
    @objc func handleStartButton(_ sender: Any) {
        self.startButtonHandler?()
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.headerView)
        self.stackView.addArrangedSubview(self.bodyView)
        self.headerView.addSubview(self.levelLabel)
        self.headerView.addSubview(self.titleLabel)
        self.bodyView.addSubview(self.experienceLabel)
        self.bodyView.addSubview(self.historyButton)
        self.bodyView.addSubview(self.startButton)
        
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
        
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.levelLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.levelLabel.topAnchor.constraint(equalTo: self.headerView.topAnchor),
            self.levelLabel.widthAnchor.constraint(equalToConstant: 80),
            self.levelLabel.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            self.levelLabel.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor, constant: -10)
        ])
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.headerView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor, constant: 10),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.levelLabel.leadingAnchor)
        ])
        
        // MARK: Body
        
        self.experienceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.experienceLabel.topAnchor.constraint(equalTo: self.bodyView.topAnchor, constant: 10),
            self.experienceLabel.leadingAnchor.constraint(equalTo: self.bodyView.leadingAnchor, constant: 10),
            self.experienceLabel.bottomAnchor.constraint(equalTo: self.startButton.topAnchor, constant: -10),
            self.experienceLabel.trailingAnchor.constraint(equalTo: self.historyButton.leadingAnchor, constant: -10)
        ])
        
        self.historyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.historyButton.topAnchor.constraint(equalTo: self.bodyView.topAnchor, constant: 10),
            self.historyButton.bottomAnchor.constraint(equalTo: self.startButton.topAnchor, constant: -10),
            self.historyButton.trailingAnchor.constraint(equalTo: self.bodyView.trailingAnchor, constant: -10),
            self.historyButton.heightAnchor.constraint(equalToConstant: 40),
            self.historyButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        self.startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.startButton.leadingAnchor.constraint(equalTo: self.bodyView.leadingAnchor, constant: 10),
            self.startButton.bottomAnchor.constraint(equalTo: self.bodyView.bottomAnchor, constant: -10),
            self.startButton.trailingAnchor.constraint(equalTo: self.bodyView.trailingAnchor, constant: -10),
            self.startButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}

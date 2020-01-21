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
    
    public var stackView = UIStackView()
    
    public var headerView = UIView()
    public var bodyView = UIView()
    
    public var titleLabel = UILabel()
    public var levelLabel = UILabel()
    public var startButton = UIButton()
    public var startButtonHandler: (() -> Void)?
    
    // MARK: - Object Lifecycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.stackView.axis = .vertical
        
        self.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        let stackViewBottom =  self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackViewBottom,
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        stackViewBottom.priority = .init(rawValue: 999)
        
        self.stackView.addArrangedSubview(self.headerView)
        self.stackView.addArrangedSubview(self.bodyView)
        
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // MARK: Header View
        
        self.titleLabel.font = .preferredFont(forTextStyle: .headline)
        self.levelLabel.textAlignment = .right
    
        self.headerView.addSubview(self.levelLabel)
        self.levelLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.levelLabel.topAnchor.constraint(equalTo: self.headerView.topAnchor),
            self.levelLabel.widthAnchor.constraint(equalToConstant: 80),
            self.levelLabel.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            self.levelLabel.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor, constant: -20)
        ])
        
        self.headerView.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.headerView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor, constant: 20),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.levelLabel.leadingAnchor)
        ])
        
        // MARK: Body View
        
        self.bodyView.isHidden = true
        
        self.startButton.setTitle("practice", for: .normal)
        self.startButton.backgroundColor = .darkGray
        self.startButton.layer.cornerRadius = 10
        
        let testLable = UILabel()
        testLable.text = "Test label"
        testLable.backgroundColor = .red
        
        self.bodyView.addSubview(testLable)
        self.bodyView.addSubview(self.startButton)
        
        testLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            testLable.topAnchor.constraint(equalTo: self.bodyView.topAnchor),
            testLable.leadingAnchor.constraint(equalTo: self.bodyView.leadingAnchor),
            testLable.bottomAnchor.constraint(equalTo: self.startButton.topAnchor),
            testLable.trailingAnchor.constraint(equalTo: self.bodyView.trailingAnchor)
        ])
        
        self.startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.startButton.leadingAnchor.constraint(equalTo: self.bodyView.leadingAnchor, constant: 10),
            self.startButton.bottomAnchor.constraint(equalTo: self.bodyView.bottomAnchor, constant: -10),
            self.startButton.trailingAnchor.constraint(equalTo: self.bodyView.trailingAnchor, constant: -10),
            self.startButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.startButton.addTarget(self, action: #selector(self.handleStartButton(_:)), for: .touchUpInside)
        self.startButton.addTarget(self, action: #selector(self.handleStartButtonTouchDown(_:)), for: .touchDown)
        self.startButton.addTarget(self, action: #selector(self.handleStartButtonCancelTouch(_:)), for: .touchDragExit)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func toggleBody() {
        self.bodyView.isHidden.toggle()
    }
    
    @objc func handleStartButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2,
        animations: {
            self.startButton.backgroundColor = .black
            self.startButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.startButton.backgroundColor = .darkGray
                self.startButton.transform = CGAffineTransform.identity
            }
        })
        
        self.startButtonHandler?()
    }
    
    @objc func handleStartButtonTouchDown(_ sender: Any) {
        UIView.animate(withDuration: 0.2,
        animations: {
            self.startButton.backgroundColor = .black
            self.startButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }
    
    @objc func handleStartButtonCancelTouch(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.startButton.backgroundColor = .darkGray
            self.startButton.transform = CGAffineTransform.identity
        }
    }
    
}

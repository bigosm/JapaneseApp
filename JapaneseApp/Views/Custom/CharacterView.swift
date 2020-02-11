//
//  CharacterView.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 11/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class CharacterView: UIView {
    
    public enum ReadingAidDriection {
        case horizontal
        case vertical
    }
    
    // MARK: - Instance Properties
    
    public let stackView = UIStackView()
    public let titleLabel = UILabel()
    public let readingAidLabel = UILabel()
    public let underlineView = UIView()
    
    public var isReadingAidVisible: Bool = false {
        didSet { self.setupReadingAid() }
    }
    public var readingAidDirection: ReadingAidDriection = .horizontal {
        didSet { self.setupReadingAid() }
    }
    public var readingAidHeight: NSLayoutConstraint!
    public var readingAidWidth: NSLayoutConstraint!

    // MARK: - Object Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    convenience init(readingAidDirection: ReadingAidDriection = .horizontal) {
        self.init(frame: .zero)
        
        self.readingAidDirection = readingAidDirection
        self.readingAidLabel.lineBreakMode = .byCharWrapping
        
        self.setupView()
        self.setupReadingAid()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Position Layout
    
    private func setupReadingAid() {
        self.stackView.removeArrangedSubview(self.readingAidLabel)
        self.readingAidHeight.isActive = false
        self.readingAidWidth.isActive = false
        
        guard isReadingAidVisible else {
            self.readingAidLabel.isHidden = true
            return
        }
        
        self.readingAidLabel.isHidden = false
        if case .horizontal = self.readingAidDirection {
            self.stackView.axis = .vertical
            self.stackView.insertArrangedSubview(self.readingAidLabel, at: 0)
            self.readingAidLabel.numberOfLines = 1
            self.readingAidHeight.isActive = true
        } else {
            self.stackView.axis = .horizontal
            self.stackView.addArrangedSubview(self.readingAidLabel)
            self.readingAidLabel.numberOfLines = 0
            self.readingAidWidth.isActive = true
        }
    }
    
    private func setupView() {
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.addSubview(self.underlineView)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.underlineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.underlineView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 2),
            self.underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            self.underlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            self.underlineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            self.underlineView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        self.readingAidLabel.translatesAutoresizingMaskIntoConstraints = false
        self.readingAidHeight = self.readingAidLabel.heightAnchor.constraint(equalToConstant: 20)
        self.readingAidWidth = self.readingAidLabel.widthAnchor.constraint(equalToConstant: 20)
    }
    
}

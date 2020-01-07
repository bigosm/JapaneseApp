//
//  QuestionGroupCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class QuestionGroupCell: UITableViewCell {
    
    public var titleLabel = UILabel()
    public var percentageLabel = UILabel()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.titleLabel.font = .preferredFont(forTextStyle: .headline)
        
        self.addSubview(self.percentageLabel)
        self.percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.percentageLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.percentageLabel.widthAnchor.constraint(equalToConstant: 50),
            self.percentageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.percentageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20)
        ])
        
        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.percentageLabel.leadingAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  TextFieldTableViewCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 09/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class TextFieldCell: UITableViewCell {
    
    // MARK: - Theme
    
    private var themeBackgroundColor = Theme.secondaryBackgroundColor
    
    // MARK: - Instance Properties
    
    public var textDidChange: ((String) -> ())?
    
    public var textField = UITextField()
    public var placeholder: String {
        get { self.textField.placeholder ?? "" }
        set { self.textField.placeholder = newValue}
    }
    
    // MARK: - Object Lifecycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textField.delegate = self
        self.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        self.setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.textDidChange?(textField.text!)
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.addSubview(self.textField)
        
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
}

// MARK: - UITextFieldDelegate

extension TextFieldCell: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}

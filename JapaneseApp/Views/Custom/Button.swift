//
//  Button.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 05/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final public class Button: UIButton {
    
    public enum CustomType {
        case primary
        case primaryRounded
        case secondaryRounded
    }
    
    // MARK: - Instance Properties
    
    public var customType: CustomType!
    public var buttonHeight: CGFloat!
    
    public override var isEnabled: Bool {
        didSet {
            self.backgroundColor = Theme.backgroundColor(buttonType: self.customType, state: self.state)
            self.tintColor = Theme.titleColor(buttonType: self.customType, state: self.state)
        }
    }
    
    // MARK: - Object Lifecycle
    
    public convenience init(customType: CustomType) {
        self.init(frame: .zero)
        self.customType = customType
        self.configureTheme()
    }
    
    public override init(frame: CGRect) {
        self.customType = .primary
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    
    private func configureTheme() {
        self.backgroundColor = Theme.backgroundColor(buttonType: self.customType, state: self.state)
        self.tintColor = Theme.titleColor(buttonType: self.customType, state: self.state)
        self.setTitleColor(Theme.titleColor(buttonType: self.customType, state: .normal), for: .normal)
        self.setTitleColor(Theme.titleColor(buttonType: self.customType, state: .disabled), for: .disabled)
        self.titleLabel?.font = Theme.font(buttonType: self.customType)
        if let buttonHeight = Theme.height(buttonType: self.customType) {
            self.buttonHeight = buttonHeight
            self.layer.cornerRadius = buttonHeight / 2
        }
    }
}

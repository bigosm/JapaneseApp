//
//  Theme.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 23/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

class Theme {
    
    // MARK: - Size
    
    enum Size {
        enum Height {
            static let ratio = UIScreen.main.bounds.height / 568.0
            static let scallable = { $0 * ratio }
            static func screen(
                x568: CGFloat, x667: CGFloat? = nil,
                x736: CGFloat? = nil, x812: CGFloat? = nil,
                x896: CGFloat? = nil) -> CGFloat {
                let height = UIScreen.main.bounds.height
                switch height {
                case 896...:
                    if let value = x896 { return value }
                    fallthrough
                case 812...:
                    if let value = x812 { return value }
                    fallthrough
                case 736...:
                    if let value = x736 { return value }
                    fallthrough
                case 667...:
                    if let value = x667 { return value }
                    fallthrough
                case 568...:
                    return x568
                default:
                    fatalError("Size not supported: \(height)")
                }
            }
        }
        
        enum Width {
            static let ratio = UIScreen.main.bounds.height / 320.0
            static let scallabe = { $0 * ratio }
        }

        enum Padding {
            static let standard: CGFloat = Theme.Size.Height.screen(x568: 10, x667: 20)
        }
    }
    
    // MARK: - Class Properties
    
    static let primaryColor = UIColor(named: "primaryColor")
    static let successColor = UIColor(named: "successColor")
    static let alertColor = UIColor(named: "alertColor")
    
    // MARK: Backgrounds
    
    enum Background {
        static let primaryColor = UIColor(named: "primaryBackgroundColor")
        static let secondaryColor = UIColor(named: "secondaryBackgroundColor")
        static let tertiaryColor = UIColor(named: "tertiaryBackgroundColor")
    }
    
    enum Text {
        enum Color {
            static let primary = UIColor(named: "primaryTextColor")
            static let secondary = UIColor(named: "secondaryTextColor")
        }
    }
    
    // MARK: Buttons
    
    static let disabledPrimaryButtonColor: UIColor? = nil
    static let disabledPrimaryButtonTitleColor = UIColor(named: "disabledButtonColor")
    static let disabledPrimaryRoundedButtonColor = UIColor(named: "disabledRoundedButtonColor")
    static let disabledPrimaryRoundedButtonTitleColor = UIColor(named: "disabledRoundedButtonTitleColor")
    static let disabledSecondaryRoundedButtonColor: UIColor? = nil
    static let disabledSecondaryRoundedButtonTitleColor: UIColor? = nil
    
    static let primaryButtonColor: UIColor? = nil
    static let primaryButtonColorHighlighted: UIColor? = nil
    static let primaryButtonTitleColor = UIColor(named: "primaryButtonColor")
    static let primaryButtonTitleColorHighlighted: UIColor? = UIColor(named: "primaryButtonTitleColorHighlighted")
    static let primaryButtonFont = UIFont.boldSystemFont(ofSize: 20)
    static let primaryButtonHeight: CGFloat = 46
    
    static let primaryRoundedButtonColor = UIColor(named: "primaryRoundedButtonColor")
    static let primaryRoundedButtonColorHighlighted = UIColor(named: "primaryRoundedButtonColorHighlighted")
    static let primaryRoundedButtonTitleColor = UIColor(named: "primaryRoundedButtonTitleColor")
    static let primaryRoundedButtonTitleColorHighlighted = UIColor(named: "primaryRoundedButtonTitleColorHighlighted")
    static let primaryRoundedButtonFont = UIFont.boldSystemFont(ofSize: 20)
    static let primaryRoundedButtonHeight: CGFloat = 46
    
    static let secondaryRoundedButtonColor = UIColor(named: "secondaryRoundedButtonColor")
    static let secondaryRoundedButtonTitleColor = UIColor(named: "secondaryRoundedButtonTitleColor")
    static let secondaryRoundedButtonFont = UIFont.boldSystemFont(ofSize: 20)
    static let secondaryRoundedButtonHeight: CGFloat = 46
    
    static func backgroundColor(buttonType: Button.CustomType, state: Button.State) -> UIColor? {
        switch (buttonType, state) {
        case (.primary, .normal):
            return primaryButtonColor
        case (.primary, .highlighted):
            return primaryButtonColorHighlighted
        case (.primary, .disabled):
            return disabledPrimaryButtonColor
        case (.primaryRounded, .normal):
            return primaryRoundedButtonColor
        case (.primaryRounded, .highlighted):
            return primaryRoundedButtonColorHighlighted
        case (.primaryRounded, .disabled),
             (.primaryRounded, [.highlighted, .disabled]):
            return disabledPrimaryRoundedButtonColor
        case (.secondaryRounded, .normal):
            return secondaryRoundedButtonColor
        case (.secondaryRounded, .disabled):
            return disabledSecondaryRoundedButtonColor
        default:
            Log.warning("[\(type(of: self))] [\(#function)] \n - Case notdefined - buttonType: `\(buttonType)`, state: `\(state)`")
            return nil
        }
    }
    
    static func titleColor(buttonType: Button.CustomType, state: Button.State) -> UIColor? {
        switch (buttonType, state) {
        case (.primary, .normal):
            return primaryButtonTitleColor
        case (.primary, .highlighted):
            return primaryButtonTitleColorHighlighted
        case (.primary, .disabled):
            return primaryRoundedButtonTitleColor
        case (.primaryRounded, .normal):
            return primaryRoundedButtonTitleColor
        case (.primaryRounded, .highlighted):
            return primaryRoundedButtonTitleColorHighlighted
        case (.primaryRounded, .disabled),
             (.primaryRounded, [.highlighted, .disabled]):
            return disabledPrimaryRoundedButtonTitleColor
        case (.secondaryRounded, .normal):
            return secondaryRoundedButtonTitleColor
        case (.secondaryRounded, .disabled):
            return disabledSecondaryRoundedButtonTitleColor
        default:
            Log.warning("[\(type(of: self))] [\(#function)] \n - Case notdefined - buttonType: `\(buttonType)`, state: `\(state)`")
            return nil
        }
    }
    
    static func font(buttonType: Button.CustomType) -> UIFont? {
        switch buttonType {
        case .primary:
            return primaryButtonFont
        case .primaryRounded:
            return primaryRoundedButtonFont
        case .secondaryRounded:
            return secondaryRoundedButtonFont
        }
    }
    
    static func height(buttonType: Button.CustomType) -> CGFloat? {
        switch buttonType {
        case .primary:
            return primaryButtonHeight
        case .primaryRounded:
            return primaryRoundedButtonHeight
        case .secondaryRounded:
            return secondaryRoundedButtonHeight
        }
    }

}

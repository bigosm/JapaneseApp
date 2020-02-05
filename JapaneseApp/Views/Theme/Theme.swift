//
//  Theme.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 23/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class Theme {
    
    // MARK: - Class Properties
    
    public static let primaryColor      = UIColor(named: "primaryColor")
    public static let successColor      = UIColor(named: "successColor")
    public static let alertColor        = UIColor(named: "alertColor")
    
    // MARK: Backgrounds
    
    public static let primaryBackgroundColor        = UIColor(named: "primaryBackgroundColor")
    public static let secondaryBackgroundColor      = UIColor(named: "secondaryBackgroundColor")
    public static let tertiaryBackgroundColor       = UIColor(named: "tertiaryBackgroundColor")
    
    // MARK: Buttons
    
    public static let disabledPrimaryButtonColor: UIColor?                  = nil
    public static let disabledPrimaryButtonTitleColor                       = UIColor(named: "disabledButtonColor")
    public static let disabledPrimaryRoundedButtonColor                     = UIColor(named: "disabledRoundedButtonColor")
    public static let disabledPrimaryRoundedButtonTitleColor                = UIColor(named: "disabledRoundedButtonTitleColor")
    public static let disabledSecondaryRoundedButtonColor: UIColor?         = nil
    public static let disabledSecondaryRoundedButtonTitleColor: UIColor?    = nil
    
    public static let primaryButtonColor: UIColor?          = nil
    public static let primaryButtonTitleColor               = UIColor(named: "primaryButtonColor")
    public static let primaryButtonFont                     = UIFont.boldSystemFont(ofSize: 20)
    public static let primaryButtonHeight: CGFloat          = 46
    
    public static let primaryRoundedButtonColor             = UIColor(named: "primaryRoundedButtonColor")
    public static let primaryRoundedButtonTitleColor        = UIColor(named: "primaryRoundedButtonTitleColor")
    public static let primaryRoundedButtonFont              = UIFont.boldSystemFont(ofSize: 20)
    public static let primaryRoundedButtonHeight: CGFloat   = 46
    
    public static let secondaryRoundedButtonColor           = UIColor(named: "secondaryRoundedButtonColor")
    public static let secondaryRoundedButtonTitleColor      = UIColor(named: "secondaryRoundedButtonTitleColor")
    public static let secondaryRoundedButtonFont            = UIFont.boldSystemFont(ofSize: 20)
    public static let secondaryRoundedButtonHeight: CGFloat = 46
    
    public static func backgroundColor(buttonType: Button.CustomType, state: Button.State) -> UIColor? {
        switch (buttonType, state) {
        case (.primary, .normal):               return primaryButtonColor
        case (.primary, .disabled):             return disabledPrimaryButtonColor
        case (.primaryRounded, .normal):        return primaryRoundedButtonColor
        case (.primaryRounded, .disabled):      return disabledPrimaryRoundedButtonColor
        case (.secondaryRounded, .normal):      return secondaryRoundedButtonColor
        case (.secondaryRounded, .disabled):    return disabledSecondaryRoundedButtonColor
        default:
            print("[Theme] [\(#function)] Case notdefined - buttonType: `\(buttonType)`, state: `\(state)`")
            return nil
        }
    }
    
    public static func titleColor(buttonType: Button.CustomType, state: Button.State) -> UIColor? {
        switch (buttonType, state) {
        case (.primary, .normal):   return primaryButtonTitleColor
        case (.primary, .disabled): return primaryRoundedButtonTitleColor
        case (.primaryRounded, .normal):   return primaryRoundedButtonTitleColor
        case (.primaryRounded, .disabled): return disabledPrimaryRoundedButtonTitleColor
        case (.secondaryRounded, .normal):     return secondaryRoundedButtonTitleColor
        case (.secondaryRounded, .disabled):   return disabledSecondaryRoundedButtonTitleColor
        default:
            print("[Theme] [\(#function)] Case notdefined - buttonType: `\(buttonType)`, state: `\(state)`")
            return nil
        }
    }
    
    public static func font(buttonType: Button.CustomType) -> UIFont? {
        switch buttonType {
        case .primary:          return primaryButtonFont
        case .primaryRounded:   return primaryRoundedButtonFont
        case .secondaryRounded: return secondaryRoundedButtonFont
        default:
            print("[Theme] [\(#function)] Case notdefined - buttonType: `\(buttonType)`")
            return nil
        }
    }
    
    public static func height(buttonType: Button.CustomType) -> CGFloat? {
        switch buttonType {
        case .primary:          return primaryButtonHeight
        case .primaryRounded:   return primaryRoundedButtonHeight
        case .secondaryRounded: return secondaryRoundedButtonHeight
        default:
            print("[Theme] [\(#function)] Case notdefined - buttonType: `\(buttonType)`")
            return nil
        }
    }

}

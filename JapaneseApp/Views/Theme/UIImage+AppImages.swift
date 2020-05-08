//
//  UIImage+AppImages.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

extension UIImage {
    enum App: String {
        case practiceTab
        case profileTab
        
        var image: UIImage {
            switch self {
            case .practiceTab: return UIImage(systemName: "pencil.tip.crop.circle")!
            case .profileTab: return UIImage(systemName: "person.crop.circle.fill")!
            }
        }
    }
}

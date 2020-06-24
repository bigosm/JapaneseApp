//
//  UIView+Constraints.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 29/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

extension UIView {
    func fillSuperview(padding: CGFloat = 0) {
        guard let view = self.superview else { return }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    }
}

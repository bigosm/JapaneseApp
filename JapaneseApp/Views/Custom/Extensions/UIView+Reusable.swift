//
//  UIView+Reusable.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 22/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

extension UIView {
    public static var defaultReusableId: String {
        String(describing: self)
    }
}

extension UITableView {
    
    // MARK: - Registration
    
    public func register<T: UITableViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: T.defaultReusableId)
    }

    // MARK: - Reuse
    
    public func dequeueReusableCell<T: UITableViewCell>(
        withClass cellClass: T.Type,
        for indexPath: IndexPath) -> T
    {
        print("❤️", cellClass.defaultReusableId)
        guard let cell = self.dequeueReusableCell(withIdentifier: cellClass.defaultReusableId, for: indexPath) as? T else {
            fatalError("TableView should be able to dequeue cell.")
        }
        return cell
    }
}

//
//  TableViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 22/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "No XIB")
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable, message: "No XIB")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TableViewCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 23/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable, message: "No XIB")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  QuestionView.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class QuestionView: UIView {
    
    public var answerLabel = UILabel()
    public var prompLabel = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.answerLabel)
        self.addSubview(self.prompLabel)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

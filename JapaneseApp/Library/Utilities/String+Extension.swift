//
//  String+Extension.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 23/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation


extension String {
    
    // MARK: - Count Japanese characters
    
    public var numberOfHiraganaCharacters: Int {
        return self.numberOfMatches(pattern: #"\p{Hiragana}"#)
    }
    
    public var numberOfKatakanaCharacters: Int {
        return self.numberOfMatches(pattern: #"\p{Katakana}"#)
    }
    
    public var numberOfKanjiCharacters: Int {
        return self.numberOfMatches(pattern: #"\p{Han}"#)
    }
    
    private func numberOfMatches(pattern: String) -> Int {
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.numberOfMatches(in: self, options: [], range: range)
    }
    
}

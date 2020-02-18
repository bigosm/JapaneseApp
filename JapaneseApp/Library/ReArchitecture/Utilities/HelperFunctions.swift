//
//  HelperFunctions.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

internal func bundleLoad<T: Codable>(resource: String, type: T.Type) -> T {
    let bundle = Bundle.main
    let url = bundle.url(forResource: resource, withExtension: "json")!
    
    return try! DiskCaretaker.retrieve(T.self, from: url)
}

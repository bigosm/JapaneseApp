//
//  APIClientTask.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 16/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

struct APIClientTask<T> {
    let task: URLSessionTask
    let id: UUID
    let promise: Promise<T>
    
    func send() { task.resume() }
}

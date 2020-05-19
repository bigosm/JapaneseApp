//
//  APIClientTask.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 16/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol APIClientTaskType {
    var task: URLSessionTask { get }
    var id: UUID { get }
    
    func resume()
}

struct APIClientTask<T>: APIClientTaskType {
    let task: URLSessionTask
    let id: UUID
    let promise: Promise<T>
    
    func resume() { task.resume() }
}

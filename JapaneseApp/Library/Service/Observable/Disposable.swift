//
//  Disposable.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 11/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

class Disposable {
    let dispose: () -> Void
    
    init(_ dispose: @escaping () -> Void) {
        self.dispose = dispose
    }
    
    deinit { dispose() }

    func disposed(by bag: DisposeBag) {
        bag.append(self)
    }
}

class DisposeBag {
    private var disposables: [Disposable] = []

    func append(_ disposable: Disposable) {
        disposables.append(disposable)
    }
    
    func append(_ disposable: [Disposable]) {
        disposables += disposables
    }
}

extension Array where Element: Disposable {
    func disposed(by bag: DisposeBag) {
        bag.append(self)
    }
}

//
//  Observable.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 11/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class Observable<T: Equatable> {

    typealias BindingAction = (T) -> Void

    private class Observer {
        var bindingAction:  BindingAction
        var bindingType:    BindingType

        init(withType type: BindingType = .initial,_ action: @escaping BindingAction) {
            self.bindingType = type
            self.bindingAction = action
        }

        func notify(value: T, oldValue: T) {
            guard !(bindingType.contains(.update) && value == oldValue) else { return }

            bindingAction(value)
        }
    }
    
    private var observers: [UUID: Observer] = [:]

    var value: T {
        didSet {
            observers.values.forEach {
                $0.notify(value: value, oldValue: oldValue)
            }
        }
    }

    init(_ value: T) {
        self.value = value
    }

    private init(optionalValue: T) {
        value = optionalValue
    }

    func bind(_ type: BindingType = .initial, action: @escaping BindingAction) -> Disposable {

        let identifier = UUID()
        observers[identifier] = Observer(withType: type, action)

        if type.contains(.initial) {
            action(value)
        }

        return Disposable { [weak self] in
            self?.observers.removeValue(forKey: identifier)
        }
    }
}

extension Observable where T: ExpressibleByNilLiteral {
    convenience init(_ value: T = nil) {
        self.init(optionalValue: value)
    }
}

struct BindingType: OptionSet {
    let rawValue: Int

    static let initial  = BindingType(rawValue: 1 << 0)
    static let new      = BindingType(rawValue: 1 << 1)
    static let update   = BindingType(rawValue: 1 << 2)
}


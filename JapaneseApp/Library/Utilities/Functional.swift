//
//  Functional.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 11/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

/// This turns an
/// (A) -> B function into a
/// () -> B function, by using a constant value for A.
func combine<A, B>(_ value: A,
                   with closure: @escaping (A) -> B) -> () -> B {
    return { closure(value) }
}

/// This turns an
/// (A) -> B and a (B) -> C function into a
/// (A) -> C function, by chaining them together.
func chain<A, B, C>(_ inner: @escaping (A) -> B,
                    to outer: @escaping (B) -> C) -> (A) -> C {
    return { outer(inner($0)) }
}


/// This turns an
/// (A) -> B and a (B) -> () -> C function into a
/// (A) -> C function, by chaining them together.
func chain<A, B, C>(
    _ inner: @escaping (A) -> B,
    to outer: @escaping (B) -> () -> C
) -> (A) -> C {
    // Similar to our previous version of chain, we pass the result
    // of the inner function into the outer one — but since that
    // now returns another function, we'll also call that one.
    return { outer(inner($0))() }
}

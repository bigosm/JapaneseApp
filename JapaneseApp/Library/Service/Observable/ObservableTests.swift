//
//  ObservableTests.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 11/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import JapaneseApp

class ObservableTest: XCTestCase {

    var disposeBag: DisposeBag = DisposeBag()


    override func setUp() {
        disposeBag = DisposeBag()
    }

    override func tearDown() {
    }

    func test_initAnObservable_setValue() {
        let expectedValue = "Test"
        let obs = Observable(expectedValue)
        
        XCTAssertEqual(expectedValue, obs.value, "Observable value should be initialized with the parameter")
    }

    func test_observableBindedByDefault_shouldReturnInitialValue() {
        let expectedValue = "Test"
        let obs = Observable(expectedValue)
        let expectation = XCTestExpectation(description: "bindClosure is called with initial value")
        expectation.assertForOverFulfill = true
        expectation.expectedFulfillmentCount = 2
        
        obs.bind { (value) in
            expectation.fulfill()
        }.disposed(by: disposeBag)
        
        obs.value = expectedValue
        
        wait(for: [expectation], timeout: 0.05)
    }

    func test_observableBindedWithNew_shouldReturnNewValue() {
        let expectedValue = "TestNew"
        let obs = Observable("New")
        let expectation = XCTestExpectation(description: "bindClosure should be called with new value")
        expectation.assertForOverFulfill = true

        obs.bind(.new) { value in
            XCTAssertEqual(expectedValue, value)
            expectation.fulfill()
        }.disposed(by: disposeBag)

        obs.value = expectedValue

        wait(for: [expectation], timeout: 0.05)
    }

    func test_observableBindedWithUpdate_shouldReturnNewValueIfItIsDifferent() {
        let expectedValue = "TestUpdate"
        let obs = Observable("Update")
        let expectation = XCTestExpectation(description: "bindClosure should be called with update value")
        expectation.assertForOverFulfill = true

        obs.bind(.update) { value in
            XCTAssertEqual(expectedValue, value)
            expectation.fulfill()
        }.disposed(by: disposeBag)

        obs.value = expectedValue

        wait(for: [expectation], timeout: 0.05)
    }

    func test_observableBindedWithUpdate_shouldNotReturnNewValueIfItIsTheSame() {
        let expectedValue = "Same"
        let obs = Observable("Same")
        let expectation = XCTestExpectation(description: "bindClosure should be called with update value")
        expectation.isInverted = true

        obs.bind(.update) { (value) in
            expectation.fulfill()
        }.disposed(by: disposeBag)

        obs.value = expectedValue

        wait(for: [expectation], timeout: 0.05)
    }

    func test_observableBindedWithInitialAndUpdate_shouldReturnNewValueOnlyOnceIfItIsTheSame() {
        let expectedValue = "Same"
        let obs = Observable("Same")
        let expectation = XCTestExpectation(description: "bindClosure should be called with update value")
        expectation.assertForOverFulfill = true
        
        obs.bind([.initial, .update]) { Value in
            expectation.fulfill()
        }.disposed(by: disposeBag)

        obs.value = expectedValue

        wait(for: [expectation], timeout: 0.05)
    }

    func test_observableBindedWithInitialAndUpdate_shouldReturnValueTwiceIfItIsTheChange() {
        let expectedValue = "Same"
        let obs = Observable("Same")
        let expectation = XCTestExpectation(description: "bindClosure should be called with update value")
        expectation.expectedFulfillmentCount = 2
        expectation.assertForOverFulfill = true
        
        obs.bind([.initial, .update]) { (value) in
            expectation.fulfill()
        }.disposed(by: disposeBag)

        obs.value = expectedValue
        obs.value = "ChangedValue"

        wait(for: [expectation], timeout: 0.05)
    }

    func test_observableInitWithoutObject_returnsAnOptionalOfTheObject() {
        let expectedValue = "AnString"
        let expectation = XCTestExpectation(description: "bindClosure should be called with an expected string value")
        let obs: Observable<String?> = Observable()

        obs.bind(.update) { value in
            if value == expectedValue {
                expectation.fulfill()
            }
        }.disposed(by: disposeBag)

        obs.value = expectedValue
        
        wait(for: [expectation], timeout: 0.05)
    }

}


//
//  ArithmosophiOSXTests.swift
//  ArithmosophiOSXTests
//
//  Created by phimage on 16/06/15.
//  Copyright (c) 2015 phimage. All rights reserved.
//

import Cocoa
import XCTest
import Arithmosophi

class ArithmosophiOSXTests: XCTestCase {

    let aInt = [1, 2, 3, 4]
    let aString = ["a","b","c","d"]
    let aArray = [["a", "b"], ["c"], ["d"]]

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSumInt() {
        let value = aInt.sum
        let expected = 1 + 2 + 3 + 4
        XCTAssertEqual(value, expected)
    }
    func testProductInt() {
        let value = aInt.product
        let expected = 1 * 2 * 3 * 4
        XCTAssertEqual(value, expected)
    }
    func testSumString() {
        let value = aString.sum
        let expected = aString.joinWithSeparator("")
        XCTAssertEqual(value, expected)
    }
    func testSumArray() {
        let value = aArray.sum
        let expected = aArray.flatMap {$0}
        XCTAssertEqual(value, expected)
    }

}

//
//  TestsSharedPackage.swift
//  TestsSharedPackage
//
//  Created by Stijn Willems on 19/03/2021.
//

import XCTest
@testable import SharedPackage

class SquareTests: XCTestCase {

    func test_init() {
        let square = Square(status: .nobody)
        XCTAssertEqual(square.status, .nobody)
    }
    
    func test_bindable_status() {
        XCTFail()
    }
}

//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Stijn Willems on 19/03/2021.
//

import XCTest

class Tests_launch_performance_iOS: XCTestCase {
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

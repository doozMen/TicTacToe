//
//  TicTacToeUITests__iOS_.swift
//  TicTacToeUITests (iOS)
//
//  Created by Stijn Willems on 20/03/2021.
//

import XCTest

class TicTacToeUITests__macOS_: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_tap_circles_reset() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let resetButton = app.buttons["Reset"]
        XCTAssertTrue(resetButton.waitForExistence(timeout: 2))
        
        let firstCircle = app.otherElements["Square-0"]
        XCTAssertTrue(firstCircle.waitForExistence(timeout: 2))
        firstCircle.tap()
        XCTAssertEqual(firstCircle.label, "Square 1 - from you")
        resetButton.tap()
        XCTAssertEqual(firstCircle.label, "Square 1 - from nobody yet")
        let gameStatusTextView = app.staticTexts["Game Status Text"]
        XCTAssertTrue(gameStatusTextView.waitForExistence(timeout: 2))
        XCTAssertEqual(gameStatusTextView.value as? String, "no winner yet")
    }

}

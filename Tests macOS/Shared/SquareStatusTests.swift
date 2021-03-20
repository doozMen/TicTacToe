import Foundation
import XCTest
@testable import TicTacToe

final class SquareStatusTests: XCTestCase {
    func test_init() {
        let square = Square(status: .nobody)
        XCTAssertEqual(square.status, .nobody)
    }
}

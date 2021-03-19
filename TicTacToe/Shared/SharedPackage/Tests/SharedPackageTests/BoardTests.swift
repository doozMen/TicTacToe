import Foundation
import XCTest
@testable import SharedPackage

final class BoardTests: XCTestCase {
    func test_board_setup() {
        let board = Board()
        let result = board.squares.map(\.occupiedBy)
        XCTAssertEqual(result, Array(repeating: Square.OccupiedBy.nobody, count: 9))
    }
}

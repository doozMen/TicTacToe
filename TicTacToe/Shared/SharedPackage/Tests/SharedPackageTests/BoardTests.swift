import Foundation
import XCTest
@testable import SharedPackage

final class BoardTests: XCTestCase {
    var board: Board!
    override func setUp() {
        super.setUp()
        board = Board()
    }
    
    func test_board_initial_nobody_on_any_square() {
        let result = board.squares.map(\.occupiedBy)
        XCTAssertEqual(result, Array(repeating: Square.OccupiedBy.nobody, count: 9))
    }
    
    func test_board_gameover() throws {
        var result = false
        let cancelable = board
            .$isGameOver
            .sink { result = $0 }
        
        XCTAssertFalse(result, "initially the game should be ongoing")
        
        board.squares.first?.occupiedBy = .home
        
        XCTAssertTrue(result, "A game ends if there are no more boxes available or if one of the two players align three symbols before the other.")
        cancelable.cancel()
    }
}

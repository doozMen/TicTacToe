import Foundation
import XCTest
@testable import SharedPackage

final class BoardTests: XCTestCase {
    var board: Board!
    override func setUp() {
        super.setUp()
        board = Board()
    }
    
    override func tearDown() {
        board = nil
        super.tearDown()
    }
    
    func test_board_initial_nobody_on_any_square() {
        let result = board.squares.map(\.occupiedBy)
        XCTAssertEqual(result, Array(repeating: Square.OccupiedBy.nobody, count: 9))
    }
    
    func test_board_started() throws {
        board.squares.first?.occupiedBy = .home
        XCTAssertEqual(
            board.squares.map(\.occupiedBy),
            [.home, .nobody, .nobody, .nobody, .nobody, .nobody, .nobody, .nobody, .nobody]
        )
    }
    
    func test_board_gameover() throws {
        var result = false
        var callCount = 0
        let cancelable = board
            .$isGameover
            .sink { isGameOver in
                result = isGameOver
                callCount += 1
            }
        
        XCTAssertFalse(result, "initially the game should be ongoing")
        
        for i in 0...8 {
            board.squares[i].occupiedBy = .home
        }
        
        XCTAssertEqual(
            board.squares.map(\.occupiedBy),
            [.home, .home, .home, .home, .home, .home, .home, .home, .home]
        )
        
        XCTAssertEqual(callCount, 2)
        
        XCTAssertTrue(result, "A game ends if there are no more boxes available or if one of the two players align three symbols before the other.")
        cancelable.cancel()
    }
    
    func test_board_almost_gameover() throws {
        var result = false
        let cancelable = board
            .$isGameover
            .sink { isGameOver in
                result = isGameOver
            }
        
        XCTAssertFalse(result, "initially the game should be ongoing")
        
        for i in 0...1 {
            board.squares[i].occupiedBy = .home
        }
        
        XCTAssertEqual(
            board.squares.map(\.occupiedBy),
            [.home, .home, .nobody, .nobody, .nobody, .nobody, .nobody, .nobody, .nobody]
        )
        XCTAssertFalse(result, "A game ends if there are no more boxes available or if one of the two players align three symbols before the other.")
        cancelable.cancel()
    }
}

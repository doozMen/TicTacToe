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
        XCTAssertFalse(board.isStarted)
    }
    
    func test_board_started() throws {
        board.occupy(at: .init(item: 0, section: 1), with: .home)
        
        XCTAssertTrue(board.isStarted)
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

        let row: [IndexPath] = [.init(item: 0, section: 0), .init(item: 1, section: 0), .init(item: 2, section: 0) ]
        let indexRows: [[IndexPath]] = [row, row, row]
        for row in indexRows {
            for indexPath in row {
                board.occupy(at: indexPath, with: .home)
            }
        }

        XCTAssertEqual(callCount, 2)

        XCTAssertTrue(result, "A game ends if there are no more boxes available or if one of the two players align three symbols before the other.")
        cancelable.cancel()
    }
//
//    func test_board_almost_gameover() throws {
//        var result = false
//        let cancelable = board
//            .$isGameover
//            .sink { isGameOver in
//                result = isGameOver
//            }
//
//        XCTAssertFalse(result, "initially the game should be ongoing")
//
//        for i in 0...1 {
//            board.squares[i].occupiedBy = .home
//        }
//
//        XCTAssertEqual(
//            board.squares.map(\.occupiedBy),
//            [.home, .home, .nobody, .nobody, .nobody, .nobody, .nobody, .nobody, .nobody]
//        )
//        XCTAssertFalse(result, "A game ends if there are no more boxes available or if one of the two players align three symbols before the other.")
//        cancelable.cancel()
//    }
}

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
    
    func test_board_started() {
        board.occupy(at: .init(item: 0, section: 1), with: .home)
        
        XCTAssertTrue(board.isStarted)
    }
    
    func test_board_reset() {
        board.occupy(at: .init(item: 0, section: 1), with: .home)
        XCTAssertTrue(board.isStarted)
        board.resetGame()
        
        XCTAssertFalse(board.isStarted)
        XCTAssertFalse(board.isGameover)
    }
    
    
    func test_board_gameover() throws {
        var result = false
        var callCount = 0
        let cancelable = board
            .$isGameover
            .removeDuplicates()
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

        XCTAssertEqual(callCount, 2, "as the value of isGameover changes initialy and when it is gameover this should be exacly 2")

        XCTAssertTrue(result, "A game ends if there are no more boxes available or if one of the two players align three symbols before the other.")
        
        cancelable.cancel()
    }

    func test_board_almost_gameover() throws {
        var result = false
        var callCount = 0
        let cancelable = board
            .$isGameover
            .removeDuplicates()
            .sink { isGameOver in
                result = isGameOver
                callCount += 1
            }
        
        XCTAssertFalse(result, "initially the game should be ongoing")
        
        let row: [IndexPath] = [.init(item: 0, section: 0), .init(item: 1, section: 0), .init(item: 2, section: 0) ]
        let indexRows: [[IndexPath]] = [row, row, row]
        for row in indexRows {
            for indexPath in row where indexPath.item != 0 && indexPath.section != 0 {
                board.occupy(at: indexPath, with: .home)
            }
        }
        
        XCTAssertEqual(callCount, 1, "there is no value change for gameOver so this should stay false")
        
        XCTAssertFalse(result, "left one square occupied by nobody so game is not yet over")
        
        cancelable.cancel()
    }
    
    func test_check_there_is_a_winner() {
        XCTAssertEqual(board.winner, .nobody)
        
        board.occupy(at: .init(item: 0, section: 0), with: .home)
        board.occupy(at: .init(item: 1, section: 0), with: .home)
        board.occupy(at: .init(item: 2, section: 0), with: .home)
        
        XCTAssertEqual(board.winner, .home)
    }
}

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
        try board.occupy(at: .init(item: 0, section: 1), with: .home)
        
        XCTAssertTrue(board.isStarted)
    }
    
    func test_board_reset() throws {
        try board.occupy(at: .init(item: 0, section: 1), with: .home)
        XCTAssertTrue(board.isStarted)
        try board.resetGame()
        
        XCTAssertFalse(board.isStarted)
        XCTAssertFalse(board.isGameover)
    }
    
    func test_out_of_bounds_occupy() throws {
        XCTAssertThrowsError(try board.occupy(at: .init(item: 9, section: 9), with: .home))
    }
    
    func test_do_not_allow_to_change_occupied_square() {
        XCTFail()
    }
    
    // MARK: - Occupied
    
    func test_square_occupied() throws {
        let indexPath = IndexPath(item: 0, section: 0)
        try board.occupy(at: indexPath, with: .home)
        XCTAssertTrue(board.isOccupied(at: indexPath))
    }
    
    // MARK: - Gameover
    
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
                try board.occupy(at: indexPath, with: .home)
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
                try board.occupy(at: indexPath, with: .home)
            }
        }
        
        XCTAssertEqual(callCount, 1, "there is no value change for gameOver so this should stay false")
        
        XCTAssertFalse(result, "left one square occupied by nobody so game is not yet over")
        
        cancelable.cancel()
    }
    
    // MARK: - Winners
    
    func test_check_winner_rows() throws {
        XCTAssertEqual(board.winner, .nobody)
        let candidates: [Square.OccupiedBy] = [.home, .visitor]

        for candidate in candidates {
            for row in 0..<3 {
                try board.occupy(at: .init(item: 0, section: row), with: candidate)
                try board.occupy(at: .init(item: 1, section: row), with: candidate)
                try board.occupy(at: .init(item: 2, section: row), with: candidate)
                
                XCTAssertEqual(board.winner, candidate)
                try board.resetGame()
            }
        }
    }
    
    func test_check_winner_columns() throws {
        XCTAssertEqual(board.winner, .nobody)
        let candidates: [Square.OccupiedBy] = [.home, .visitor]
        
        for candidate in candidates {
            for column in 0..<3 {
                try board.occupy(at: .init(item: column, section: 0), with: candidate)
                try board.occupy(at: .init(item: column, section: 1), with: candidate)
                try board.occupy(at: .init(item: column, section: 2), with: candidate)
                
                XCTAssertEqual(board.winner, candidate)
                try board.resetGame()
            }
        }
    }
    
    func test_check_winner_diagonals() throws {
        XCTAssertEqual(board.winner, .nobody)
        let candidates: [Square.OccupiedBy] = [.home, .visitor]
        
        for candidate in candidates {
            try board.occupy(at: .init(item: 0, section: 0), with: candidate)
            try board.occupy(at: .init(item: 1, section: 1), with: candidate)
            try board.occupy(at: .init(item: 2, section: 2), with: candidate)
            
            XCTAssertEqual(board.winner, candidate)
            try board.resetGame()
        }
        
        for candidate in candidates {
            try board.occupy(at: .init(item: 2, section: 0), with: candidate)
            try board.occupy(at: .init(item: 1, section: 1), with: candidate)
            try board.occupy(at: .init(item: 0, section: 2), with: candidate)
            
            XCTAssertEqual(board.winner, candidate)
            try board.resetGame()
        }
    }
    
}

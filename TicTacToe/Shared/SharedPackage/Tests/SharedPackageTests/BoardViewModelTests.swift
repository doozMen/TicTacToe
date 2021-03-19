import Foundation
import XCTest
@testable import SharedPackage

final class BoardViewModelTests: XCTestCase {
    var viewModel: BoardViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = BoardViewModel(.init())
    }
    
    func test_text_for_winner() throws {
       
        try makeAWinningRow(in: viewModel.board, section: 0, candidate: .home)
        
        XCTAssertEqual(viewModel.winnerName, "home")
    }
    
    func test_visitor_plays_random() throws {
        let board = Board(mode: .ai)
        let viewModel = BoardViewModel(board)
        try viewModel.board.occupy(at: .init(item: 0, section: 0), with: .home)
        let result = viewModel.board.flatSquares.map(\.occupiedBy)
        XCTAssertTrue(result.contains(.home) && result.contains(.visitor))
    }
}

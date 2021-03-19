import Foundation
import XCTest
@testable import SharedPackage

final class BoardViewModelTests: XCTestCase {
    func test_text_for_winner() throws {
        let board = Board()
        let viewModel = BoardViewModel(board: board)
        try makeAWinningRow(in: board, section: 0, candidate: .home)
        
        XCTAssertEqual(viewModel.winnerName, "home")
    }
}

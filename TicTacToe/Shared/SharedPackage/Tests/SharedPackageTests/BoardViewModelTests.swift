import Foundation
import XCTest
@testable import SharedPackage

final class BoardViewModelTests: XCTestCase {
    func test_text_for_winner() {
        let board = Board()
        let viewModel = BoardViewModel(board: board)
        XCTAssertEqual(viewModel.winnerName, "home")
    }
}

import Foundation
import Combine

final class Board: ObservableObject {
    private let squares: [[Square]]
    
    @Published private(set) var isGameover: Bool
    @Published private(set) var isStarted: Bool
    @Published private(set) var winner: Square.OccupiedBy
    
    /// This matrix is used to find indexes to check all
    /// possible wining triplets in board[0..8]
    private let wins: [[Int]] = [
        [0, 1, 2], // Check first row.
        [3, 4, 5], // Check second Row
        [6, 7, 8], // Check third Row
        [0, 3, 6], // Check first column
        [1, 4, 7], // Check second Column
        [2, 5, 8], // Check third Column
        [0, 4, 8], // Check first Diagonal
        [2, 4, 6]  // Check second Diagonal
    ]
    
    init() {
        self.squares = [
            [.init(.nobody), .init(.nobody), .init(.nobody)],
            [.init(.nobody), .init(.nobody), .init(.nobody)],
            [.init(.nobody), .init(.nobody), .init(.nobody)],
        ]
        self.isGameover = false
        self.isStarted = false
        self.winner = .nobody
    }
    
    func occupy(at indexPath: IndexPath, with player: Square.OccupiedBy) {
        squares[indexPath.item][indexPath.section].occupiedBy = player
        checkGameStatus()
    }
    
    func resetGame() {
        for section in 0...2 {
            for item  in 0...2 {
                occupy(at: .init(item: item, section: section), with: .nobody)
            }
        }
        checkGameStatus()
    }
    
    func checkForWinner() {
        
    }
    private func checkGameStatus() {
        let flatSquares: [Square] = squares.flatMap { $0 }
        isGameover = flatSquares.filter { $0.occupiedBy != .nobody }.count != 0
        isStarted = flatSquares.contains(.init(.home)) || flatSquares.contains(.init(.visitor))
    }
    

}

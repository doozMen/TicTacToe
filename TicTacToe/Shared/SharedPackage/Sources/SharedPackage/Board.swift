import Foundation
import Combine

final class Board: ObservableObject {
    private let squares: [[Square]]
    
    @Published private(set) var isGameover: Bool
    @Published private(set) var isStarted: Bool
        
    init() {
        self.squares = [
            [.init(.nobody), .init(.nobody), .init(.nobody)],
            [.init(.nobody), .init(.nobody), .init(.nobody)],
            [.init(.nobody), .init(.nobody), .init(.nobody)],
        ]
        self.isGameover = false
        self.isStarted = false
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
    
    private func checkGameStatus() {
        let flatSquares: [Square] = squares.flatMap { $0 }
        isGameover = flatSquares.filter { $0.occupiedBy != .nobody }.count != 0
        isStarted = flatSquares.contains(.init(.home)) || flatSquares.contains(.init(.visitor))
    }
}

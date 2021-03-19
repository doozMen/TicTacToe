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
    
    private func checkGameStatus() {
        guard !isGameover else { return }
        
        let flatSquares: [Square] = squares.flatMap { $0 }
        isGameover = flatSquares.first { $0.occupiedBy == .nobody } != nil
        isStarted = flatSquares.contains(.init(.home)) || flatSquares.contains(.init(.visitor))
    }
}

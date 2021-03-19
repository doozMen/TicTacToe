import Foundation
import Combine

final class Board: ObservableObject {
    private let squares: [[Square]]
    
    @Published var isGameover: Bool
    @Published var isStarted: Bool
        
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
        
    }
    
    private func checkGameStatus() {
        guard !isGameover else { return }
        
        let flatSquares: [Square] = squares.flatMap { $0 }
        let unOccupied = flatSquares.first { $0.occupiedBy != .nobody }
        
        if unOccupied == nil {
            isGameover = true
        }
    }
}

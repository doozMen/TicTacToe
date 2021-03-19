import Foundation
import Combine

final class Board {
    let squares: [Square]
    
    @Published var isGameover: Bool
    
    private var squareCancelables = [AnyCancellable]()
    
    init() {
        var squares = [Square]()
        for _ in 0...8 { squares.append(.init(.nobody)) }
        self.squares = squares
        self.isGameover = false
        squares.forEach {
            squareCancelables
                .append(
                    $0.$occupiedBy
                        .sink { [weak self] _ in self?.checkGameStatus() }
                )
        }
    }
    private func checkGameStatus() {
        guard !isGameover else { return }
        
        let unOccupied = squares.first { $0.occupiedBy == .nobody }
        
        if unOccupied == nil {
            isGameover = true
        }
    }
}

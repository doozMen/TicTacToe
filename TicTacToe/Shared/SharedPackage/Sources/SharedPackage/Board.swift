import Foundation
import Combine

final class Board {
    let squares: [Square]
    @Published var isGameOver: Bool
    
    init() {
        self.squares = Array(repeating: .init(.nobody), count: 9)
        self.isGameOver = false
    }
}

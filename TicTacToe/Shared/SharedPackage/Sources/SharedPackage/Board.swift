import Foundation
import Combine

final class Board {
    let squares: [Square]
    init() {
        self.squares = Array(repeating: .init(.nobody), count: 9)
    }
}

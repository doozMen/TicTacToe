import Foundation
import Combine

final class BoardViewModel: ObservableObject {
    let board: Board
    @Published var winnerName: String = "nobody"
    @Published var reset: Bool
    
    private var cancelables: Set<AnyCancellable> = []
    
    init(_ board: Board) {
        self.board = board
        self.reset = false
        board.$winner.sink { [weak self] in
            switch $0 {
                case .nobody:
                    self?.winnerName = "nobody"
                case .visitor:
                    self?.winnerName = "visitor"
                case .home:
                    self?.winnerName = "home"
            }
        }.store(in: &cancelables)
        $reset.sink { [weak self] in
            guard $0 else { return }
            self?.board.resetGame()
        }.store(in: &cancelables)
    }
}

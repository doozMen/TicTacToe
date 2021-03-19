import Foundation
import Combine

final class BoardViewModel: ObservableObject {
    let board: Board
    @Published var winnerName: String = "nobody"
    
    private var cancelables: Set<AnyCancellable> = []
    
    init(_ board: Board) {
        self.board = board
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
    }
}

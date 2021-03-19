import Foundation
import Combine

final class BoardViewModel: ObservableObject {
    @Published var winnerName: String = "nobody"
    
    private var cancelables: Set<AnyCancellable> = []
    
    init(board: Board) {
        board.$winner.sink {
            switch $0 {
                case .nobody:
                    self.winnerName = "nobody"
                case .visitor:
                    self.winnerName = "visitor"
                case .home:
                    self.winnerName = "home"
            }
        }.store(in: &cancelables)
    }
}

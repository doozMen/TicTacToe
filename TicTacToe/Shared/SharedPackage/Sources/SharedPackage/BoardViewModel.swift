import Foundation
import Combine
import SwiftUI
final class BoardViewModel: ObservableObject {
    static let noWinner = "no winner yet"
    let board: Board
    @Published var winnerName: String = noWinner

    private var cancelables: Set<AnyCancellable> = []
    
    init(_ board: Board) {
        self.board = board
        board.$winner.sink { [weak self] in
            switch $0 {
                case .nobody:
                    self?.winnerName = BoardViewModel.noWinner
                case .visitor:
                    self?.winnerName = "visitor"
                case .home:
                    self?.winnerName = "home"
            }
        }.store(in: &cancelables)
    }
}

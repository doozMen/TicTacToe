import Foundation
import Combine
import SwiftUI

public final class BoardViewModel: ObservableObject {
    public static let noWinner = "no winner yet"
    public static let noWinnerColor = Color.black
    
    public let board: Board
    
    @Published
    public var winnerName: String = noWinner
    @Published
    public var winnerColor: Color = noWinnerColor

    private var cancelables: Set<AnyCancellable> = []
    
    public init(_ board: Board) {
        self.board = board
        board.$winner.sink { [weak self] in
            switch $0 {
                case .nobody:
                    self?.winnerName = BoardViewModel.noWinner
                    self?.winnerColor = BoardViewModel.noWinnerColor
                case .visitor:
                    self?.winnerName = "green"
                    self?.winnerColor = Color.gray
                case .home:
                    self?.winnerName = "blue"
                    self?.winnerColor = .blue
            }
        }.store(in: &cancelables)
    }
}

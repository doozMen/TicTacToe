import Foundation
import Combine

final class BoardViewModel: ObservableObject {
    @Published var winnerName: String = "nobody"
    
    private var cancelables: Set<AnyCancellable> = []
    
    init(board: Board) {
    }
}

import SwiftUI
import SharedPackage

@main
struct TicTacToeApp: App {
    let board = Board(mode: .ai)
    var body: some Scene {
        let viewModel = BoardViewModel(board)

        return WindowGroup {
            ContentView(reset: false).environmentObject(viewModel)
        }
    }
}

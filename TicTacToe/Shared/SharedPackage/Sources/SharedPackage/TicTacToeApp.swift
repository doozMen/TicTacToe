import SwiftUI

@main
struct TicTacToeApp: App {
    let board = Board(mode: .ai)
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(BoardViewModel(board))
        }
    }
}

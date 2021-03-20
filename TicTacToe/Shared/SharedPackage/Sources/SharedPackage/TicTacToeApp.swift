import SwiftUI

@main
struct TicTacToeApp: App {
    let board = Board()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(board)
        }
    }
}

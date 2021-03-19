/import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var boardViewModel: BoardViewModel
    @State var reset: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(boardViewModel.winnerName)
                    .padding()
                Spacer()
                Button("Reset") {
                    boardViewModel.board.resetGame()
                }.padding()
            }
            
            HStack {
                VStack {
                    SquareView(square: boardViewModel.board.squares[0][0]) {
                        do { try boardViewModel.board.occupy(at: .init(item: 0, section: 0), with: .home) } catch { print(error) }
                    }
                    SquareView(square: boardViewModel.board.squares[0][1]) {
                        do { try boardViewModel.board.occupy(at: .init(item: 1, section: 0), with: .home) } catch { print(error) }
                    }
                    SquareView(square: boardViewModel.board.squares[0][2]) {
                        do { try boardViewModel.board.occupy(at: .init(item: 2, section: 0), with: .home) } catch { print(error) }
                    }
                }
                VStack {
                    SquareView(square: boardViewModel.board.squares[1][0]) {
                        do { try boardViewModel.board.occupy(at: .init(item: 0, section: 1), with: .home) } catch { print(error) }
                    }
                    SquareView(square: boardViewModel.board.squares[1][1]) {
                        do { try boardViewModel.board.occupy(at: .init(item: 1, section: 1), with: .home) } catch { print(error) }
                    }
                    SquareView(square: boardViewModel.board.squares[1][2]) {
                        do { try boardViewModel.board.occupy(at: .init(item: 2, section: 1), with: .home) } catch { print(error) }
                    }
                }
                VStack {
                    SquareView(square: boardViewModel.board.squares[2][0]) {
                        do { try boardViewModel.board.occupy(at: .init(item: 0, section: 2), with: .home) } catch { print(error) }
                    }
                    SquareView(square: boardViewModel.board.squares[2][1]) {
                        do { try boardViewModel.board.occupy(at: .init(item: 1, section: 2), with: .home) } catch { print(error) }
                    }
                    SquareView(square: boardViewModel.board.squares[2][2]) {
                        do { try boardViewModel.board.occupy(at: .init(item: 2, section: 2), with: .home) } catch { print(error) }
                    }
                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(reset: false).environmentObject(Board())
    }
}

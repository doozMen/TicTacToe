/import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var boardViewModel: BoardViewModel
    @State var reset: Bool
    
    fileprivate func createSquare(item: Int, section: Int) -> SquareView {
        return SquareView(square: boardViewModel.board.squares[section][item]) {
            do { try boardViewModel.board.occupy(at: .init(item: item, section: section), with: .home) } catch { print(error) }
        }
    }
    
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
                    createSquare(item: 0, section: 0)
                    createSquare(item: 0, section: 1)
                    createSquare(item: 0, section: 2)
                }
                VStack {
                    createSquare(item: 1, section: 0)
                    createSquare(item: 1, section: 1)
                    createSquare(item: 1, section: 2)
                }
                VStack {
                    createSquare(item: 2, section: 0)
                    createSquare(item: 2, section: 1)
                    createSquare(item: 2, section: 2)
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

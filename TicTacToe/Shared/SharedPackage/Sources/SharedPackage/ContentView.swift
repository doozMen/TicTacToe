/import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var board: Board
    
    var body: some View {
        VStack {
            Text("placeholder winner")
                .padding()
            HStack {
                VStack {
                    SquareView(square: board.squares[0][0]) {
                        do { try board.occupy(at: .init(item: 0, section: 0), with: .home) } catch { print(error) }
                    }
                    SquareView(square: board.squares[0][1]) {
                        do { try board.occupy(at: .init(item: 1, section: 0), with: .home) } catch { print(error) }
                    }
                    SquareView(square: board.squares[0][2]) {
                        do { try board.occupy(at: .init(item: 2, section: 0), with: .home) } catch { print(error) }
                    }
                }
                VStack {
                    SquareView(square: board.squares[1][0]) {
                        do { try board.occupy(at: .init(item: 0, section: 1), with: .home) } catch { print(error) }
                    }
                    SquareView(square: board.squares[1][1]) {
                        do { try board.occupy(at: .init(item: 1, section: 1), with: .home) } catch { print(error) }
                    }
                    SquareView(square: board.squares[1][2]) {
                        do { try board.occupy(at: .init(item: 2, section: 1), with: .home) } catch { print(error) }
                    }
                }
                VStack {
                    SquareView(square: board.squares[2][0]) {
                        do { try board.occupy(at: .init(item: 0, section: 2), with: .home) } catch { print(error) }
                    }
                    SquareView(square: board.squares[2][1]) {
                        do { try board.occupy(at: .init(item: 1, section: 2), with: .home) } catch { print(error) }
                    }
                    SquareView(square: board.squares[2][2]) {
                        do { try board.occupy(at: .init(item: 2, section: 2), with: .home) } catch { print(error) }
                    }
                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Board())
    }
}

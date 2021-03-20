import Foundation
import SwiftUI
import Combine
import TicTacToeKit

struct SquareView: View {
    @State var square : Square
    @State var color = Color.gray
    
    var action: () -> Void
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 44, height: 44)
            .gesture(
                TapGesture()
                    .onEnded {
                        action()
                        color = square.color
                    }
            ).onReceive(square.$color, perform: { color in
                self.color = color
            })
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SquareView(square: .init(.home), action: { print("home pressed")})
            SquareView(square: .init(.nobody), action: { print("nobody pressed")})
            SquareView(square: .init(.visitor), action: { print("visitor pressed")})
        }
    }
}

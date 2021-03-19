import Foundation
import SwiftUI
import Combine

struct SquareView: View {
    @State var square : Square
    
    var action: () -> Void
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(square.text).frame(minWidth: 44)
        }
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SquareView(square: .init(.home), action: {
                
            })
            SquareView(square: .init(.nobody), action: {})
        }
    }
}

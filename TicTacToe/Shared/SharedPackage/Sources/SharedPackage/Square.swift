import Foundation
import Combine

final class Square: Equatable {
    static func == (lhs: Square, rhs: Square) -> Bool {
        lhs.ownedBy == rhs.ownedBy
    }
    
    enum OccupiedBy: Equatable {
        case nobody, visitor, home
    }
    
    @Published var ownedBy: OccupiedBy
    
    init(_ ownedBy: OccupiedBy) {
        self.ownedBy = ownedBy
    }
    
}


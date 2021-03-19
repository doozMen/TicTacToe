import Foundation
import Combine

final class Square: Equatable {
    static func == (lhs: Square, rhs: Square) -> Bool {
        lhs.occupiedBy == rhs.occupiedBy
    }
    
    enum OccupiedBy: Equatable {
        case nobody, visitor, home
    }
    
    @Published var occupiedBy: OccupiedBy
    
    init(_ ownedBy: OccupiedBy) {
        self.occupiedBy = ownedBy
    }
    
}


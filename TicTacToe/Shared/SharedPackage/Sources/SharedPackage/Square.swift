import Foundation
import Combine

struct Square: Equatable {
    enum OccupiedBy: Equatable {
        case nobody, visitor, home
    }
    
    let status: OccupiedBy
    
}


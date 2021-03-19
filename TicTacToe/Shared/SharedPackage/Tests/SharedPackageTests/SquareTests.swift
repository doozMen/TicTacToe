import XCTest
@testable import SharedPackage

class SquareTests: XCTestCase {
    var square: Square!

    override func setUp() {
        super.setUp()
        square = .init(.nobody)
    }
    
    func test_init() {
        XCTAssertEqual(square.occupiedBy, .nobody)
    }
    
    func test_text_equal_spacing() {
        let homeSquare = Square(.home)
        let visitorSquare = Square(.visitor)
        
        XCTAssertEqual(homeSquare.text, "  h  ")
        XCTAssertEqual(visitorSquare.text, "  v  ")
    }
    
    func test_text() {
        XCTAssertEqual(square.text, Square.empty)
    }
    
    func test_bindable_status() {
        var result = [Square.OccupiedBy]()
        let cancellable = square
            .$occupiedBy
            .collect(2)
            .sink { result = $0}
        square.occupiedBy = .home
        cancellable.cancel()
        XCTAssertEqual(result, [.nobody, .home])
    }
}

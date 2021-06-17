import XCTest
@testable import SwiftletRadioButtonPicker

final class SwiftletRadioButtonPickerTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let button = SwiftletRadioButton(id: "0", name: "Hello, World!")
        XCTAssertEqual(button.name, "Hello, World!")
    }
}

import LLVM
import XCTest

final class ArrayConstantTests: XCTestCase {

  func testAccess() {
    var m = Module("foo")
    let i32 = IntegerType(32, in: &m)
    let a = ArrayConstant(
      of: i32, containing: (0 ..< 5).map({ i32.constant(UInt64($0)) }), in: &m)

    XCTAssertEqual(a.count, 5)
    XCTAssertEqual(IntegerConstant(a[1]), i32.constant(1))
    XCTAssertEqual(IntegerConstant(a[2]), i32.constant(2))
  }

  func testEquality() {
    var m = Module("foo")
    let i32 = IntegerType(32, in: &m)

    let a = ArrayConstant(
      of: i32, containing: (0 ..< 5).map({ i32.constant(UInt64($0)) }), in: &m)
    let b = ArrayConstant(
      of: i32, containing: (0 ..< 5).map({ i32.constant(UInt64($0)) }), in: &m)
    XCTAssertEqual(a, b)

    let c = ArrayConstant(
      of: i32, containing: (0 ..< 5).map({ i32.constant(UInt64($0 + 1)) }), in: &m)
    XCTAssertNotEqual(a, c)
  }

}
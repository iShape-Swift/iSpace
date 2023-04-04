import XCTest
@testable import iSpace

final class FixFloatTests: XCTestCase {
    
    
    func testMul() throws {
        var a: Int64 = 0
        var b: Int64 = 0
        while a < 50_000 {
            b = 1
            while b < 50_000 {
                let m0 = a.mul(b)
                let m1 = (a.double * b.double)
                
                let d0 = abs(m1.fix - m0)
                let d1 = abs(m1 - m0.double)
                
                XCTAssertTrue(d0 < 2)
                XCTAssertTrue(d1 < 0.005)
                
                b += 17
            }
            
            a += 23
        }
    }
    
    func testDiv() throws {
        var a: Int64 = 0
        var b: Int64 = 0
        while a < 50_000 {
            b = 1
            while b < 50_000 {
                let m0 = a.div(b)
                let m1 = (a.double / b.double)
                
                let d0 = abs(m1.fix - m0)
                let d1 = abs(m1 - m0.double)
                
                XCTAssertTrue(d0 < 2)
                XCTAssertTrue(d1 < 0.005)
                
                b += 101
            }
            
            a += 31
        }
    }
    
    func testSqrt() throws {
        var a: Int64 = 0
        while a < 100_000 {
            
            let m0 = a.sqrt
            let m1 = (a.double.squareRoot())
            
            let d0 = abs(m1.fix - m0)
            let d1 = abs(m1 - m0.double)
            
            XCTAssertTrue(d0 < 5)
            XCTAssertTrue(d1 < 0.005)
            
            a += 1
        }
    }
}

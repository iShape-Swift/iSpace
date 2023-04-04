//
//  FixVecTests.swift
//  
//
//  Created by Nail Sharipov on 03.04.2023.
//

import XCTest
@testable import iSpace

final class FixVecTests: XCTestCase {
    
    func testSQRLength() throws {
        var x: Int64 = 0
        var y: Int64 = 0
        while x < 10_000 {
            y = 1

            while x < 2_500_000 {
                let iV = FixVec(x, y)
                let dV = iV.float

                let m0 = iV.sqrLength
                let m1 = dV.sqrLength

                let d0 = abs(m1.fix - m0)
                let d1 = abs(m1 - m0.float)

                
                let c0 = 1 + max(iV.x, iV.y) >> 7
                let c1 = 0.001 + max(dV.x, dV.y) * 0.01
                
                XCTAssertTrue(d0 < c0, "v: \(iV), d0: \(d0)")
                XCTAssertTrue(d1 < c1, "v: \(dV), d1: \(d1)")

                y += 101
            }

            x += 103
        }
    }
    
    func testLength() throws {
        var x: Int64 = 0
        var y: Int64 = 0
        while x < 10_000 {
            y = 1

            while x < 1_000_000 {
                let iV = FixVec(x, y)
                let dV = iV.float

                let m0 = iV.length
                let m1 = dV.length

                let d0 = abs(m1.fix - m0)
                let d1 = abs(m1 - m0.float)

                
                let c0 = 1 + max(iV.x, iV.y) >> 7
                let c1 = 0.001 + max(dV.x, dV.y) * 0.01
                
                XCTAssertTrue(d0 < c0, "v: \(iV), d0: \(d0)")
                XCTAssertTrue(d1 < c1, "v: \(dV), d1: \(d1)")

                x += 131
            }

            y += 109
        }
    }
    
    func testNormalize() throws {
        var x: Int64 = 0
        var y: Int64 = 0
        while x < 10_000 {
            y = 1

            while x < 1_000_000 {
                let iV = FixVec(x, y)
                let dV = iV.float

                let m0 = iV.normalize
                let m1 = dV.normalize

                let d0x = abs(m1.x.fix - m0.x)
                let d0y = abs(m1.y.fix - m0.y)
                let d1x = abs(m1.x - m0.x.float)
                let d1y = abs(m1.y - m0.y.float)
                

                let c0x = 1 + (iV.x >> 7)
                let c0y = 1 + (iV.y >> 7)
                
                let c1x = 0.001 + dV.x * 0.01
                let c1y = 0.001 + dV.y * 0.01

                XCTAssertTrue(d0x <= c0x, "v: \(iV), d0x: \(d0x)")
                XCTAssertTrue(d0y <= c0y, "v: \(iV), d0y: \(d0y)")
                XCTAssertTrue(d1x <= c1x, "v: \(dV), d1x: \(d1x)")
                XCTAssertTrue(d1y <= c1y, "v: \(dV), d1y: \(d1y)")

                x += 131
            }

            y += 109
        }
    }

}

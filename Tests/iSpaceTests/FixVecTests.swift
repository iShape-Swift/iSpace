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
    
    private func assert(_ a: Int64, _ b: Int64) {
        XCTAssertTrue(abs(a - b) < 130, "\(a) != \(b)")
    }
    
    private func assert(_ a: FixVec, _ b: FixVec) {
        assert(a.x, b.x)
        assert(a.y, b.y)
    }
    
    private func assertOrto(_ v: Vec, _ m: Vec) {
        let f = v.fix
        let n = m.fix

        assert(f.ortho(clockwise: true), n)
        assert(f.ortho(clockwise: false), n.reverse)
    }
    
    func testOrtho() throws {
        assertOrto(Vec(0, 1), Vec(1, 0))
        assertOrto(Vec(0, 10), Vec(1, 0))
        assertOrto(Vec(0, 100), Vec(1, 0))
        
        assertOrto(Vec(0.1, 0.9), Vec(0.9, -0.1).normalize)
        assertOrto(Vec(1, 9), Vec(0.9, -0.1).normalize)
        assertOrto(Vec(10, 90), Vec(0.9, -0.1).normalize)
        
        assertOrto(Vec(1, 0), Vec(0, -1))
        assertOrto(Vec(10, 0), Vec(0, -1))
        assertOrto(Vec(100, 0), Vec(0, -1))
        
        assertOrto(Vec(0, -1), Vec(-1, 0))
        assertOrto(Vec(0, -10), Vec(-1, 0))
        assertOrto(Vec(0, -100), Vec(-1, 0))
        
        assertOrto(Vec(-1, 0), Vec(0, 1))
        assertOrto(Vec(-10, 0), Vec(0, 1))
        assertOrto(Vec(-100, 0), Vec(0, 1))
        
        var r: Float = 0.01
        let hp: Float = 0.5 * .pi
        while r < 2000 {
            var a: Float = -0.001
            while a < 2 * .pi {
                let v = r * Vec(cos(a), sin(a))
                let n = Vec(cos(a - hp), sin(a - hp))

                assertOrto(v, n)
                a += 0.1
            }

            r *= 5
        }
    }

}

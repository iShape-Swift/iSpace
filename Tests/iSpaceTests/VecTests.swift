//
//  VecTests.swift
//  
//
//  Created by Nail Sharipov on 08.04.2023.
//

import XCTest
@testable import iSpace

final class VecTests: XCTestCase {
    
    private func assertOrto(_ v: Vec, _ n: Vec) {
        let a = v.ortho(clockwise: true)
        XCTAssertEqual(a.x, n.x, accuracy: 0.01)
        XCTAssertEqual(a.y, n.y, accuracy: 0.01)
        
        let b = v.ortho(clockwise: false)
        XCTAssertEqual(b.x, -n.x, accuracy: 0.01)
        XCTAssertEqual(b.y, -n.y, accuracy: 0.01)
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
        while r < 200 {
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

//
//  FixAngleTests.swift
//  
//
//  Created by Nail Sharipov on 05.04.2023.
//

import XCTest
@testable import iSpace

final class FixAngleTests: XCTestCase {
    
    
    func testRadian() throws {
        XCTAssertEqual(Double(0).fixAngle, 0)
        XCTAssertEqual((0.125 * Double.pi).fixAngle, 64)
        XCTAssertEqual((0.25 * Double.pi).fixAngle, 128)
        XCTAssertEqual((0.375 * Double.pi).fixAngle, 192)
        XCTAssertEqual((0.5 * Double.pi).fixAngle, 256)
        XCTAssertEqual((0.625 * Double.pi).fixAngle, 320)
        XCTAssertEqual((0.75 * Double.pi).fixAngle, 384)
        XCTAssertEqual((0.875 * Double.pi).fixAngle, 448)
        XCTAssertEqual((1.0 * Double.pi).fixAngle, 512)
        XCTAssertEqual((1.125 * Double.pi).fixAngle, 576)
        XCTAssertEqual((1.25 * Double.pi).fixAngle, 640)
        XCTAssertEqual((1.375 * Double.pi).fixAngle, 704)
        XCTAssertEqual((1.5 * Double.pi).fixAngle, 768)
        XCTAssertEqual((1.625 * Double.pi).fixAngle, 832)
        XCTAssertEqual((1.75 * Double.pi).fixAngle, 896)
        XCTAssertEqual((1.875 * Double.pi).fixAngle, 960)
        XCTAssertEqual((2.0 * Double.pi).fixAngle, 1024)

        XCTAssertEqual(0.fix.angleToFixAngle, 0)
        XCTAssertEqual(45.fix.angleToFixAngle, 128)
        XCTAssertEqual(90.fix.angleToFixAngle, 256)
        XCTAssertEqual(135.fix.angleToFixAngle, 384)
        XCTAssertEqual(180.fix.angleToFixAngle, 512)
        XCTAssertEqual(225.fix.angleToFixAngle, 640)
        XCTAssertEqual(270.fix.angleToFixAngle, 768)
        XCTAssertEqual(315.fix.angleToFixAngle, 896)
        XCTAssertEqual(360.fix.angleToFixAngle, 1024)

        
        XCTAssertEqual(Double(0).fix.radToFixAngle, 0)
        XCTAssertEqual(Double(0).fix, 0)
        
        XCTAssertTrue(abs((0.5 * Double.pi).fix.radToFixAngle - 256) <= 1)
        XCTAssertEqual((0.5 * Double.pi).fix, 1608)
        
        XCTAssertTrue(abs((1.0 * Double.pi).fix.radToFixAngle - 512) <= 1)
        XCTAssertEqual((1.0 * Double.pi).fix, 3216)
        
        XCTAssertTrue(abs((1.5 * Double.pi).fix.radToFixAngle - 768) <= 1)
        XCTAssertEqual((1.5 * Double.pi).fix, 4825)
        
        XCTAssertTrue(abs((2.0 * Double.pi).fix.radToFixAngle - 1024) <= 1)
        XCTAssertEqual((2.0 * Double.pi).fix, 6433)
    }
    
    func testCos() throws {
        var rad: Double = -100

        while rad < 100 {
            let angle = 180 * rad / .pi
            let fixAngle0 = rad.fix.radToFixAngle
            
            let fixFloat = angle.fix
            let fixAngle1 = fixFloat.angleToFixAngle

            XCTAssertTrue(abs(fixAngle0 - fixAngle1) <= 1)

            let cs = cos(rad).fix
            let cs0 = fixAngle0.cos
            let cs1 = fixAngle1.cos
            
            XCTAssertTrue(abs(cs - cs0) <= 8)
            XCTAssertTrue(abs(cs - cs1) <= 8)

            rad += 0.001
        }
    }

    func testSin() throws {
        var rad: Double = -100

        while rad < 100 {
            let angle = 180 * rad / .pi
            let fixAngle0 = rad.fix.radToFixAngle
            
            let fixFloat = angle.fix
            let fixAngle1 = fixFloat.angleToFixAngle

            XCTAssertTrue(abs(fixAngle0 - fixAngle1) <= 1)

            let sn = sin(rad).fix
            let sn0 = fixAngle0.sin
            let sn1 = fixAngle1.sin
            
            XCTAssertTrue(abs(sn - sn0) <= 8)
            XCTAssertTrue(abs(sn - sn1) <= 8)

            rad += 0.001
        }
    }
    
}

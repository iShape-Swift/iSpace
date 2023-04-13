//
//  MAth+PointOnLine.swift
//  
//
//  Created by Nail Sharipov on 10.04.2023.
//

public extension Math {
    
    static func pointOnLine(normal n: FixVec, outsidePoint p: FixVec, linePoint a: FixVec) -> FixVec {
        let d = (p - a).dotProduct(n)
        let m = p - d * n
        return m
    }
    
}

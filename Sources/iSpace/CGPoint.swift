//
//  CGPoint.swift
//  
//
//  Created by Nail Sharipov on 08.04.2023.
//

import CoreGraphics

public extension FixFloat {
    
    @inlinable
    var cgFloat: CGFloat {
        CGFloat(self) / CGFloat(Int64.unit)
    }
}

public extension FixVec {

    @inlinable
    var cgFloat: CGPoint {
        CGPoint(x: x.cgFloat, y: y.cgFloat)
    }
}

public extension CGFloat {
    
    @inlinable
    var fix: FixFloat {
        Int64(self * CGFloat(FixFloat.unit))
    }
}

public extension CGPoint {

    @inlinable
    var fix: FixVec {
        FixVec(x.fix, y.fix)
    }
}

public extension Array where Element == CGPoint {
    
    @inlinable
    var fix: [FixVec] {
        let n = count
        var array = Array<FixVec>(repeating: .zero, count: n)
        for i in 0..<n {
            array[i] = self[i].fix
        }
        
        return array
    }
    
}

public extension Array where Element == FixVec {
    
    @inlinable
    var cgFloat: [CGPoint] {
        let n = count
        var array = Array<CGPoint>(repeating: .zero, count: n)
        for i in 0..<n {
            array[i] = self[i].cgFloat
        }
        
        return array
    }
    
}

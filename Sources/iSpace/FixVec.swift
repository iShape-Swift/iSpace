//
//  FixVec.swift
//  
//
//  Created by Nail Sharipov on 03.04.2023.
//

import simd

public typealias FixVec = SIMD2<Int64>

public struct FixVecMirror {
    
    public let vec: FixVec
    public let isOpposite: Bool
    
    @usableFromInline
    init(vec: FixVec, isOpposite: Bool) {
        self.vec = vec
        self.isOpposite = isOpposite
    }
}

public extension FixVec {

    static let zero = FixVec(0, 0)
    
    @inlinable
    var bitPack: Int64 {
        (x << FixFloat.maxBits) + y
    }
     
    @inlinable
    init(_ x: FixFloat, _ y: FixFloat) {
        self = .init(x: x, y: y)
    }
    
    @inlinable
    var float: Vec {
        Vec(x.float, y.float)
    }

    @inlinable
    var reverse: FixVec {
        FixVec(-x, -y)
    }

    @inlinable
    var sqrLength: FixFloat {
        let m = self &* self
        return (m.x + m.y) >> FixFloat.fractionBits
    }
    
    @inlinable
    var length: FixFloat {
        let m = self &* self
        return (m.x + m.y).squareRootBinarySearch
    }

    @inlinable
    var normalize: FixVec {
        let s = (1 << 30) / length
        return (s &* self) &>> 20
    }
    
    @inlinable
    var half: FixVec {
        self &>> 1
    }
    
    @inlinable
    func ortho(clockwise: Bool) -> FixVec {
        if clockwise {
            return FixVec(y, -x).normalize
        } else {
            return FixVec(-y, x).normalize
        }
    }
     
    @inlinable
    func divTwo(_ count: Int64) -> FixVec {
        self &>> count
    }
    
    @inlinable
    static func +(left: FixVec, right: FixVec) -> FixVec {
        left &+ right
    }

    @inlinable
    static func -(left: FixVec, right: FixVec) -> FixVec {
        left &- right
    }
    
    @inlinable
    static func *(left: FixVec, right: FixFloat) -> FixVec {
        (right &* left) &>> FixFloat.fractionBits
    }
    
    @inlinable
    static func *(left: FixFloat, right: FixVec) -> FixVec {
        (left &* right) &>> FixFloat.fractionBits
    }

    @inlinable
    func dotProduct(_ v: FixVec) -> FixFloat { // dot product (cos)
        let m = (self &* v) &>> FixFloat.fractionBits
        return m.x + m.y
    }

    @inlinable
    func crossProduct(_ v: FixVec) -> FixFloat { // cross product
        let m = (self &* FixVec(v.y, v.x)) &>> FixFloat.fractionBits
        return m.x - m.y
    }
    
    @inlinable
    func sqrDistance(_ v: FixVec) -> FixFloat {
        (self &- v).sqrLength
    }
    
    @inlinable
    func middle(_ v: FixVec) -> FixVec {
        (self &+ v) &>> 1
    }
    
    @inlinable
    func mirror(_ a: FixVec) -> FixVecMirror {
        let b = FixVec(a.y, -a.x)
        
        let da = self.dotProduct(a)
        let db = self.dotProduct(b)
        
        let va = a * da
        let vb = b * db

        return FixVecMirror(vec: vb - va, isOpposite: da < 0)
    }
}

public extension Array where Element == FixVec {
    
    @inlinable
    var float: [Vec] {
        let n = count
        var array = Array<Vec>(repeating: .zero, count: n)
        for i in 0..<n {
            array[i] = self[i].float
        }
        
        return array
    }
    
}

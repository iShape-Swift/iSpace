//
//  FixVec.swift
//  
//
//  Created by Nail Sharipov on 03.04.2023.
//

import simd

FixVec

public struct FixVec {

    public static let zero = FixVec(0, 0)
    
    @usableFromInline
    let vec: SIMD2<Int64>
    
    @inlinable
    public var x: FixFloat { vec.x }
    
    @inlinable
    public var y: FixFloat { vec.y }

    #if DEBUG
    public let deb_x: Float
    public let deb_y: Float
    #endif
     
    @inlinable
    public var bitPack: Int64 {
        (x << FixFloat.maxBits) + y
    }
     
    @inlinable
    public init(_ x: FixFloat, _ y: FixFloat) {
        vec = .init(x: x, y: y)
 #if DEBUG
        deb_x = Float(x) / Float(FixFloat.unit)
        deb_y = Float(y) / Float(FixFloat.unit)
 #endif
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
    public var sqrLength: FixFloat {
        (x * x + y * y) >> FixFloat.fractionBits
    }
    
    @inlinable
    public var length: FixFloat {
        (x * x + y * y).squareRootBinarySearch
    }

    @inlinable
    public var normalize: FixVec {
        let s = (1 << 30) / length
        let nx = (s * x) >> 20
        let ny = (s * y) >> 20
        
        return FixVec(nx, ny)
    }
    
    @inlinable
    public var half: FixVec {
        FixVec(x >> 1, y >> 1)
    }
    
    @inlinable
    public func ortho(clockwise: Bool) -> FixVec {
        if clockwise {
            return FixVec(y, -x).normalize
        } else {
            return FixVec(-y, x).normalize
        }
    }
     
    @inlinable
    public func divTwo(_ count: Int) -> FixVec {
        FixVec(x >> count, y >> count)
    }
    
    @inlinable
    public static func +(left: FixVec, right: FixVec) -> FixVec {
        FixVec(left.x + right.x, left.y + right.y)
    }

    @inlinable
    public static func -(left: FixVec, right: FixVec) -> FixVec {
        FixVec(left.x - right.x, left.y - right.y)
    }
    
    @inlinable
    public static func *(left: FixVec, right: FixFloat) -> FixVec {
        FixVec(left.x.mul(right), left.y.mul(right))
    }
    
    @inlinable
    public static func *(left: FixFloat, right: FixVec) -> FixVec {
        FixVec(right.x.mul(left), right.y.mul(left))
    }

    @inlinable
    public func dotProduct(_ v: FixVec) -> FixFloat { // dot product (cos)
        x.mul(v.x) + v.y.mul(y)
    }

    @inlinable
    public func crossProduct(_ v: FixVec) -> FixFloat { // cross product
        x.mul(v.y) - y.mul(v.x)
    }
    
    @inlinable
    public func sqrDistance(_ v: FixVec) -> FixFloat {
        let dx = x - v.x
        let dy = y - v.y
        
        return dx.sqr + dy.sqr
    }
    
    @inlinable
    public func middle(_ v: FixVec) -> FixVec {
        let x = (x + v.x) >> 1
        let y = (y + v.y) >> 1
        
        return FixVec(x, y)
    }
}

extension FixVec: Equatable {

    @inlinable
    public static func == (lhs: FixVec, rhs: FixVec) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
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

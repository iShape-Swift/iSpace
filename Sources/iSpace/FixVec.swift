//
//  FixVec.swift
//  
//
//  Created by Nail Sharipov on 03.04.2023.
//

public struct FixVec {

    public static let zero = FixVec(0, 0)
     
    public let x: FixFloat
    public let y: FixFloat

    #if DEBUG
    public let deb_x: Float
    public let deb_y: Float
    #endif
     
    @inlinable
    public var bitPack: Int64 {
        (x << FixFloat.maxBits) + y
    }
     
    @inlinable
    public init(_ x: Int64, _ y: Int64) {
        self.x = x
        self.y = y
 #if DEBUG
        deb_x = Float(x) / Float(FixFloat.unit)
        deb_y = Float(y) / Float(FixFloat.unit)
 #endif
    }
    
    var float: Vec {
        Vec(x.float, y.float)
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
        let s = FixFloat.quarticUnit / length
        let nx = (s * x) >> FixFloat.cubicFractionBits
        let ny = (s * y) >> FixFloat.cubicFractionBits
        
        return FixVec(nx, ny)
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
     public func dotProduct(_ v: FixVec) -> FixFloat { // dot product (cos)
         x.mul(v.x) + v.y.mul(y)
     }
     
     @inlinable
     public func crossProduct(_ v: FixVec) -> FixFloat { // cross product
         x.mul(v.y) - y.mul(v.x)
     }
}

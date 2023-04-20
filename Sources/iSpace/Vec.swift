//
//  Vec.swift
//  
//
//  Created by Nail Sharipov on 03.04.2023.
//

import simd

public typealias Vec = simd_float2

public struct VecMirror {
    
    public let vec: Vec
    public let isOpposite: Bool
    
    @usableFromInline
    init(vec: Vec, isOpposite: Bool) {
        self.vec = vec
        self.isOpposite = isOpposite
    }
}

public extension Vec {
    
    static let zero = Vec(0, 0)
    
    @inlinable
    var fix: FixVec {
        FixVec(x.fix, y.fix)
    }
    
    @inlinable
    var sqrLength: Float {
        simd_length_squared(self)
    }
    
    @inlinable
    var length: Float {
        simd_length(self)
    }

    @inlinable
    var normalize: Vec {
        simd_normalize(self)
    }
     
    @inlinable
    static func +(left: Vec, right: Vec) -> Vec {
        Vec(left.x + right.x, left.y + right.y)
    }

    @inlinable
    static func -(left: Vec, right: Vec) -> Vec {
        Vec(left.x - right.x, left.y - right.y)
    }

    @inlinable
    func dotProduct(_ v: Vec) -> Float { // dot product (cos)
        simd_dot(self, v)
    }

    @inlinable
    func crossProduct(_ v: Vec) -> Float { // cross product
        x * v.y - y * v.x
    }
    
    @inlinable
    func isClockWise(_ v: Vec) -> Bool { // cross product
        x * v.y < y * v.x
    }

    @inlinable
    func ortho(clockwise: Bool) -> Vec {
        if clockwise {
            return Vec(y, -x).normalize
        } else {
            return Vec(-y, x).normalize
        }
    }
    
    @inlinable
    func mirror(_ a: Vec) -> VecMirror {
        let b = Vec(a.y, -a.x)
        
        let da = self.dotProduct(a)
        let db = self.dotProduct(b)
        
        let va = a * da
        let vb = b * db

        let isOpposite = da < 0

        return VecMirror(vec: vb - va, isOpposite: isOpposite)
    }
}

public extension Array where Element == Vec {
    
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

//
//  FixFloat.swift
//  
//
//  Created by Nail Sharipov on 03.04.2023.
//

public typealias FixFloat = Int64

public extension FixFloat {
    
    static let fractionBits: Int64 = 10
    static let maxBits = (Int64.bitWidth >> 1) - 1
    static let max: Int64 = (Int64(1) << (maxBits + 1)) - 1
    static let min: Int64 = -max
    
    static let unit: Int64 = 1 << fractionBits
    static let half: Int64 = 1 << (fractionBits - 1)
    
    static let pi: FixFloat = 3217
    
    @inlinable
    func div(_ value: FixFloat) -> FixFloat {
        (self << FixFloat.fractionBits) / value
    }
    
    @inlinable
    func mul(_ value: FixFloat) -> FixFloat {
        (self * value) >> FixFloat.fractionBits
    }

    @inlinable
    var sqr: FixFloat {
        (self * self) >> FixFloat.fractionBits
    }
    
    @inlinable
    var sqrt: FixFloat {
        (self << FixFloat.fractionBits).squareRootBinarySearch
    }
    
    @inlinable
    var double: Double {
        Double(self) / Double(Int64.unit)
    }
    
    @inlinable
    var float: Float {
        Float(self) / Float(Int64.unit)
    }
    
    @inlinable
    static func unit(_ value: Int64) -> FixFloat {
        value << FixFloat.fractionBits
    }

}

public extension Double {
    
    @inlinable
    var fix: FixFloat {
        Int64(self * Double(FixFloat.unit))
    }
}

public extension Float {
    
    @inlinable
    var fix: FixFloat {
        Int64(self * Float(FixFloat.unit))
    }
}

public extension Int {
    
    @inlinable
    var fix: FixFloat {
        Int64(self << FixFloat.fractionBits)
    }
}

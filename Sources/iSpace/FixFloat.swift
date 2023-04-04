//
//  FixFloat.swift
//  
//
//  Created by Nail Sharipov on 03.04.2023.
//

public typealias FixFloat = Int64

public extension FixFloat {

    static let fractionBits: Int64 = 10
    static let doubleFractionBits: Int64 = fractionBits + fractionBits
    static let cubicFractionBits: Int64 = doubleFractionBits + fractionBits
    static let quarticFractionBits: Int64 = cubicFractionBits + fractionBits
    static let maxBits = (Int64.bitWidth >> 1) - 1
    static let max: Int64 = Int64(1) << maxBits
    
    static let unit: Int64 = 1 << fractionBits
    static let sqrUnit: Int64 = 1 << doubleFractionBits
    static let cubicUnit: Int64 = 1 << cubicFractionBits
    static let quarticUnit: Int64 = 1 << quarticFractionBits
    
    var double: Double {
        Double(self) / Double(Int64.unit)
    }
    
    var float: Float {
        Float(self) / Float(Int64.unit)
    }
    
    @inlinable
    func div(_ value: FixFloat) -> FixFloat {
        (self << FixFloat.fractionBits) / value
    }
    
    @inlinable
    func mul(_ value: FixFloat) -> FixFloat {
        (self * value) >> FixFloat.fractionBits
    }
    
    @inlinable
    var sqrt: FixFloat {
        (self << FixFloat.fractionBits).squareRootBinarySearch
    }
}

public extension Double {
    var fix: FixFloat {
        Int64(self * Double(FixFloat.unit))
    }
}

public extension Float {
    var fix: FixFloat {
        Int64(self * Float(FixFloat.unit))
    }
}

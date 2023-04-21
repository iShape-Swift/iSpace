//
//  Int.swift
//  
//
//  Created by Nail Sharipov on 03.04.2023.
//

extension Int64 {

    @inlinable
    var fastSquareRoot: Int64 {
        let a = Int64(Double(self).squareRoot())
        let b = a + 1

        return b * b > self ? a : b
    }
}

//
//  Int.swift
//  
//
//  Created by Nail Sharipov on 03.04.2023.
//

extension Int64 {
    
    @inlinable
    var nextBitIndex: Int {
        Int64.bitWidth - leadingZeroBitCount
    }
    
    @inlinable
    var squareRootBinarySearch: Int64 {
        let i = self.nextBitIndex
        var eRt: Int64 = (1 << (i >> 1))
        var eLt: Int64 = (1 << ((i - 1) >> 1))
        var d = eLt
        
        var a = (eRt + eLt) >> 1
        while d > 1 {
            let aa = a * a
            d = d >> 1
            if aa > self {
                eRt -= d
            } else if aa < self {
                eLt += d
            } else {
                return a
            }
            
            a = (eRt + eLt) >> 1
        }
        
        return a
    }
}

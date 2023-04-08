//
//  PolygonData.swift
//  
//
//  Created by Nail Sharipov on 05.04.2023.
//

public struct PolygonData {
    
    public let area: FixFloat
    public let center: FixVec
    
    public init(area: FixFloat, center: FixVec) {
        self.area = area
        self.center = center
    }
}

public extension Array where Element == FixVec {

    var convexData: PolygonData {

        var centroid = FixVec.zero
        var area: FixFloat = 0
        
        let n = count
        var i = 0
        
        var p1 = self[n - 1]
        
        while i < n {
            let p2 = self[i]
            let crossProduct = p1.crossProduct(p2)
            area += crossProduct
            centroid = centroid + (p1 + p2) * crossProduct
            
            p1 = p2
            i += 1
        }
        
        area = area >> 1
        let s = 6 * area
        
        let x = centroid.x.div(s)
        let y = centroid.y.div(s)

        return PolygonData(area: area, center: FixVec(x, y))
    }

}

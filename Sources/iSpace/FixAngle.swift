//
//  FixAngle.swift
//  
//
//  Created by Nail Sharipov on 05.04.2023.
//

public typealias FixAngle = FixFloat

public struct RotationMatrix {
    
    public let sin: FixFloat
    public let cos: FixFloat
    
    @inlinable
    public init(sin: FixFloat, cos: FixFloat) {
        self.sin = sin
        self.cos = cos
    }
    
    @inlinable
    public func rotateForward(point p: FixVec) -> FixVec {
        if sin == 0 && cos == 1024 {
            return p
        } else {
            let v = FixVec(sin, cos)
            let x = -v.crossProduct(p)  // -v.x(sin) * p.y + v.y(cos) * p.x
            let y = v.dotProduct(p)     // v.x(sin) * p.x + v.y(cos) * p.y
            return FixVec(x, y)
        }
    }

    @inlinable
    public func rotateBack(point p: FixVec) -> FixVec {
        if sin == 0 && cos == 1024 {
            return p
        } else {
            let v = FixVec(cos, sin)
            let x = v.dotProduct(p)     // v.x(cos) * p.x + v.y(sin) * p.y
            let y = v.crossProduct(p)   // v.x(cos) * p.y - v.y(sin) * p.x

            return FixVec(x, y)
        }
    }
}


// split 90C to 128
public extension FixAngle {

    // 0...128
    private static let map: [FixFloat] = [
        0,12,25,37,50,62,75,87,100,112,125,137,150,162,175,187,199,212,224,236,248,260,273,285,297,309,321,333,344,356,368,380,391,403,414,426,437,449,460,471,482,493,504,515,526,537,547,558,568,579,589,599,609,620,629,639,649,659,668,678,687,696,706,715,724,732,741,750,758,767,775,783,791,799,807,814,822,829,837,844,851,858,865,871,878,884,890,897,903,908,914,920,925,930,936,941,946,950,955,959,964,968,972,976,979,983,986,990,993,996,999,1001,1004,1006,1008,1010,1012,1014,1016,1017,1019,1020,1021,1022,1022,1023,1023,1023,1024
    ]
    
    static let indexMask: Int64 = 256 - 1
    static let fullRoundMask: Int64 = 1024 - 1
    static let doubleToAngle: Double = 1024 * 512 / Double.pi
    static let doubleToRadian: Double = Double.pi / 512
    static let floatToAngle: Float = 1024 * 512 / Float.pi

    @inlinable
    var radian: Double {
        Double(self.trim) * Int64.doubleToRadian
    }
    
    @inlinable
    var trim: FixFloat {
        self & FixAngle.fullRoundMask
    }
    
    @inlinable
    var sin: FixFloat {
        let quarter = (self & FixAngle.fullRoundMask) >> 8
        let index = Int(self & FixAngle.indexMask)

        switch quarter {
        case 0:
            return FixAngle.value(index)
        case 1:
            return FixAngle.value(256 - index)
        case 2:
            return -FixAngle.value(index)
        default:
            return -FixAngle.value(256 - index)
        }
    }
    
    @inlinable
    var cos: FixFloat {
        let quarter = (self & FixAngle.fullRoundMask) >> 8
        let index = Int(self & FixAngle.indexMask)
        
        switch quarter {
        case 0:
            return FixAngle.value(256 - index)
        case 1:
            return -FixAngle.value(index)
        case 2:
            return -FixAngle.value(256 - index)
        default:
            return FixAngle.value(index)
        }
    }
    
    @inlinable
    var rotator: RotationMatrix {
        let quarter = (self & FixAngle.fullRoundMask) >> 8
        let index = Int(self & FixAngle.indexMask)

        let sn: FixFloat
        let cs: FixFloat
        
        switch quarter {
        case 0:
            sn = FixAngle.value(index)
            cs = FixAngle.value(256 - index)
        case 1:
            sn = FixAngle.value(256 - index)
            cs = -FixAngle.value(index)
        case 2:
            sn = -FixAngle.value(index)
            cs = -FixAngle.value(256 - index)
        default:
            sn = -FixAngle.value(256 - index)
            cs = FixAngle.value(index)
        }
        
        return RotationMatrix(sin: sn, cos: cs)
    }

    static func value(_ index: Int) -> FixFloat {
        let i = index >> 1
        if index & 1 == 1 {
            return (map[i] + map[i + 1]) >> 1
        } else {
            return map[i]
        }
    }

}

public extension Double {
    
    @inlinable
    var fixAngle: FixAngle {
        Int64(self * FixAngle.doubleToAngle) >> 10
    }
}

public extension Float {
    
    @inlinable
    var fixAngle: FixAngle {
        Int64(self * FixAngle.floatToAngle) >> 10
    }
}

public extension FixFloat {
    
    @inlinable
    var angleToFixAngle: FixAngle {
        (self / 90) >> 2
    }
    
    @inlinable
    var radToFixAngle: FixAngle {
        (self << 9) / .pi
    }
}

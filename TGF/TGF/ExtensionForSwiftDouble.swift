//
//  TGFExtension+Double.swift
//  TGF
//
//  Created by andrzej semeniuk on 10/9/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation

extension Double
{
    public func clamp(_ minimum:Double,_ maximum:Double) -> Double {
        return self < maximum ? (minimum < self ? self : minimum) : maximum
    }
    public func clamp01() -> Double {
        return clamp(0,1)
    }
    public func clamp0255() -> Double {
        return clamp(0,255)
    }
    public func lerp(_ from:Double, _ to:Double) -> Double {
        return (1.0-self)*from + self*to
        //        return from + (to - from) * self
    }
    public static func lerp(_ from:Double, _ to:Double, _ with:Double) -> Double {
        return with.lerp(from,to)
    }
    public func lerp01(_ from:Double, _ to:Double) -> Double {
        return min(1.0,max(0.0,self.lerp(from,to)))
    }
    public static func lerp01(_ from:Double, _ to:Double, _ with:Double) -> Double {
        return with.lerp01(from,to)
    }
}

extension Double {
    
    public static var random:Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    public static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
    
}

//
//  TGFExtension+CGFloat.swift
//  TGF
//
//  Created by andrzej semeniuk on 10/9/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation

extension CGFloat
{
    public func clamp(_ minimum:CGFloat,_ maximum:CGFloat) -> CGFloat {
        return self < maximum ? (minimum < self ? self : minimum) : maximum
    }
    public func clamp01() -> CGFloat {
        return clamp(0,1)
    }
    public func clamp0255() -> CGFloat {
        return clamp(0,255)
    }
    public func lerp(_ from:CGFloat, _ to:CGFloat) -> CGFloat {
        return (1.0-self)*from + self*to
        //        return from + (to - from) * self
    }
    public static func lerp(_ from:CGFloat, _ to:CGFloat, _ with:CGFloat) -> CGFloat {
        return with.lerp(from,to)
    }
    public func lerp01(_ from:CGFloat, _ to:CGFloat) -> CGFloat {
        return CGFloat(Float(self.lerp(from,to)).clamp01())
    }
    public static func lerp01(_ from:CGFloat, _ to:CGFloat, _ with:CGFloat) -> CGFloat {
        return with.lerp01(from,to)
    }
}

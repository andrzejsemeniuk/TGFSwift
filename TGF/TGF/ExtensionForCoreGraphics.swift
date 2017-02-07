//
//  ExtensionForCGCGPoint.swift
//  TGF
//
//  Created by andrzej semeniuk on 12/15/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    public var asCGSize:CGSize {
        return CGSize(width:x,height:y)
    }
}

extension CGSize {
    public var asCGPoint:CGPoint {
        return CGPoint(x:width,y:height)
    }
}

extension CGAffineTransform {
    
    public var sx:CGFloat {
        return sqrt(a * a + c * c)
    }
    
    public var sy:CGFloat {
        return sqrt(b * b + d * d)
    }
}

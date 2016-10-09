//
//  TGFExtension+Numeric.swift
//  TGF
//
//  Created by andrzej semeniuk on 10/9/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation

public protocol Numeric : Integer,FloatingPoint {}

extension Numeric {
    public mutating func increment(increment:Self) -> Self {
        self = self + increment
        return self
    }
}

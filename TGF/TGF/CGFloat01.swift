//
//  CGFloat01.swift
//  TGF
//
//  Created by andrzej semeniuk on 12/15/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation

public class CGFloat01 {
    // CGFloat <-> CGFloat01
    public var value:CGFloat {
        didSet {
            if value < 0 {
                self.value = 0
            }
            else if 1 < value {
                self.value = 1
            }
        }
    }
    
    init(value:CGFloat = 0) {
        self.value = value
    }
}


public func += (lhs:CGFloat01,rhs:CGFloat) {
    lhs.value += rhs
}

public func -= (lhs:CGFloat01,rhs:CGFloat) {
    lhs.value -= rhs
}


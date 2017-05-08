//
//  UIViewSequence.swift
//  TGF
//
//  Created by andrzej semeniuk on 5/2/17.
//  Copyright © 2017 Tiny Game Factory LLC. All rights reserved.
//

import Foundation

​
//-n elements, crud
//-title
//-insets
//-border style
//-states: enabled/disabled/highlighted

public class UIViewSequence {
    
    public var elements     : [UIView] = []
    public var title        : UILabel?
    public var insets       : UIEdgeInsets
    public var border       : UIViewBorder
    public var states       : [State] = []
    public var transitions  : [State:[State]] = [:]
    
    // create
    // add
    // tweak
    // remove
    
    public func add(_ view:UIView) {
        // add as child
        // add constraints
    }
}

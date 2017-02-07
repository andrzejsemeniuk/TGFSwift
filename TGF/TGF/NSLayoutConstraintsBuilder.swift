//
//  NSLayoutConstraintsBuilder.swift
//  TGF
//
//  Created by andrzej semeniuk on 2/7/17.
//  Copyright © 2017 Tiny Game Factory LLC. All rights reserved.
//

import Foundation

public class NSLayoutConstraintsBuilder {
    
    public var views            : [String:Any]          = [:]
    public var options          : NSLayoutFormatOptions = []
    public var metrics          : [String:Any]?         = nil
    
    fileprivate(set) var constraints : [NSLayoutConstraint] = []
    
    public init(views           : [String:Any] = [],
                options         : NSLayoutFormatOptions = [],
                metrics         : [String:Any]?         = nil) {
        self.views      = views
        self.options    = options
        self.metrics    = metrics
    }
    
    public func activate(clear:Bool = true) {
        NSLayoutConstraint.activate(constraints)
        if clear {
            self.clear()
        }
    }
    
    public func clear() {
        self.constraints = []
    }
    
    public func add(_ constraints   : [NSLayoutConstraint]) {
        self.constraints += constraints
    }
    
    public func add(_ constraint    : String,
                    views           : [String:Any]?             = nil,
                    options         : NSLayoutFormatOptions?    = nil,
                    metrics         : [String:Any]?             = nil) {
        
        self.constraints.append(self.create(constraint,
                                            views       : views,
                                            options     : options,
                                            metrics     : metrics))
    }
    
    public func     create(_ constraint    : String,
                           views           : [String:Any]?          = nil,
                           options         : NSLayoutFormatOptions? = nil,
                           metrics         : [String:Any]?          = nil) -> [NSLayoutConstraint] {

        return NSLayoutConstraint.constraints(withVisualFormat : constraint,
                                              options          : options ?? self.options,
                                              metrics          : metrics ?? self.metrics,
                                              views            : views ?? self.views)

    }
    
}

public func += (lhs:NSLayoutConstraintsBuilder, rhs:String) -> NSLayoutConstraintsBuilder {
    lhs.add(rhs)
    return lhs
}

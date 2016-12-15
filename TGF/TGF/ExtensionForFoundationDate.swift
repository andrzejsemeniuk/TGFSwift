//
//  ExtensionForFoundationDate.swift
//  TGF
//
//  Created by andrzej semeniuk on 12/15/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation

extension Date {
    
    public func componentDelta(to other:Date, units:[Calendar.Component] = [
        Calendar.Component.year,
        Calendar.Component.weekOfYear,
        Calendar.Component.day,
        Calendar.Component.hour,
        Calendar.Component.minute,
        Calendar.Component.second
        ]) -> Calendar.Component {
        
        for component in units
        {
            if Calendar.current.component(component, from: self) != Calendar.current.component(component, from: other) {
                return component
            }
        }
        
        return .day
    }
    
    public func added(days:Double = 0, hours:Double = 0, minutes:Double = 0, seconds:Double = 0) -> Date {
        return Date(timeIntervalSinceNow: self.timeIntervalSinceNow + seconds + minutes * 60.0 + hours * 3600.0 + days * 86400.0)
    }
    
}

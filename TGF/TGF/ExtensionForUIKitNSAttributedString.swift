//
//  ExtensionForUIKitNSAttributedString.swift
//  TGF
//
//  Created by andrzej semeniuk on 12/15/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    public subscript(_ text:String) -> NSRange {
        if let r = self.string.range(of: text) {
            let from = self.string.distance(from:self.string.startIndex, to:r.lowerBound)
            let to   = self.string.distance(from:self.string.startIndex, to:r.upperBound)
            return NSRange(location: from, length: to - from)
        }
        return NSRange()
    }
}

extension NSMutableAttributedString {
    
}



public func + (lhs:NSMutableAttributedString, rhs:NSMutableAttributedString) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString:lhs)
    r.append(rhs)
    return r
}

public func + (lhs:NSAttributedString, rhs:NSAttributedString) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString:lhs)
    r.append(rhs)
    return r
}

public func + (lhs:NSMutableAttributedString, rhs:NSAttributedString) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString:lhs)
    r.append(rhs)
    return r
}

public func + (lhs:NSAttributedString, rhs:NSMutableAttributedString) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString:lhs)
    r.append(rhs)
    return r
}



public func += (lhs:inout NSMutableAttributedString, rhs:NSMutableAttributedString) {
    lhs = lhs + rhs
}

public func += (lhs:inout NSAttributedString, rhs:NSAttributedString) {
    lhs = lhs + rhs
}

public func += (lhs:inout NSMutableAttributedString, rhs:NSAttributedString) {
    lhs.append(rhs)
}

public func += (lhs:inout NSAttributedString, rhs:NSMutableAttributedString) {
    lhs = lhs + rhs
}



public func * (string:String,color:UIColor) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(string:string)
    r.addAttribute(NSForegroundColorAttributeName, value: color, range: NSRange(location:0,length:r.length))
    return r
}

public func * (string:String,font:UIFont) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(string: string)
    r.addAttribute(NSFontAttributeName, value: font, range: NSRange(location:0,length:r.length))
    return r
}



public func * (string:NSAttributedString,color:UIColor) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttribute(NSForegroundColorAttributeName, value: color, range: NSRange(location:0,length:r.length))
    return r
}

public func * (string:NSAttributedString,font:UIFont) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttribute(NSFontAttributeName, value: font, range: NSRange(location:0,length:r.length))
    return r
}

public func * (string:NSAttributedString,attributes:[String:Any]) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttributes(attributes, range: NSRange(location: 0,length: r.length))
    return r
}

public func * (string:NSAttributedString,tuple:(attributes:[String:Any],range:NSRange)) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttributes(tuple.attributes, range: tuple.range)
    return r
}




public func * (string:NSMutableAttributedString,color:UIColor) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttribute(NSForegroundColorAttributeName, value: color, range: NSRange(location:0,length:r.length))
    return r
}

public func * (string:NSMutableAttributedString,font:UIFont) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttribute(NSFontAttributeName, value: font, range: NSRange(location:0,length:r.length))
    return r
}

public func * (string:NSMutableAttributedString,attributes:[String:Any]) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttributes(attributes, range: NSRange(location: 0,length: r.length))
    return r
}

public func * (string:NSMutableAttributedString,tuple:(attributes:[String:Any],range:NSRange)) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttributes(tuple.attributes, range: tuple.range)
    return r
}



public func *= (string:inout NSAttributedString,color:UIColor) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttribute(NSForegroundColorAttributeName, value: color, range: NSRange(location:0,length:r.length))
    string = r
    return r
}

public func *= (string:inout NSAttributedString,font:UIFont) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttribute(NSFontAttributeName, value: font, range: NSRange(location:0,length:r.length))
    string = r
    return r
}

public func *= (string:inout NSAttributedString,attributes:[String:Any]) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttributes(attributes, range: NSRange(location: 0,length: r.length))
    string = r
    return r
}

public func *= (string:inout NSAttributedString,tuple:(attributes:[String:Any],range:NSRange)) -> NSMutableAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttributes(tuple.attributes, range: tuple.range)
    string = r
    return r
}



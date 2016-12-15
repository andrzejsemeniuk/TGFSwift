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
    
}

extension NSMutableAttributedString {
    
}



public func * (string:String,color:UIColor) -> NSAttributedString {
    let r = NSMutableAttributedString(string:string)
    r.addAttribute(NSForegroundColorAttributeName, value: color, range: NSRange(location:0,length:r.length))
    return r
}

public func * (string:String,font:UIFont) -> NSAttributedString {
    let r = NSMutableAttributedString(string: string)
    r.addAttribute(NSFontAttributeName, value: font, range: NSRange(location:0,length:r.length))
    return r
}



public func * (string:NSAttributedString,color:UIColor) -> NSAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttribute(NSForegroundColorAttributeName, value: color, range: NSRange(location:0,length:r.length))
    return r
}

public func * (string:NSAttributedString,font:UIFont) -> NSAttributedString {
    let r = NSMutableAttributedString(attributedString: string)
    r.addAttribute(NSFontAttributeName, value: font, range: NSRange(location:0,length:r.length))
    return r
}



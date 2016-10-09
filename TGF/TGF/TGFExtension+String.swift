//
//  TGFExtension+String.swift
//  TGF
//
//  Created by andrzej semeniuk on 10/9/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation

extension String
{
    public var length: Int {
        return characters.count
    }
    
    public var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
    
    public var base64Encoded: String {
        let step1:NSString      = self as NSString
        let step2:Data        = step1.data(using: String.Encoding.utf8.rawValue)!
        let options             = Data.Base64EncodingOptions(rawValue: 0)
        let result:String       = step2.base64EncodedString(options: options)
        
        return result
    }
    
    public var empty: Bool {
        return length < 1
    }
    
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = characters.index(startIndex, offsetBy: r.lowerBound)
        let end = characters.index(start, offsetBy: r.upperBound - r.lowerBound)
        return self[Range(start ..< end)]
    }
    
    public func trimmed() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    public func trimIfBeyondDigitCount(_ count:Int) -> String {
        var count = count
        let digits:Set<Character> = ["0","1","2","3","4","5","6","7","8","9"]
        var i = 0
        for c in characters {
            i = i+1
            if digits.contains(c) {
                count = count-1
                if count <= 0 {
                    return substring(0,length:i)
                }
            }
        }
        return self
    }
    
    public func prefixWithPlusIfPositive() -> String
    {
        if 0 < length && self[0] != "-" {
            return "+" + self
        }
        return self
    }
    
    public func trimmedFromEndIfLongerThan(_ count:Int) -> String {
        if count < length {
            return substring(0,length:count)
        }
        return self
    }
    
    public func substring(_ from:Int = 0, to:Int = -1) -> String {
        var to = to
        if to < 0 {
            to = self.length + to
        }
        return self.substring(with: Range<String.Index>(self.characters.index(self.startIndex, offsetBy: from)..<self.characters.index(self.startIndex, offsetBy: to+1)))
    }
    
    public func substring(_ from:Int = 0, length:Int) -> String {
        return self.substring(with: Range<String.Index>(self.characters.index(self.startIndex, offsetBy: from)..<self.characters.index(self.startIndex, offsetBy: from+length)))
    }
    
}

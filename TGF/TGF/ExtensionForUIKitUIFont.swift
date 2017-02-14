//
//  ExtensionForUIKitUIFont.swift
//  TGF
//
//  Created by andrzej semeniuk on 2/12/17.
//  Copyright © 2017 Tiny Game Factory LLC. All rights reserved.
//

import Foundation
import CoreText

extension UIFont {

    public func highestCharacter() -> UInt32 {
        let characterSet = CTFontCopyCharacterSet(self as CTFont)
        let c = characterSet as NSCharacterSet
        return c.highest
    }

    public func countOfCharacters() -> UInt32 {
        let characterSet = CTFontCopyCharacterSet(self as CTFont)
        let c = characterSet as NSCharacterSet
        return c.total
    }
}

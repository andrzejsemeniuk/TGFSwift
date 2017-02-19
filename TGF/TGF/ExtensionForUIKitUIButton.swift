//
//  ExtensionForUIKitUIButton.swift
//  TGF
//
//  Created by andrzej semeniuk on 2/15/17.
//  Copyright © 2017 Tiny Game Factory LLC. All rights reserved.
//

import Foundation

extension UIButton {
    
    public static func name(state:UIControlState) -> String {
        switch state {
        case UIControlState.application                 : return "application"
        case UIControlState.disabled                    : return "disabled"
        case UIControlState.focused                     : return "focused"
        case UIControlState.highlighted                 : return "highlighted"
        case UIControlState.normal                      : return "normal"
        case UIControlState.reserved                    : return "reserved"
        case UIControlState.selected                    : return "selected"
        default:
            return String(state.rawValue)
        }
    }
}

//
//  UIViewValue.swift
//  TGF
//
//  Created by andrzej semeniuk on 5/2/17.
//  Copyright © 2017 Tiny Game Factory LLC. All rights reserved.
//

import Foundation
import UIKit

//-title
//-value
//-output
//-+/-
//-mode
//-bar
//-mark
//-notch

public class UIViewValue {
    
    public var title        : UILabel?
    public var value        : AnyObject?
    public var output       : AnyObject?
    public var plus         : UIButton?
    public var minus        : UIButton?
    public var mode         : Int?
    public var bar          : UIView?
    public var mark         : UIView?
    public var notch        : UIView?

    init() {
        
    }
    
    
}

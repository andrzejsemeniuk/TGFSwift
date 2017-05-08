//
//  UIBorder.swift
//  TGF
//
//  Created by andrzej semeniuk on 5/2/17.
//  Copyright © 2017 Tiny Game Factory LLC. All rights reserved.
//

import Foundation
import UIKit

public class UIViewBorder : UIView {
    
    public enum Style {
        case dash   (space:CGFloat,length:CGFloat)
        case dot    (space:CGFloat,radius:CGFloat)
        case solid  (thickness:CGFloat)
    }
    
    public var sides            : Set<UIViewSide>             = [.top,.left,.bottom,.right]
    public var style            : Style                 = .solid(thickness:1)
    public var color            : UIColor               = .clear
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

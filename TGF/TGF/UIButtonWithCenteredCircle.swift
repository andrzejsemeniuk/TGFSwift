//
//  UIButtonWithCenteredCircle.swift
//  TGF
//
//  Created by andrzej semeniuk on 2/12/17.
//  Copyright © 2017 Tiny Game Factory LLC. All rights reserved.
//

import Foundation
import UIKit

public class UIButtonWithCenteredCircle : UIButton {
    
    public private(set) var circle:CAShapeLayer = CAShapeLayer()
    public var radius:CGFloat = 0 {
        didSet {
        }
    }

    public override func draw(_ rect: CGRect) {
        if circle.superlayer == nil {
            self.layer.addSublayer(circle)
        }
        circle.path = UIBezierPath(arcCenter    : CGPoint(x:frame.size.width/2, y:frame.size.height/2),
                                   radius       : radius,
                                   startAngle   : 0,
                                   endAngle     : 2 * CGFloat(M_PI),
                                   clockwise    : false).cgPath
        super.draw(rect)
    }
    
    public override func titleRect(forContentRect: CGRect) -> CGRect {
        if let text = self.attributedTitle(for: self.state) {
            var bbox = UIGlyph.calculateBBox(of: text)
//            bbox.height += 3
//            bbox.width += 1
            switch (self.contentHorizontalAlignment,self.contentVerticalAlignment) {
            case (.left,.top):
                return CGRect(x         : forContentRect.center.x - bbox.width/2,
                              y         : forContentRect.center.y - bbox.height/2,
                              width     : bbox.width,
                              height    : bbox.height)
            case (.left,.center):
                return CGRect(x         : forContentRect.center.x - bbox.width/2,
                              y         : forContentRect.center.y - bbox.height/2,
                              width     : bbox.width,
                              height    : bbox.height)
            case (.left,.bottom):
                return CGRect(x         : forContentRect.center.x - bbox.width/2,
                              y         : forContentRect.center.y - bbox.height/2,
                              width     : bbox.width,
                              height    : bbox.height)
            case (.center,.top):
                return CGRect(x         : forContentRect.center.x - bbox.width/2,
                              y         : forContentRect.center.y - bbox.height/2,
                              width     : bbox.width,
                              height    : bbox.height)
            case (.center,.center):
                return CGRect(x         : forContentRect.center.x - bbox.origin.x/2 - bbox.width/2,
                              y         : forContentRect.center.y - bbox.origin.y/2 - bbox.height/2,
                              width     : bbox.width,
                              height    : bbox.height)
            case (.center,.bottom):
                return CGRect(x         : forContentRect.center.x - bbox.width/2,
                              y         : forContentRect.center.y - bbox.height/2,
                              width     : bbox.width,
                              height    : bbox.height)
            case (.right,.top):
                return CGRect(x         : forContentRect.center.x - bbox.width/2,
                              y         : forContentRect.center.y - bbox.height/2,
                              width     : bbox.width,
                              height    : bbox.height)
            case (.right,.bottom):
                return CGRect(x         : forContentRect.center.x - bbox.width/2,
                              y         : forContentRect.center.y - bbox.height/2,
                              width     : bbox.width,
                              height    : bbox.height)
            case (.right,.bottom):
                return CGRect(x         : forContentRect.center.x - bbox.width/2,
                              y         : forContentRect.center.y - bbox.height/2,
                              width     : bbox.width,
                              height    : bbox.height)
            default:
                break
            }
        }
        return super.titleRect(forContentRect: forContentRect)
    }

}

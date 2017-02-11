//
//  UICircleButton.swift
//  TGF
//
//  Created by andrzej semeniuk on 2/9/17.
//  Copyright © 2017 Tiny Game Factory LLC. All rights reserved.
//

import Foundation
import UIKit

//public class UICircleButton : UIButton {
//    
//    override public init(frame: CGRect) {
//        
//    }
//    
//    override public func draw(_ rect: CGRect) {
//        
//    }
//}


public class UICircle : UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = max(frame.size.width,frame.size.height)/2
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

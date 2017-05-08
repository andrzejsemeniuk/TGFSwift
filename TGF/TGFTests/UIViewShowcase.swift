//
//  UIViewShowcase.swift
//  TGF
//
//  Created by andrzej semeniuk on 5/3/17.
//  Copyright © 2017 Andrzej Semeniuk. All rights reserved.
//

import Foundation
import UIKit
import TGF

class UIViewShowcase : UIViewController {
    
    override func viewDidLoad() {

        self.testUILabelWithRectangularBackground()
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.landscapeLeft, UIInterfaceOrientationMask.landscapeRight]
    }
    
    private func testUILabelWithInsetsAndCenteredCircle() {
        
        self.view.backgroundColor = .red
        
        let label1 = UILabelWithInsetsAndCenteredCircle()
        
        label1.circle.radius    = 48
        label1.circle.fillColor = UIColor(white:1, alpha:0.6).cgColor
        label1.attributedText   = "\u{226B}" | UIColor.white | UIFont.systemFont(ofSize: 64)
        label1.textAlignment    = .center
        //        label1.insets.left += 14
        label1.insets.bottom   += 8
        
        self.view.addSubview(label1)
        
        label1          .translatesAutoresizingMaskIntoConstraints = false
        label1          .centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label1          .centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        label1          .widthAnchor.constraint(equalToConstant: label1.circle.radius).isActive = true
        label1          .heightAnchor.constraint(equalToConstant: label1.circle.radius).isActive = true
    }
    
    private func testUILabelWithRectangularBackground() {

        self.view.backgroundColor = .green
        
        let label1 = UILabel()
        
        
        label1.attributedText = "  TITLE  "
            | (name:NSBackgroundColorAttributeName, value:UIColor.black)
            | (name:NSForegroundColorAttributeName, value:UIColor.white)
            | UIFont.systemFont(ofSize: 48)
        
        label1.sizeToFit()
        
        self.view.addSubview(label1)
        
        label1          .translatesAutoresizingMaskIntoConstraints = false
        label1          .centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label1          .centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    private func testUIViewPane1() {
        // tap on view to open pane
        // tap on pane to close pane
    }
    
    private func testUIViewGroupValueHue() {
        
    }

    
}

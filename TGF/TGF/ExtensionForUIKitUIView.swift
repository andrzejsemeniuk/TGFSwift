//
//  TGFExtension+UIView.swift
//  TGF
//
//  Created by andrzej semeniuk on 10/9/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    public class func createWithBackgroundColor(_ color:UIColor) -> UIView
    {
        let result = UIView()
        result.backgroundColor = color
        return result
    }
}

//
//  TGFExtension+UserDefaults.swift
//  TGF
//
//  Created by andrzej semeniuk on 10/9/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation

extension UserDefaults
{
    public class func clear()
    {
        let domain      = Bundle.main.bundleIdentifier
        
        let defaults    = UserDefaults.standard
        
        if let name = domain {
            defaults.removePersistentDomain(forName: name)
        }
    }
}


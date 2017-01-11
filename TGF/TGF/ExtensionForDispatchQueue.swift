//
//  ExtensionForDispatchQueue.swift
//  TGF
//
//  Created by andrzej semeniuk on 12/29/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    public var background: DispatchQueue {
        return DispatchQueue.global(qos: .background)
    }
    
}

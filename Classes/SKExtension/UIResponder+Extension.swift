
//
//  UIResponder+Extension.swift
//  GXCreditManagement
//
//  Created by Sky on 2018/6/22.
//  Copyright © 2018年 liankai. All rights reserved.
//

import Foundation


private weak var gx_currentFirstResponder: AnyObject?

extension UIResponder {
    
    static func gx_FirstResponder() -> AnyObject? {
        UIApplication.shared.sendAction(#selector(gx_findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return gx_currentFirstResponder
    }
    
    @objc private func gx_findFirstResponder(_ sender: AnyObject) {
        gx_currentFirstResponder = self
    }
    
    
}






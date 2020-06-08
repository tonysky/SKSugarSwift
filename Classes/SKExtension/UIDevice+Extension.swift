//
//  UIDevice+Extension.swift
//
//  Created by Sky on 2018/2/6.
//

import UIKit

extension UIDevice {
    
    @objc class var systemVersionF: Float {
        let temp = UIDevice.current.systemVersion
        let arr = temp.components(separatedBy: ".")
        var version = arr[0]
        if arr.count >= 1 {
            version += "." + arr[1]
        }
        
        return Float(version) ?? 0
    }  
    
    
}

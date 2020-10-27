//
//  UIColor+Extension.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/6/8.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

public extension UIColor {

    convenience init(hex: Int32) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0, 
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0, 
            blue: CGFloat(hex & 0x0000FF) / 255.0, 
            alpha: 1
        )
    }

    convenience init(hexStr: String) {
        var str = hexStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if str.hasPrefix("0X") { str = String(str.suffix(from: str.index(str.startIndex, offsetBy: 2))) }
        if str.hasPrefix("#") { str = String(str.suffix(from: str.index(str.startIndex, offsetBy: 1))) }
        
        if str.count != 6 { self.init(red: 0, green: 0, blue: 0, alpha: 1) } //默认为黑色
        
        // 转换
        
        var r: UInt64 = 0, g: UInt64 = 0, b: UInt64 = 0
        _ = Scanner(string: String(str.prefix(2))).scanHexInt64(&r)
        _ = Scanner(string: String(str[str.index(str.startIndex, offsetBy: 2) ..< str.index(str.startIndex, offsetBy: 4)])).scanHexInt64(&g)
        _ = Scanner(string: String(str[str.index(str.startIndex, offsetBy: 4) ..< str.index(str.startIndex, offsetBy: 6)])).scanHexInt64(&b)
        
        self.init(
            red: CGFloat(r) / 255.0, 
            green: CGFloat(g) / 255.0, 
            blue: CGFloat(b) / 255.0, 
            alpha: 1
        )
    }
}


public extension UIColor {
    
    /// skyBlue: 0x66ccff
    class var skyBlue: UIColor { UIColor(hex: 0x66ccff) }
    
    /// 118, 166, 248
    class var system_Blue: UIColor { UIColor(red: 118, green: 166, blue: 248, alpha: 1) }
    
    
}









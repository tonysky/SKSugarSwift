//
//  UIColor+Extension.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/6/8.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

extension UIColor {

    public convenience init(hex: Int32) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0, 
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0, 
            blue: CGFloat(hex & 0x0000FF) / 255.0, 
            alpha: 1
        )
    }

}

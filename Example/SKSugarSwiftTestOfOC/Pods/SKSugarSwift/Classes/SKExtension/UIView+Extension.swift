//
//  UIView+Extension.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/6/10.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

public extension UIView {

    /// 批量添加子控件，并取消子控件的 translatesAutoresizingMaskIntoConstraints，方便使用自动布局
    func addSubviews(_ views: UIView ...) {
        for v in views {
            addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    }

}

//
//  UIView+Extension.swift
//  FenxiaoMS
//
//  Created by Sky on 2018/3/1.
//  Copyright © 2018年 lainkai. All rights reserved.
//

import UIKit

extension UIView {
    
    convenience init(bgColor: UIColor) {
        self.init()
        backgroundColor = bgColor 
    }
    
    convenience init(bgColorHex hex: UInt32) {
        self.init()
        backgroundColor = UIColor(gx_hex: hex) 
    }
    
    
    

    
    
    
}


// MARK: - 截图 shot
extension UIView {
    
    
    
    
    
}


// MARK: -  阴影
extension UIView {
    
    public func gx_setShadowColor(_ shadowColor: UIColor)
    {
        layer.shadowPath = UIBezierPath(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: bounds.size.width + 15, height: bounds.size.height + 2))).cgPath
        layer.shadowOffset = CGSize(width: 5, height: 3)
        layer.shadowColor = shadowColor.cgColor
        
        layer.shadowOpacity = 0.5 
        layer.shadowRadius = 10
        
        clipsToBounds = false      
    }
    
    
    
}


// MARK: - 隐藏键盘
extension UIView {
    
    /// 当点击view的时候隐藏键盘
    func setKeyboardHideWhenTap() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapAnywhereAction(_:)))
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) { [weak self] (note) in
            //
            self?.addGestureRecognizer(singleTap)
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main) { [weak self] (note) in
            //
            self?.removeGestureRecognizer(singleTap)
        }
    }
    
    /// 移除监听键盘的通知
    func removeKeyboardNote() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    /// 注销界面所有控件的第一响应者
    func resignAllFirstResponder() {
        endEditing(true)
        UIApplication.shared.keyWindow?.endEditing(true)
        UIApplication.shared.delegate?.window!?.endEditing(true)
        UIViewController.keyViewController.navigationItem.titleView?.endEditing(true)
    }
    
    @objc func tapAnywhereAction(_ tap: UITapGestureRecognizer) {
        endEditing(true)
    }

}



/// frame
extension UIView {
    
    /// bottomY 坐标 - 如果要设置 gx_bottomY值，最好先设置 height
    var gx_bottomY: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set {
            frame = CGRect(x: frame.origin.x, 
                           y: gx_bottomY - bounds.height, 
                           width: bounds.width, 
                           height: bounds.height)
        }
    }
    
    /// rightX 坐标 - 如果要设置 gx_rightX值，最好先设置 width
    var gx_rightX: CGFloat {
        get {
            return frame.origin.x + frame.size.height
        }
        set {
            frame = CGRect(x: gx_rightX - bounds.width,
                           y: frame.origin.y,
                           width: bounds.width,
                           height: bounds.height)
        }
    }
    
    
    var gx_Point_left_bottom: CGPoint {
        get {
            return CGPoint(x: frame.origin.x, y: frame.origin.x + bounds.height)
        }
        set {
            frame = CGRect(x: gx_Point_left_bottom.x,
                           y: gx_Point_left_bottom.y - bounds.height,
                           width: bounds.width,
                           height: bounds.height)
        }
    }
    
    var gx_Point_top_right: CGPoint {
        get {
            return CGPoint(x: frame.origin.x + bounds.width, y: frame.origin.y)
        }
        set {
            frame = CGRect(x: gx_Point_top_right.x - bounds.width,
                           y: gx_Point_top_right.y,
                           width: bounds.width,
                           height: bounds.height)
        }
    }
    
    var gx_Point_bottom_right: CGPoint {
        get {
            return CGPoint(x: frame.origin.x + bounds.width, y: frame.origin.y + bounds.height)
        }
        set {
            frame = CGRect(x: gx_Point_bottom_right.x - bounds.width,
                           y: gx_Point_bottom_right.y - bounds.height,
                           width: bounds.width,
                           height: bounds.height)
        }
    }
    
    
    
    
    
}

















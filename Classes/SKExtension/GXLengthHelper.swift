//
//  GXLengthHelper.swift
//  FenxiaoMS
//
//  Created by Sky on 2018/2/5.
//  Copyright © 2018年 lainkai. All rights reserved.
//

import UIKit

let CGRectZero: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
let CGPointZero: CGPoint = CGPoint(x: 0, y: 0)

let k_screenSize: CGSize = UIScreen.main.bounds.size
let k_screenWidth: CGFloat = k_screenSize.width
let k_screenHeight: CGFloat = k_screenSize.height



@objcMembers class GXLengthHelper: NSObject {
    
    static let sharedInstance = GXLengthHelper()
    private override init() { }
    
    public lazy var m_screenSize: CGSize = { return UIScreen.main.bounds.size }() 
    
    class func screenSize() -> CGSize {
        return sharedInstance.m_screenSize;
    }
    
    class func screenWidth () -> CGFloat {
        return sharedInstance.m_screenSize.width;
    }  
    
    class func screenHeight() -> CGFloat {
        return sharedInstance.m_screenSize.height;
    }
    
    
    
    
    
    
    
    
    
    
    deinit {
        print("deinit")
    }
}




















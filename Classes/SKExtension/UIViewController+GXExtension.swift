
//
//  UIViewController+Extension.swift
//  FenxiaoMS
//
//  Created by Sky on 2018/2/28.
//  Copyright © 2018年 lainkai. All rights reserved.
//

import UIKit 

extension UIViewController {
    
    /// 视图控制器转场 
    func gx_transition(fromVc: UIViewController, toVc: UIViewController) {
        if fromVc == toVc {
            return
        }
        
        self.transition(from: fromVc, to: toVc, duration: 0.2, options: .transitionCrossDissolve, animations: nil) { (finished) in
            if finished {
                toVc.didMove(toParent: self)
            }
        }
    }
    
    
    
    
    

    
    
    
    /// 获取当前活动的viewController（包含 presentedViewController 但不包含vc.childViewController；）
    static var keyViewController: UIViewController {
        return UIViewController.getKeyViewController()
    }
    
    /// 获取当前活动的viewController（包含 presentedViewController 但不包含vc.childViewController；）
    static func getKeyViewController() -> UIViewController 
    {
        let rootVc = (UIApplication.shared.delegate?.window!)!.rootViewController!
        return getKeyViewController(withRootVc: rootVc)
    }
    
    /// 根据 rootVc 获取当前活动的viewController（包含 presentedViewController 但不包含vc.childViewController；）
    static func getKeyViewController(withRootVc controller: UIViewController) -> UIViewController 
    {
        var rootVc = controller
        let presentedVc = rootVc.presentedViewController
        if presentedVc != nil {
            rootVc = presentedVc!
        }
        
        if rootVc is UITabBarController {
            return getKeyViewController(withRootVc: (rootVc as! UITabBarController).selectedViewController!) //递归
        } else if rootVc is UINavigationController {
            return getKeyViewController(withRootVc: (rootVc as! UINavigationController).visibleViewController!) //递归
        } else {
            return rootVc
        }
    }
    
    
}















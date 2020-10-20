//
//  UIButton+Extension.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/10/20.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

public typealias ClickClosure = (_ button: UIButton) -> (Void)

public extension UIButton {
    
    func sk_setTitle(title: String) {
        setTitle(title, for: .normal)
        setTitle(title, for: .highlighted)
        
        sizeToFit()
    }
    
    convenience init(image: UIImage, imageSelected: UIImage) {
        self.init()
        setImage(image, for: .normal)
        setImage(imageSelected, for: .selected)
    }
    
    convenience init(imageName: String, imageNameSelected: String) {
        if let image = UIImage(named: imageName),
           let selectedImage = UIImage(named: imageNameSelected)
        { self.init(image: image, imageSelected: selectedImage) }
        else { self.init() }
    }
    
    
    
    

    
    /// 根据 title、fontSize=14、isFontBold=false、color=black、colorHighlighted=gray、backgroundColor=white、(^handle)=nil 创建button
    convenience init (gx_title: String, 
                      fontSize: CGFloat = 14, 
                      isFontBold: Bool = false,
                      color: UIColor = UIColor.black, 
                      colorHighlighted: UIColor = UIColor.gray, 
                      backgroundColor: UIColor = UIColor.clear, 
                      handle: ClickClosure? = nil) 
    {
        self.init()
        
        setTitle(gx_title, for: .normal)
        titleLabel?.font = isFontBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        
        setTitleColor(color, for: .normal)
        setTitleColor(colorHighlighted, for: .highlighted)
        self.backgroundColor = backgroundColor
        
        titleLabel?.numberOfLines = 0
        titleLabel?.sizeToFit()
        sizeToFit()
        
        addClickClosure(handle)
    }
    
    /// 根据 title、fontSize=14、color=black、colorHighlighted=gray、backgroundColor=white、target、action 创建button
    convenience init (gx_title: String, 
                      fontSize: CGFloat = 14, 
                      color: UIColor = UIColor.black, 
                      colorHighlighted: UIColor = UIColor.gray, 
                      backgroundColor: UIColor = UIColor.clear, 
                      target: Any?, action: Selector) 
    {
        self.init()
        
        setTitle(gx_title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(color, for: .normal)
        setTitleColor(colorHighlighted, for: .highlighted)
        self.backgroundColor = backgroundColor
        
        titleLabel?.numberOfLines = 0
        titleLabel?.sizeToFit()
        sizeToFit()
        
        self.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }
    
}




// MARK: - ClickClosure
extension UIButton {
    
    private struct RuntimeKeys {
        static var k_click = "k_click"
    }
    
    private var container: ClosureContainer? {
        get {
            return objc_getAssociatedObject(self, &RuntimeKeys.k_click) as? ClosureContainer
        }
        set {
            objc_setAssociatedObject(self, &RuntimeKeys.k_click, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    @objc private func buttonClick(_ button: UIButton) {
        DispatchQueue.main.async {
            self.container?.clickClosure?(button)
        }
    }
    
    /// 添加 clickClosure
    private func addClickClosure(_ click: ClickClosure?) {
        guard let handle = click else {
            return
        }
        container = ClosureContainer()
        container?.clickClosure = handle
        
        addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
    }
    
    private class ClosureContainer {
        var clickClosure: ClickClosure?
    } 
}





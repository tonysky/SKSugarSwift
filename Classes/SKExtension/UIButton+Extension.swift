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
    
    convenience init(image: UIImage, imageSelected: UIImage, target: Any? = nil, action: Selector? = nil) {
        self.init()
        setImage(image, for: .normal)
        setImage(imageSelected, for: .selected)
        
        guard let target = target, let action = action else { return }
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    convenience init(imageName: String, imageNameSelected: String, target: Any? = nil, action: Selector? = nil) {
        if let image = UIImage(named: imageName),
           let selectedImage = UIImage(named: imageNameSelected)
        { self.init(image: image, imageSelected: selectedImage, target: target, action: action) }
        else { self.init() }
    }
    
    
    
    

    
    /// 根据 title、fontSize=14、isFontBold=false、color=black、colorHighlighted=gray、backgroundColor=white、(^handle)=nil 创建button
    convenience init (sk_title: String, 
                      fontSize: CGFloat = 14, 
                      isFontBold: Bool = false,
                      color: UIColor = UIColor.black, 
                      colorHighlighted: UIColor = UIColor.gray, 
                      backgroundColor: UIColor = UIColor.clear, 
                      handle: ClickClosure? = nil) 
    {
        self.init()
        
        setTitle(sk_title, for: .normal)
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
    convenience init (sk_title: String, 
                      fontSize: CGFloat = 14, 
                      color: UIColor = UIColor.black, 
                      colorHighlighted: UIColor = UIColor.gray, 
                      backgroundColor: UIColor = UIColor.clear, 
                      target: Any?, action: Selector) 
    {
        self.init()
        
        setTitle(sk_title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(color, for: .normal)
        setTitleColor(colorHighlighted, for: .highlighted)
        self.backgroundColor = backgroundColor
        
        titleLabel?.numberOfLines = 0
        titleLabel?.sizeToFit()
        sizeToFit()
        
        self.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }
    
    /// 创建 button title/ fontSize = 14/ titlecolorNormal/ imageName/ imageArrangement = .imageLeft/ target/ action（Swift 6 params）
    convenience init(sk_title: String, fontSize: CGFloat = 14, titleColorNormal: UIColor, imageName: String?,
                     target: Any?, action: Selector)
    {
        self.init()
        
        setTitle(sk_title, for: .normal)
        setTitleColor(titleColorNormal, for: .normal)
        
        setImage(UIImage.init(named: imageName ?? ""), for: .normal)
        imageView?.sizeToFit()
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        titleLabel?.numberOfLines = 0
        titleLabel?.sizeToFit()
        
        addTarget(target, action: action, for: .touchUpInside)
        sizeToFit()
    }
    
    /// 创建 button (使用图片)（Swift 4 params）
    ///
    /// - Parameters:
    ///   - title: 标题 title
    ///   - fontSize: 标题字体大小
    ///   - imageNormal: 默认状态图片
    ///   - imageHighlighted: 高亮状态图片
    convenience init(title: String, fontSize: CGFloat,
                     imageNormal: UIImage, imageHighlighted: UIImage)
    {
        self.init()
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        setImage(imageNormal, for: .normal)
        setImage(imageHighlighted, for: .highlighted)

        sizeToFit()
    }
    
    /// 创建 button (使用图片名称)（Swift 2 params）
    ///
    /// - Parameters:
    ///   - imageNameNormal: 默认状态图片
    ///   - imageNameHighlighted: 高亮状态图片
    convenience init(imageNameNormal: String, imageNameHighlighted: String)
    {
        self.init()
        
        setImage(UIImage.init(named: imageNameNormal), for: .normal)
        setImage(UIImage.init(named: imageNameHighlighted), for: .highlighted)
        
        sizeToFit()
    }
    
    
    /// 根据 image 和 backgroundImage 创建 button    
    ///
    /// - Parameters:
    ///   - imageName: button 的 image
    ///   - backgroundImageName: button 的 backgroundImage
    convenience init(imageName: String, backgroundImageName: String) 
    {
        self.init()
        
        setImage(UIImage.init(named: imageName), for: .normal)
        let imgNameHL = imageName + "_highlighted"
        setImage(UIImage.init(named: imgNameHL), for: .highlighted)
        
        setBackgroundImage(UIImage.init(named: backgroundImageName), for: .normal)
        let bgImgNameHL = backgroundImageName + "_highlighted"
        setBackgroundImage(UIImage.init(named: bgImgNameHL), for: .highlighted)
    }
    
    /// title/ fontSize = 14/ color = black/ bgImageName/ (^handle)
    convenience init(sk_title: String, fontSize: CGFloat = 14, color: UIColor = UIColor.black, backgroundImageName: String, handle: ClickClosure? = nil) 
    {
        self.init()
        
        setTitle(sk_title, for: .normal)
        setBackgroundImage(UIImage.init(named: backgroundImageName), for: .normal)
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(color, for: .normal)
        
        addClickClosure(handle)
    }
    
    
    
    /// title/ fontSize=14/ color=black/ colorSelected = blue/ isBold=false
    convenience init(sk_title: String, fontSize: CGFloat = 14, color: UIColor = .black, colorSelected: UIColor = .blue, isBold: Bool = false)
    {
        self.init()
        
        setTitle(sk_title, for: .normal)
        setTitleColor(color, for: .normal)
        setTitleColor(colorSelected, for: .selected)
        titleLabel?.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
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





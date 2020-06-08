//
//  UIButton+Extension.swift
//  FenxiaoMS
//
//  Created by Sky on 2018/2/6.
//  Copyright © 2018年 lainkai. All rights reserved.
//

import UIKit

typealias ClickClosure = (_ button: UIButton) -> (Void)

extension UIButton {
    
    enum GXButtonImageArrangement {
        case imageTop
        case imageLeft
        case imageRight
        case imageBottom
    }
    
    /// 创建 button (使用图片名称)（title/ fontSize = 14/ isFontBold = false/ imgNameNormal = ""/ imgNameHighlighted = ""/ titleColorNormal = .black/ titleColorHIghlighted = .lightGray    Swift 7 params）
    ///
    /// - Parameters:
    ///   - title: 标题 title
    ///   - fontSize: 标题字体大小
    ///   - isFontBold: 是否粗体
    ///   - imgNameNormal: 默认状态图片名称
    ///   - imgNameHighlighted: 高亮状态图片名称
    ///   - titleColorNormal: 默认状态字体颜色
    ///   - titleColorHighlighted: 高亮状态字体颜色
    convenience init(title: String, fontSize: CGFloat = 14, isFontBold: Bool = false,
                     imgNameNormal: String = "", imgNameHighlighted: String = "", 
                     titleColorNormal: UIColor = UIColor.black, titleColorHighlighted: UIColor = UIColor.lightGray)
    {
        self.init(title: title, fontSize: fontSize, titleColorNormal: titleColorNormal, titleColorHighlighted: titleColorHighlighted)
        
        if imgNameNormal != "" {
            setImage(UIImage.init(named: imgNameNormal), for: .normal)
        }
        if imgNameHighlighted != "" {
            setImage(UIImage.init(named: imgNameHighlighted), for: .highlighted)
        }
        
        titleLabel?.font = isFontBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
    }
    
    /// 创建 button (使用图片)（title/ fontSize = 14/ isFontBold = false/ imageNormal/ imageHighlighted/ titleColorNormal = .black/ titleColroHighlighted = .lightGray   Swift 7 params）
    ///
    /// - Parameters:
    ///   - title: 标题 title
    ///   - fontSize: 标题字体大小
    ///   - isFontBold: 是否粗体
    ///   - imageNormal: 默认状态图片
    ///   - imageHighlighted: 高亮状态图片
    ///   - titleColorNormal: 默认状态字体颜色
    ///   - titleColorHighlighted: 高亮状态字体颜色
    convenience init(title: String, fontSize: CGFloat = 14, isFontBold: Bool = false,
                     imageNormal: UIImage, imageHighlighted: UIImage?, 
                     titleColorNormal: UIColor = UIColor.black, titleColorHighlighted: UIColor = UIColor.lightGray)
    {
        self.init(title: title, fontSize: fontSize, titleColorNormal: titleColorNormal, titleColorHighlighted: titleColorHighlighted)
        
        setImage(imageNormal, for: .normal)
        setImage(imageHighlighted, for: .highlighted)
        
        titleLabel?.font = isFontBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
    }
    
    
    
    
    
    /// 创建 button（title/ fontSize/ titleColorNormal/ titileColorHighlighted  Swift 4 params）
    ///
    /// - Parameters:
    ///   - title: 标题 title
    ///   - fontSize: 标题字体大小
    ///   - titleColorNormal: 默认状态字体颜色
    ///   - titleColorHighlighted: 高亮状态字体颜色
    convenience init(title: String, fontSize: CGFloat = 14, 
                     titleColorNormal: UIColor, titleColorHighlighted: UIColor)
    {
        self.init()
        
        setTitle(title, for: .normal)
        setTitleColor(titleColorNormal, for: .normal)
        setTitleColor(titleColorHighlighted, for: .highlighted)
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        titleLabel?.numberOfLines = 0
        sizeToFit()
    }
    
    /// 根据 title/ fontSize/ titlecolorNormal/ titleColorHighlighted/ target/ action（Swift 6 params）创建 button
    convenience init(title: String, fontSize: CGFloat = 14, 
                     titleColorNormal: UIColor, titleColorHighlighted: UIColor,
                     target: Any?, action: Selector)
    {
        self.init()
        
        setTitle(title, for: .normal)
        setTitleColor(titleColorNormal, for: .normal)
        setTitleColor(titleColorHighlighted, for: .highlighted)
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        addTarget(target, action: action, for: .touchUpInside)
        
        titleLabel?.numberOfLines = 0
        sizeToFit()
    }
    
    
    /// 根据 title、fontSize、color、(^handle) 创建button
    convenience init (gx_title: String, fontSize: CGFloat = 14, color: UIColor, handle: ClickClosure?) 
    {
        self.init()
        
        setTitle(gx_title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(color, for: .normal)
        
        titleLabel?.numberOfLines = 0
        titleLabel?.sizeToFit()
        sizeToFit()
        
        addClickClosure(handle)
    }
    
    /// 根据 title、fontSize、color、highlightedColor、(^handle) 创建button
    convenience init (gx_title: String, fontSize: CGFloat = 14, color: UIColor, highlightedColor: UIColor, handle: ClickClosure?) 
    {
        self.init()
        
        setTitle(gx_title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(color, for: .normal)
        setTitleColor(highlightedColor, for: .highlighted)
        
        titleLabel?.numberOfLines = 0
        titleLabel?.sizeToFit()
        sizeToFit()
        
        addClickClosure(handle)
    }
    
    
    
    
    
    /// 根据 title、fontSize、color、garget、action 创建button
    convenience init (gx_title: String, fontSize: CGFloat = 14, color: UIColor, target: Any?, action: Selector) 
    {
        self.init()
        
        setTitle(gx_title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(color, for: .normal)
        
        titleLabel?.numberOfLines = 0
        titleLabel?.sizeToFit()
        sizeToFit()
        
        self.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }
    
    /// 根据 title、fontSize、color、highlightedColor、garget、action 创建button
    convenience init (gx_title: String, fontSize: CGFloat = 14, color: UIColor, highlightedColor: UIColor, target: Any?, action: Selector)
    {
        self.init()
        
        setTitle(gx_title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(color, for: .normal)
        setTitleColor(highlightedColor, for: .highlighted)
        
        titleLabel?.numberOfLines = 0
        titleLabel?.sizeToFit()
        sizeToFit()
        
        self.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }
    
    
    
    
    
    
    
    /// 创建 button title/ fontSize = 14/ titlecolorNormal/ imageName/ imageArrangement = .imageLeft/ target/ action（Swift 6 params）
    convenience init(gx_title: String, fontSize: CGFloat = 14, titleColorNormal: UIColor, imageName: String?,
                     imageArrangement: GXButtonImageArrangement = .imageLeft,
                     target: Any?, action: Selector)
    {
        self.init()
        
        setTitle(gx_title, for: .normal)
        setTitleColor(titleColorNormal, for: .normal)
        
        setImage(UIImage.init(named: imageName ?? ""), for: .normal)
        imageView?.sizeToFit()
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        titleLabel?.numberOfLines = 0
        titleLabel?.sizeToFit()
        
        addTarget(target, action: action, for: .touchUpInside)
        sizeToFit()
        
        switch imageArrangement {
        case .imageTop:
//            contentHorizontalAlignment = .center
            contentVerticalAlignment = .center
            imageEdgeInsets = UIEdgeInsets(top: CGFloat(0.0),
                                           left: CGFloat(0.0), 
                                           bottom: (titleLabel?.bounds.size.height)! + CGFloat(10.0),
                                           right: -(titleLabel?.bounds.size.width)!)
            
            titleEdgeInsets = UIEdgeInsets(/*(imageView?.bounds.size.height)! + */top: 10.0, 
                                                                                  left: -(imageView?.bounds.size.width)! - 10.0, 
                                                                                  bottom: 0.0, 
                                                                                  right: 0.0)
        case .imageLeft:
            break
        case .imageBottom:
//            titleEdgeInsets = UIEdgeInsetsMake(0.0, -(imageView?.bounds.size.width)!, 0.0, 0.0)
//            imageEdgeInsets = UIEdgeInsetsMake(<#T##top: CGFloat##CGFloat#>, <#T##left: CGFloat##CGFloat#>, <#T##bottom: CGFloat##CGFloat#>, <#T##right: CGFloat##CGFloat#>)
            break
        case .imageRight:
            break
        }
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
    
//    /// title/ fontSize = 14/ color = black/ bgImageName
//    convenience init(gx_title: String, fontSize: CGFloat = 14, color: UIColor = UIColor.black, backgroundImageName: String) 
//    {
//        self.init()
//        
//        setTitle(gx_title, for: .normal)
//        setBackgroundImage(UIImage.init(named: backgroundImageName), for: .normal)
//        
//        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
//        setTitleColor(color, for: .normal)
//    }
    
    /// title/ fontSize = 14/ color = black/ bgImageName/ (^handle)
    convenience init(gx_title: String, fontSize: CGFloat = 14, color: UIColor = UIColor.black, backgroundImageName: String, handle: ClickClosure? = nil) 
    {
        self.init()
        
        setTitle(gx_title, for: .normal)
        setBackgroundImage(UIImage.init(named: backgroundImageName), for: .normal)
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(color, for: .normal)
        
        addClickClosure(handle)
    }
    
    
    
    
}



extension UIButton {
    
    func gx_setTitle(title: String) {
        setTitle(title, for: .normal)
        setTitle(title, for: .highlighted)
        
        sizeToFit()
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











//
//  UITableView+Extension.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/8/5.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit


// MARK: -  便利构造器
public extension UITableView {
    
    /// rowHeight
    convenience init(frame fr: CGRect = CGRect(), 
                     style st: UITableView.Style = .plain, 
                     delegate dl: NSObjectProtocol, 
                     rowHeight rh: CGFloat = 44, 
                     registerCellClass cellClass: AnyClass, 
                     isNib: Bool = false,
                     cellReuseIdentifier cellID: String,
                     showsHorizontalScrollIndicator showsHoriIndicator: Bool = false,
                     showsVerticalScrollIndicator showsVertIndicator: Bool = false,
                     bounces bcs: Bool = true,
                     then: ((_ tv: UITableView)->())? = nil) 
    {
        self.init(frame: fr, style: st)
        
        delegate = (dl as! UITableViewDelegate)
        dataSource = (dl as! UITableViewDataSource)
        
        rowHeight = rh
        
        showsHorizontalScrollIndicator = showsHoriIndicator
        showsVerticalScrollIndicator = showsVertIndicator
        bounces = bcs
        
        isNib 
            ? register(UINib(nibName: String(cellClass.description().split(separator: ".").last ?? ""), bundle: nil), forCellReuseIdentifier: cellID)
            : register(cellClass, forCellReuseIdentifier: cellID)
        
        if then != nil { then!(self) } //闭包
    }
    
    /// astimatedRowHeight
    convenience init(frame fr: CGRect = CGRect(), 
                     style st: UITableView.Style = .plain, 
                     delegate dl: NSObjectProtocol,
                     estimatedRowHeight esrh: CGFloat,
                     registerCellClass cellClass: AnyClass, 
                     isNib: Bool = false,
                     cellReuseIdentifier cellID: String,
                     showsHorizontalScrollIndicator showsHoriIndicator: Bool = false,
                     showsVerticalScrollIndicator showsVertIndicator: Bool = false,
                     bounces bcs: Bool = true,
                     then: ((_ tv: UITableView)->())? = nil) 
    {
        self.init(frame: fr, style: st)
        
        delegate = (dl as! UITableViewDelegate)
        dataSource = (dl as! UITableViewDataSource)
        
        estimatedRowHeight = esrh
        rowHeight = UITableView.automaticDimension
        
        showsHorizontalScrollIndicator = showsHoriIndicator
        showsVerticalScrollIndicator = showsVertIndicator
        bounces = bcs
        
        isNib 
            ? register(UINib(nibName: String(cellClass.description().split(separator: ".").last ?? ""), bundle: nil), forCellReuseIdentifier: cellID)
            : register(cellClass, forCellReuseIdentifier: cellID)
        
        if then != nil { then!(self) } //闭包
    }
    
    
    
    
}


















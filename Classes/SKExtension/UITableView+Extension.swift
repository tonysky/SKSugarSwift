//
//  UITableView+Extension.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/8/5.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit



extension UITableView {
    
    convenience init(frame fr: CGRect = CGRect(), 
                     style st: UITableView.Style = .plain, 
                     delegate dl: NSObjectProtocol, 
                     rowHeight rh: CGFloat = 44, 
                     registerCellClass cellClass: AnyClass, 
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
        
        register(cellClass, forCellReuseIdentifier: cellID)
        
        guard let then = then else { return }
        then(self)
    }
    
    convenience init(frame fr: CGRect = CGRect(), 
                     style st: UITableView.Style = .plain, 
                     delegate dl: NSObjectProtocol, 
                     rowHeight rh: CGFloat, 
                     astimatedRowHeight esrh: CGFloat,
                     registerCellClass cellClass: AnyClass, 
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
        estimatedRowHeight = esrh
        
        showsHorizontalScrollIndicator = showsHoriIndicator
        showsVerticalScrollIndicator = showsVertIndicator
        bounces = bcs
        
        register(cellClass, forCellReuseIdentifier: cellID)
        
        guard let then = then else { return }
        then(self)
    }
    
    
    
    
}


















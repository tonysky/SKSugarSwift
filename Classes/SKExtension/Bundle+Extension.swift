
//
//  Bundle+Extension.swift
//
//  Created by Tony on 2018/2/9.
//  Copyright © 2018年 Tony. All rights reserved.
//

import Foundation 
import UIKit

public extension Bundle {
    
    /// 返回命名空间 namespace (计算型属性)
    var namespace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    /// 返回命名空间 namespace. (后面+点号)
    var namespaceDot: String {
        return namespace + "."
    }
    
    
    
    
    
    
    
    
    
} 












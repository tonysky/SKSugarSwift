//
//  TimeConsuming.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/7/2.
//  Copyright © 2020 Sky. All rights reserved.
//

import Foundation


/// 耗时测试工具类
@objcMembers public class TimeConsuming {
    
    public class func times(_ function: ()->(), _ isConvertTime: Bool = false) {
        let begin = CFAbsoluteTimeGetCurrent()
        function()
        let end = CFAbsoluteTimeGetCurrent()
        
        let diff = end - begin
        
        isConvertTime
        ? print("\n代码耗时 times = \(diff) s(秒)； 合时间为：【\(convertToTime(interval: diff))】")
        : print("\n代码耗时 times = \(diff) s(秒)")
    }
    
    
    public class func convertToTime(interval: TimeInterval) -> String {
        // 3662.89567
        
        let decimal_part: Double = interval - ceil(interval) //小数部分
        // 0.89567
        
        let mm_int: Int = Int(interval) % 3600
        // 62
        
        let ss_int: Int = mm_int % 60
        // 2
        
        let sss_interval = decimal_part * 100.0
        // 895.67
        
        return "\(Int(interval / 3600.0)):\(Int(mm_int / 60)):\(ss_int) \(sss_interval)"
    }
    
}


























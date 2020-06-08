//
//  Date+Extension.swift
//  GXCreditManagement
//
//  Created by Sky on 2018/6/14.
//  Copyright © 2018年 liankai. All rights reserved.
//

import Foundation


// MARK: - toString
/// toString
extension Date {
    
    /// "yyyy-MM-dd hh:mm:ss.SSS"
    func toString() -> String {
        let fmt = DateHelper.getFmt(.DATE_TIME_MS)
        
        return fmt.string(from: self)
    }
    
    func toString(formatType dateFormatType: DateFormatType) -> String {
        let fmt = DateHelper.getFmt(dateFormatType)
        return fmt.string(from: self)
    }
    
    func toString(_ dateFormat: String) -> String {
        let fmt = DateHelper.getFmt(dateFormat)
        
        return fmt.string(from: self)
    }
    
}// extension toString


// MARK: -  get Days
/// get Days
extension Date {
    
//    func getDaysSinceToday() -> Int {
//        return DateHelper.getDays(aDaySinceToday: self, format: )
//    }
    
}// extension get Days



// MARK: -  components
/// components
extension Date {
    
    func getYearStr() -> String {
        return toString("yyyy")
    }
    
    func getMonthStr() -> String {
        return toString("MM")
    }
    
    func getDayStr() -> String {
        return toString("dd")
    }
    
    /// ‘周一’
    func getWeekDayStr() -> String {
        return DateHelper.getWeekStr(self)
    }
    
    /// ‘星期一’
    func getWeekDayLongStr() -> String {
        return DateHelper.getWeekLongStr(self)
    }
    
    
    /// 当前时区的标准时间
    static func now() -> Date {
        return Date()
        
//        let date = Date()
//        let interval = NSTimeZone.system.secondsFromGMT(for: date)
//        
//        return date.addingTimeInterval(TimeInterval(interval))
    }
    
    /// 获取当前标准时间的格式化时间 default is "yyyyMMdd"
    static func getNowDate(formatType: DateFormatType = .DATE_DEFAULT) -> Date {
//        let calendar = Calendar.current
//        let componentsSet = Set<Calendar.Component>([.year, .month, .day])
//        let components = calendar.dateComponents(componentsSet, from: Date.now())
//        gxprint(components)
//        
//        let date = calendar.date(from: components)
//        let interval = NSTimeZone.system.secondsFromGMT(for: date!)
//        let result = date!.addingTimeInterval(TimeInterval(interval))
//        
//        return result
        
        
        let str = now().toString(formatType: formatType)
        let date = DateHelper.toDate(str)!
        
        return date
    }
    
    static func today(formatType: DateFormatType = .DATE_DEFAULT) -> Date {
        return getNowDate(formatType: formatType)
    }
    
    
}//extension components


// MARK: -  other methods
extension Date {
    
    /// 将一个日期转换为指定格式的日期
    func toFormatDate(toFormat: DateFormatType = .DATE_DEFAULT) -> Date {
        return DateHelper.toFormatDate(self, toFormat: toFormat)
    }
}






//
//  String+GXExtension.swift
//  GXCreditManagement
//
//  Created by Sky on 2018/6/6.
//  Copyright © 2018年 liankai. All rights reserved.
//

import Foundation



// MARK: - check & precess
extension String {
    
    /// 判断 str 是否为 nil 或者 ""空字符串
    static func isNullOrEmpty(str: String?) -> Bool {
        guard let temp = str else {
            return true
        } 
        if temp.count == 0 || temp == "" { return true }
        
        return false
    }
    
    
    func getNonNullString() -> String {
        if count == 0 { return "" }
        
        let temp = lowercased()
        if temp == "" || temp == "null" || temp == "nil" || temp == "nan"
            || temp == "<nil>" || temp == "<null>" || temp == "<nan>" 
            || temp == "(nil)" || temp == "(null)" || temp == "(nan)" 
            || temp == "false" || temp == "no" || temp == "0"
        {
            return ""
        }
        
        return self
    }
    
    
    /// trim 去掉前后的所有空格
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    

}


// MARK: - substring (prefix / suffix)
extension String {
    
    
    /// 截取并返回（从0 到 倒数index）之间的字符串 - （去掉后面 index 个字符）
    func prefix(toReverseIndex index: Int) -> String {
        if index >= count {
            return ""
        }
        // str[startIndex ..< count - index]
        return String(prefix(count - index))
    }
    
    
    /// 截取给定key后面的字符串并返回，截取的长度为给定长度。
    ///
    /// - Parameters:
    ///   - key: key
    ///   - length: 给定长度（要返回字符串的长度）
    ///   - containsKey: 要返回的字符串是否包含key
    /// - Returns: 返回截取结果字符串
    func suffix(key: String, length: Int, containsKey: Bool = false) -> String {
        if !self.contains(key) { return "" }
        
        let range: Range = self.range(of: key)!
        let startIndex = containsKey ? range.lowerBound : range.upperBound
        let str = self[startIndex ..< self.index(startIndex, offsetBy: 4)]
        
        return String(str)
    }
    
    /// 截取从 fromIndex 到 toIndex 之间的字符串 (fromIndex 不能大于 toIndex)
    /// - 默认包含fromIndex不包含toIndex
    ///
    /// - Parameters:
    ///   - fromIndex: fromIndex
    ///   - toIndex: toIndex
    ///   - containsFromIndex: containsFromIndex
    ///   - containsToIndex: containsToIndex
    /// - Returns: 返回之间的字符串
    func substring(fromIndex: Int, toIndex: Int, containsFromIndex: Bool = true, containsToIndex: Bool = false) -> String
    {
        //        if fromIndex < 0 || toIndex < 0 { gxprint("fromIndex 与 toIndex 都不能小于0  ！！！") }
        //        if fromIndex > toIndex { gxprint("fromIndex 不能大于 toIndex ！！！") }
        assert(fromIndex >= 0 && toIndex >= 0, "fromIndex 不能大于 toIndex ！！！")
        assert(fromIndex <= toIndex, "fromIndex 不能大于 toIndex ！！！")
        
        let from: Int = containsFromIndex ? fromIndex : fromIndex + 1
        let to: Int = containsToIndex ? toIndex + 1 : toIndex
        
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to + 1)
        
        let result = String(self[startIndex ..< endIndex])
        return result
    }
    
    /// 截取从 fromIndex 到结尾之间的字符串
    ///
    /// - Parameter fromIndex: fromIndex
    /// - Returns: 返回之间的字符串
    func substring(fromIndex: Int) -> String {
        return substring(fromIndex: fromIndex, toIndex: count - 1)
    }
    
    /// 截取 startKey 到 endKey 之间的字符串 (使用正则表达式截取) (如果至少有一个key不存在，返回 ""；如果两个key位置不对，返回 "")
    func substring(startKey: String, endKey: String, containsStartKey: Bool = false, containsEndKey: Bool = false) -> String 
    {
        var word = ""
        if !self.contains(startKey) || !self.contains(endKey) {
            return ""
        }
        
        let start = startKey.replacingOccurrences(of: "(", with: "\\(").replacingOccurrences(of: ")", with: "\\)")
        let end = endKey.replacingOccurrences(of: "(", with: "\\(").replacingOccurrences(of: ")", with: "\\)")
        
        let pattern = start + ".+" + end //正则表达式规则式
        guard let retRanges = GXRegexTool.getRanges(withPattern: pattern, inString: self) else {
            return ""
        }
        
        let retRange = retRanges.first!
        let subWord: Substring = self[String.Index(encodedOffset: retRange.lowerBound + startKey.count) ..< String.Index(encodedOffset: retRange.upperBound - endKey.count)]
        word = String(subWord)
        
        return word
    }
    
    /// 截取 startKey 到 endKey 之间的字符串，并返回符合条件的字符串数组 (使用正则表达式截取) (如果至少有一个key不存在，返回 ""；如果两个key位置不对，返回 "")
    func substrings(startKey: String, endKey: String, containsStartKey: Bool = false, containsEndKey: Bool = false) -> [String]? 
    {
        var arr: [String]? = [String]()
        
        if !self.contains(startKey) || !self.contains(endKey) {
            return nil
        }
        
        // - 方案一、 使用正则表达式过滤
        let start = startKey.replacingOccurrences(of: "(", with: "\\(").replacingOccurrences(of: ")", with: "\\)")
        let end = endKey.replacingOccurrences(of: "(", with: "\\(").replacingOccurrences(of: ")", with: "\\)")
        
        let pattern = start + ".{4}" + end //正则表达式规则式
        guard let retRanges: [NSRange] = GXRegexTool.getRanges(withPattern: pattern, inString: self) 
            else {
            return nil
        }
        
        for range in retRanges {
            let subWord = self[String.Index(encodedOffset: range.lowerBound + startKey.count) ..< String.Index(encodedOffset: range.upperBound - endKey.count)]
            arr?.append(String(subWord))
        }
        
        return arr
        
        
        // - 方案二、 使用截取字符串过滤并截取
        var str = self
        var startRange = str.range(of: startKey)!
        var endRange = str.range(of: endKey)!
        
        while str.contains(startKey) {
            startRange = str.range(of: startKey)!
            endRange = str.range(of: endKey)!
            
            if endRange.lowerBound.encodedOffset - startRange.upperBound.encodedOffset <= 0 {
                // startKey 与 endKey 的顺序错位
                gxprint("startKey 与 endKey 的顺序错位")
                return nil
            }
            
            let result1 = str[startRange.upperBound ..< endRange.lowerBound]
            arr?.append(String(result1))
            
            str = String(str.suffix(from: endRange.upperBound))
            if String.isNullOrEmpty(str: str) {
                continue
            }
        }
        
        return arr
    } 
    
    
    /// replace 替换
    func replace(of str: String, with other: String) -> String {
        return self.replacingOccurrences(of: str, with: other)
    }
    
    /// replaceAllWhiteSpace 替换所有空格
    func replaceAllWhiteSpace() -> String {
        return self.replace(of: " ", with: "")
    }
    
}


// MARK: - IndexOf
extension String {
    
    
    /// 返回给定key的第一个字符的索引 - Int 
    /// - （如果不存在，返回 -1 ）
    ///
    /// - Parameter key: key
    /// - Returns: key的第一个字符的索引-Int
    func indexOf(key: String) -> Int {
        if !self.contains(key) {  return -1  }
        
        guard let range: Range<String.Index> = self.range(of: key) else {
            return -1
        }
        
//        let index = self.distance(from: self.startIndex, to: range.lowerBound)
        let index = range.lowerBound.encodedOffset
        return index
    }
    
}


// MARK: - Split
extension String {
    
    /// 使用正则表达式以 pattern 字符串为 key 分割字符串为 [String] 字符串数组，并且会自动过滤字符串长度为0的元素
    /// - 例：str = "123|5哈哈||", key = "|"  ->  result = ["123", "5哈哈"]
    ///
    /// - Parameter pattern: 分隔符字符串
    func split(key pattern: String) -> [String] {
        guard let ranges = GXRegexTool.getRanges(forSplit_withPattern: pattern, inString: self) else {
            return [self]
        }
        
        var arr = [String]()
        var item = ""
        for range in ranges {
            item = String(self[String.Index(encodedOffset: range.lowerBound) ..< String.Index(encodedOffset: range.upperBound)])
            arr.append(item)
        }
        arr.removeAll(where: {$0 == ""})
        
        return arr
    }
    
    
    
    
    
}








// MARK: - test
extension String {
    
    func testSubstring() {
        // 相当于 substring 
        let str: String = "一二三四五六七八九十1234567890"
        
        // prefix
        
        let subStr_prefix_maxLength = str.prefix(5) 
        /* "一二三四五"  - 截取 正数 maxLength 位*/
        
        let subStr_prefix_upTo = str.prefix(upTo: str.index(of: "6")!)
        /* "一二三四五六七八九十12345" */
        
        let subStr_prefix_through = str.prefix(through: str.index(of: "2")!)
        /* "一二三四五六七八九十12" */
        
        
        let key = "五"
        let range1 = str.range(of: key)!
        let subStr_prefix_upTo2_lower = str.prefix(upTo: range1.lowerBound)
        /* "一二三四" */
        
        let subStr_prefix_upTo2_upper = str.prefix(upTo: range1.upperBound)
        /* "一二三四五" */
        
        let subStr_prefix_through2_lower = str.prefix(through: range1.lowerBound)
        /* "一二三四五" */
        
        let subStr_prefix_through2_upper = str.prefix(through: range1.upperBound)
        /* "一二三四五六" */
        
        
        
        // suffix
        
        let subStr_suffix_maxLength = str.suffix(6)
        /* "567890"  - 截取 倒数 maxLength 位*/
        
        let subStr_suffix_from = str.suffix(from: str.index(of: "5")!)
        /* "567890"  - 从 String.Index 开始，包含，到结束 */
        
        print(subStr_prefix_upTo, subStr_prefix_maxLength, subStr_prefix_through, 
              subStr_prefix_upTo2_lower, subStr_prefix_upTo2_upper, subStr_prefix_through2_lower, subStr_prefix_through2_upper,
              subStr_suffix_maxLength, subStr_suffix_from)
    }
    
    /// test
    func testIndex() {
        // 用到 Range'类'、String.Index、str.distance方法、str -> subscript方法 等
        
        let str: String = "我最爱北京天安门！"
        let range: Range = str.range(of: "北京")!
        let location: Int = str.distance(from: str.startIndex, to: range.lowerBound)  
        /* location = 3 */
        
        let keyLength: Int = str.distance(from: range.lowerBound, to: range.upperBound) 
        // let key = "北京"; let keyLength = key.count;  //count = 2
        /* keyLength = 2 */
        
        print("location = \(location), length = \(keyLength)")
        /* location = 3, length = 2 */
        
        // SubString
        let frontStr: Substring = str[str.startIndex ..< range.lowerBound]
        print("frontSubStr = \(frontStr)") 
        /* 我最爱 */
        
        let frontStr2: Substring = str[str.startIndex ... range.lowerBound]
        print("frontSubStr2 = \(frontStr2)") 
        /* 我最爱北 */
        
        
        // MARK: 下面这几个方法，可以自己试一下
        /*
         func index(after: String.Index)
         Returns the position immediately after the given index.
         
         func formIndex(after: inout String.Index)
         Replaces the given index with its successor.
         
         
         func index(before: String.Index)
         Returns the position immediately before the given index.
         
         func formIndex(before: inout String.Index)
         Replaces the given index with its predecessor.
         */
        let frontTest_before: Substring = str[str.startIndex ..< str.index(before: range.lowerBound)]
        let frontTest_after: Substring = str[str.startIndex ..< str.index(after: range.lowerBound)]
        print("before = \(frontTest_before), after = \(frontTest_after)")
        /* before = 我最, after = 我最爱北 */
        
    }
}


// MARK: -  PinYin
extension String {
    
    /// (同步的方式) 将一段汉字转为拼音全拼和拼音首字母，返回二者数组组成的二元组
    func transformToPinyin() -> (pinyinList: [String], pinyinFirstLetterList: [String]) {
        let str = String(self)
        let mStr = NSMutableString(string: str)
        
        // 转化为带声调的拼音
        CFStringTransform((mStr as CFMutableString), nil, kCFStringTransformMandarinLatin, false)
        
        // 转化为不带声调的拼音
        CFStringTransform(mStr as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
        
        // 转化为不可变字符串
        let pinyin = NSString(string: mStr) as String
        
        // 去掉拼音之间的空格
        let list = pinyin.split(key: " ")
        
        var firsts = [String]()
        for item in list {
            firsts.append(String(item.prefix(1))) 
        }
        
        return (list, firsts)
    }
    
    /// (异步的方式，主线程回调) 将一段汉字转为拼音全拼和拼音首字母，返回二者数组组成的二元组
    func transformToPinyin(async completion: ((_ pinyinList: [String], _ pinyinFirstLetterList: [String]) -> ())?) 
    {
        guard let completion = completion else { return }
        
        DispatchQueue.global().async {
            let str = String(self)
            let mStr = NSMutableString(string: str)
            
            // 转化为带声调的拼音
            CFStringTransform((mStr as CFMutableString), nil, kCFStringTransformMandarinLatin, false)
            
            // 转化为不带声调的拼音
            CFStringTransform(mStr as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
            
            // 转化为不可变字符串
            let pinyin = NSString(string: mStr) as String
            
            // 去掉拼音之间的空格
            let list = pinyin.split(key: " ")
            
            var firsts = [String]()
            for item in list {
                firsts.append(String(item.prefix(1))) 
            }
            
            DispatchQueue.main.sync {
                completion(list, firsts)
            }
        }//global  end
    }
    
}


// MARK: -  Chinese
extension String {
    
    func isChinese() -> Bool {
//        for (_, value) in string.characters.enumerated() {
//            
//            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
//                return true
//            }
//        }
        
        
        let match = "^[\u{4e00}-\u{9fa5}]+$"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        let ret = predicate.evaluate(with: self)
        
        return ret
    }
    
    func isContainsChinese() -> Bool {
        
        
        return false
    }
    
}









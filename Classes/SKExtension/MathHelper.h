//
//  MathHelper.h
//  FenxiaoMS
//
//  Created by Locke on 2017/2/4.
//  Copyright © 2017年 lainkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDecimalNumber+BigDecimal.h"
#import "NSString+GXAddition.h"

static NSDecimalNumber *ZeroDecimal;

@interface MathHelper : NSObject

/**
 提供精确的加法运算。

 @param v1 被加数
 @param v2 加数
 @return 两参数之和
 */
+ (NSDecimalNumber *)plusDoubleWithV1:(double)v1 v2:(double)v2;
/**
 提供精确的加法运算。
 
 @param v1 被加数
 @param v2 加数
 @return 两参数之和
 */
+ (NSDecimalNumber *)plusStringWithV1:(NSString *)v1 v2:(NSString *)v2;

/**
 提供精确的减法运算。

 @param v1 被减数
 @param v2 减数
 @return 两参数之差
 */
+ (NSDecimalNumber *)minusDoubleWithV1:(double)v1 v2:(double)v2;
/**
 提供精确的减法运算。
 
 @param v1 被减数
 @param v2 减数
 @return 两参数之差
 */
+ (NSDecimalNumber *)minusStringWithV1:(NSString *)v1 v2:(NSString *)v2;

/**
 提供精确的乘法运算。

 @param v1 被乘数
 @param v2 乘数
 @return 两参数之积
 */
+ (NSDecimalNumber *)multiplyDoubleWithV1:(double)v1 v2:(double)v2;
/**
 提供精确的乘法运算。
 
 @param v1 被乘数
 @param v2 乘数
 @return 两参数之积
 */
+ (NSDecimalNumber *)multiplyStringWithV1:(NSString *)v1 v2:(NSString *)v2;

/**
 提供（相对）精确的除法运算，当发生除不尽的情况时，精确到 小数点以后10位，以后的数字四舍五入。

 @param v1 被除数
 @param v2 除数
 @return 两参数之商
 */
+ (NSDecimalNumber *)divideDoubleWithV1:(double)v1 v2:(double)v2;
/**
 提供（相对）精确的除法运算，当发生除不尽的情况时，精确到 小数点以后10位，以后的数字四舍五入。
 
 @param v1 被除数
 @param v2 除数
 @return 两参数之商
 */
+ (NSDecimalNumber *)divideStringWithV1:(NSString *)v1 v2:(NSString *)v2;

/**
 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指 定精度，以后的数字四舍五入。
 
 @param v1 被除数
 @param v2 除数
 @param scale 表示表示需要精确到小数点以后几位。
 @return 两参数之商
 */
+ (NSDecimalNumber *)divideDoubleWithV1:(double)v1 v2:(double)v2 scale:(int)scale;
/**
 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指 定精度，以后的数字四舍五入。
 
 @param v1 被除数
 @param v2 除数
 @param scale 表示表示需要精确到小数点以后几位。
 @return 两参数之商
 */
+ (NSDecimalNumber *)divideStringWithV1:(NSString *)v1 v2:(NSString *)v2 scale:(int)scale;

/**
 提供精确的小数位四舍五入处理。

 @param v 需要四舍五入的数字
 @param scale 小数点后保留几位
 @return 四舍五入后的结果
 */
+ (NSDecimalNumber *)roundDoubleWithV:(double)v scale:(int)scale;
/**
 提供精确的小数位四舍五入处理。
 
 @param v 需要四舍五入的数字
 @param scale 小数点后保留几位
 @return 四舍五入后的结果
 */
+ (NSDecimalNumber *)roundStringWithV:(NSString *)v scale:(int)scale;

/**
 四舍五入,将数值格式化成四舍五入的两位小数

 @param de de description
 @return return value description
 */
+ (NSDecimalNumber *)roundDecimalNumberWithDe:(NSDecimalNumber *)de;

/**
 四舍五入,将数值格式化成四舍五入的指定小数位数

 @param de de description
 @param digts 要保留的小数位数
 @return return value description
 */
+ (NSDecimalNumber *)roundDecimalNumberWithDe:(NSDecimalNumber *)de digts:(int)digts;

/**
 获取浮点数小数部分

 @param d d description
 @return return value description
 */
+ (double)getDecimalWithDouble:(double)d;

/**
 获取浮点数小数部分

 @param b b description
 @return return value description
 */
+ (double)getDecimalWithDecimalNumber:(NSDecimalNumber *)b;

+ (int)maxWithValueA:(int)a valueB:(int)b valueC:(int)c;



/// 去掉 NSDecimalNumber 小数部分最右侧的零
+ (NSString *)stripTrailingZerosWithDeciaml:(NSDecimalNumber *)number;

/**
 去掉浮点数小数部分最右侧的零
 - 【① 10.12300 -> 10.123; ② 10.01200 -> 10.012; ③ 10.000 -> 10;】

 @param aDouble aDouble description
 @return return value description
 */
+ (NSString *)stripTrailingZeros:(double)aDouble;

///去掉浮点数小数部分最右侧的零  - 【① 10.12300 -> 10.123; ② 10.01200 -> 10.012; ③ 10.000 -> 10;】
+ (double)getDoubleStripTrailingZeros:(double)aDouble;


/**
 将double类型浮点数格式化成给定scale个小数位的字符串（原来没有小数位的, 在小数位补scale个零）
 - 例： 【decimal = 22.1; scale = 3;  ==>  return 22.100;

 @param aDouble aDouble description
 @param scale 给定小数位
 @return 返回新字符串
 */
+ (NSString *)formatDoubleString:(double)aDouble scale:(NSUInteger)scale;

/**
 将double类型浮点数格式化成给定scale个小数位的字符串（原来没有小数位的, 在小数位补scale个零）
 - 例： 【decimal = 22.1; scale = 3;  ==>  return 22.100;

 @param decimal decimal description
 @param scale 给定小数位
 @return 返回新字符串
 */
+ (NSString *)formatDecimalString:(NSDecimalNumber *)decimal scale:(NSUInteger)scale;


/**
 一个double数对一个int取模

 @param doubleNum double number
 @param another another int number
 @return double 对 int 取模之后的值
 */
+ (double)doubleNum:(double)doubleNum mode:(int)another;















@end

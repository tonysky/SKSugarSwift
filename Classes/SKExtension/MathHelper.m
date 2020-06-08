//
//  MathHelper.m
//  FenxiaoMS
//
//  Created by Locke on 2017/2/4.
//  Copyright © 2017年 lainkai. All rights reserved.
//

#import "MathHelper.h"

#define DEFAULT_DIVIDE_SCALE 10


@implementation MathHelper

+ (void)initialize {
    ZeroDecimal = [NSDecimalNumber zero];
}

/**
 提供精确的加法运算。
 
 @param v1 被加数
 @param v2 加数
 @return 两参数之和
 */
+ (NSDecimalNumber *)plusDoubleWithV1:(double)v1 v2:(double)v2 {
    NSDecimalNumber *b1 = [NSDecimalNumber dNumberWithDouble:v1];
    NSDecimalNumber *b2 = [NSDecimalNumber dNumberWithDouble:v2];
    return [b1 add:b2];
}
/**
 提供精确的加法运算。
 
 @param v1 被加数
 @param v2 加数
 @return 两参数之和
 */
+ (NSDecimalNumber *)plusStringWithV1:(NSString *)v1 v2:(NSString *)v2 {
    NSDecimalNumber *b1 = [NSDecimalNumber dNumberWithString:v1];
    NSDecimalNumber *b2 = [NSDecimalNumber dNumberWithString:v2];
    return [b1 add:b2];
}

/**
 提供精确的减法运算。
 
 @param v1 被减数
 @param v2 减数
 @return 两参数之差
 */
+ (NSDecimalNumber *)minusDoubleWithV1:(double)v1 v2:(double)v2 {
    NSDecimalNumber *b1 = [NSDecimalNumber dNumberWithDouble:v1];
    NSDecimalNumber *b2 = [NSDecimalNumber dNumberWithDouble:v2];
    return [b1 subtract:b2];
}
/**
 提供精确的减法运算。
 
 @param v1 被减数
 @param v2 减数
 @return 两参数之差
 */
+ (NSDecimalNumber *)minusStringWithV1:(NSString *)v1 v2:(NSString *)v2 {
    NSDecimalNumber *b1 = [NSDecimalNumber dNumberWithString:v1];
    NSDecimalNumber *b2 = [NSDecimalNumber dNumberWithString:v2];
    return [b1 subtract:b2];
}

/**
 提供精确的乘法运算。
 
 @param v1 被乘数
 @param v2 乘数
 @return 两参数之积
 */
+ (NSDecimalNumber *)multiplyDoubleWithV1:(double)v1 v2:(double)v2 {
    NSDecimalNumber *b1 = [NSDecimalNumber dNumberWithDouble:v1];
    NSDecimalNumber *b2 = [NSDecimalNumber dNumberWithDouble:v2];
    return [b1 multiply:b2];
}
/**
 提供精确的乘法运算。
 
 @param v1 被乘数
 @param v2 乘数
 @return 两参数之积
 */
+ (NSDecimalNumber *)multiplyStringWithV1:(NSString *)v1 v2:(NSString *)v2 {
    NSDecimalNumber *b1 = [NSDecimalNumber dNumberWithString:v1];
    NSDecimalNumber *b2 = [NSDecimalNumber dNumberWithString:v2];
    return [b1 multiply:b2];
}

/**
 提供（相对）精确的除法运算，当发生除不尽的情况时，精确到 小数点以后10位，以后的数字四舍五入。
 
 @param v1 被除数
 @param v2 除数
 @return 两参数之商
 */
+ (NSDecimalNumber *)divideDoubleWithV1:(double)v1 v2:(double)v2 {
    NSDecimalNumber *b1 = [NSDecimalNumber dNumberWithDouble:v1];
    NSDecimalNumber *b2 = [NSDecimalNumber dNumberWithDouble:v2];
    return [[b1 divide:b2] gxSetScale:DEFAULT_DIVIDE_SCALE roundingMode:NSRoundPlain];
}
/**
 提供（相对）精确的除法运算，当发生除不尽的情况时，精确到 小数点以后10位，以后的数字四舍五入。
 
 @param v1 被除数
 @param v2 除数
 @return 两参数之商
 */
+ (NSDecimalNumber *)divideStringWithV1:(NSString *)v1 v2:(NSString *)v2 {
    NSDecimalNumber *b1 = [NSDecimalNumber dNumberWithString:v1];
    NSDecimalNumber *b2 = [NSDecimalNumber dNumberWithString:v2];
    return [[b1 divide:b2] gxSetScale:DEFAULT_DIVIDE_SCALE roundingMode:NSRoundPlain];
}

/**
 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指 定精度，以后的数字四舍五入。
 
 @param v1 被除数
 @param v2 除数
 @param scale 表示表示需要精确到小数点以后几位。
 @return 两参数之商
 */
+ (NSDecimalNumber *)divideDoubleWithV1:(double)v1 v2:(double)v2 scale:(int)scale {
    if (scale < 0) {
        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"error---%s---",__func__] reason:@"The scale must be a positive integer or zero" userInfo:nil];
    }
    NSDecimalNumber *b1 = [NSDecimalNumber dNumberWithDouble:v1];
    NSDecimalNumber *b2 = [NSDecimalNumber dNumberWithDouble:v2];
    return [[b1 divide:b2] gxSetScale:scale roundingMode:NSRoundPlain];
}
/**
 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指 定精度，以后的数字四舍五入。
 
 @param v1 被除数
 @param v2 除数
 @param scale 表示表示需要精确到小数点以后几位。
 @return 两参数之商
 */
+ (NSDecimalNumber *)divideStringWithV1:(NSString *)v1 v2:(NSString *)v2 scale:(int)scale {
    if (scale < 0) {
        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"error---%s---",__func__] reason:@"The scale must be a positive integer or zero" userInfo:nil];
    }
    NSDecimalNumber *b1 = [NSDecimalNumber dNumberWithString:v1];
    NSDecimalNumber *b2 = [NSDecimalNumber dNumberWithString:v2];
    return [[b1 divide:b2] gxSetScale:scale roundingMode:NSRoundPlain];
}

/**
 提供精确的小数位四舍五入处理。
 
 @param v 需要四舍五入的数字
 @param scale 小数点后保留几位
 @return 四舍五入后的结果
 */
+ (NSDecimalNumber *)roundDoubleWithV:(double)v scale:(int)scale {
    if (scale < 0) {
        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"error---%s---",__func__] reason:@"The scale must be a positive integer or zero" userInfo:nil];
    }
    NSDecimalNumber *b = [NSDecimalNumber dNumberWithDouble:v];
    NSDecimalNumber *one = [NSDecimalNumber dNumberWithString:@"1"];
    return [[b divide:one] gxSetScale:scale roundingMode:NSRoundPlain];
}
/**
 提供精确的小数位四舍五入处理。
 
 @param v 需要四舍五入的数字
 @param scale 小数点后保留几位
 @return 四舍五入后的结果
 */
+ (NSDecimalNumber *)roundStringWithV:(NSString *)v scale:(int)scale {
    if (scale < 0) {
        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"error---%s---",__func__] reason:@"The scale must be a positive integer or zero" userInfo:nil];
    }
    NSDecimalNumber *b = [NSDecimalNumber dNumberWithString:v];
    NSDecimalNumber *one = [NSDecimalNumber dNumberWithString:@"1"];
    return [[b divide:one] gxSetScale:scale roundingMode:NSRoundPlain];
}

/**
 四舍五入,将数值格式化成四舍五入的两位小数
 
 @param de de description
 @return return value description
 */
+ (NSDecimalNumber *)roundDecimalNumberWithDe:(NSDecimalNumber *)de {
    return [de gxSetScale:2 roundingMode:NSRoundPlain];
}

/**
 四舍五入,将数值格式化成四舍五入的指定小数位数
 
 @param de de description
 @param digts 要保留的小数位数
 @return return value description
 */
+ (NSDecimalNumber *)roundDecimalNumberWithDe:(NSDecimalNumber *)de digts:(int)digts {
    if (digts < 0) {
        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"error---%s---",__func__] reason:@"The digts must be a positive integer or zero" userInfo:nil];
    }
    return [de gxSetScale:digts roundingMode:NSRoundPlain];
}

/**
 获取浮点数小数部分
 
 @param d d description
 @return return value description
 */
+ (double)getDecimalWithDouble:(double)d {
    if (d < 10000000) {
        
        NSString *replaceStr = [[NSString stringWithFormat:@"%f", d] substringWithRange:[[NSString stringWithFormat:@"%f", d] rangeOfString:@"\\d+\\." options:(NSRegularExpressionSearch)]];
        
        NSString *str = [[[NSString stringWithFormat:@"%f", d] stringByReplacingOccurrencesOfString:replaceStr withString:@"0."] stringByAppendingString:@"0"];
        
        return [self getDoubleStripTrailingZeros:[str doubleValue]];
    } else {
        NSDecimalNumber *b = [NSDecimalNumber dNumberWithDouble:d];
        return [self getDecimalWithDecimalNumber:b];
    }
}

/**
 获取浮点数小数部分
 
 @param b b description
 @return return value description
 */
+ (double)getDecimalWithDecimalNumber:(NSDecimalNumber *)b {
    NSString *str = [b stringValue];
    if ([str containsString:@"."] == false) {
        return 0;
    }//没有小数点 end
    
    NSString *replaceStr = [[NSString stringWithFormat:@"%@", b] substringWithRange:[[NSString stringWithFormat:@"%@", b] rangeOfString:@"\\d+\\." options:(NSRegularExpressionSearch)]];
    
    return [self getDoubleStripTrailingZeros:[[str replace:replaceStr withStr:@"0."] doubleValue]];
}

+ (int)maxWithValueA:(int)a valueB:(int)b valueC:(int)c  {
    return MAX(MAX(a, b),c);
}






// 去掉 NSDecimalNumber 小数部分最右侧的零
+ (NSString *)stripTrailingZerosWithDeciaml:(NSDecimalNumber *)number {
    NSString *str = [NSString stringWithFormat:@"%@", number];
    if (![str containsString:@"."]) {
        return str;
    }
    
    NSMutableString *mstr = [NSMutableString stringWithString:str];
    NSRange mRange = NSMakeRange(mstr.length - 1, 1);
    
    while ([[mstr substringWithRange:mRange] isEqualToString:@"0"]) {
        [mstr deleteCharactersInRange:mRange];
        
        mRange = NSMakeRange(mstr.length - 1, 1);
    }
    
    if ([[mstr substringWithRange:mRange] isEqualToString:@"."]) {
        [mstr deleteCharactersInRange:mRange];
    }
    
    return mstr.copy;
}

+ (NSString *)stripTrailingZeros:(double)aDouble {
    return [self stripTrailingZerosWithDeciaml:[[NSDecimalNumber alloc] initWithDouble:aDouble]];
}

+ (double)getDoubleStripTrailingZeros:(double)aDouble {
    return [self stripTrailingZeros:aDouble].doubleValue;
}


+ (NSString *)formatDoubleString:(double)aDouble scale:(NSUInteger)scale {
    return [MathHelper formatDecimalString:[[NSDecimalNumber alloc] initWithDouble:aDouble] scale:scale];
}

+ (NSString *)formatDecimalString:(NSDecimalNumber *)decimal scale:(NSUInteger)scale 
{
    NSDecimalNumber *deci = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", decimal]];
    NSString *ret = @"";
    NSString *jeStr = [MathHelper stripTrailingZerosWithDeciaml:deci];
    if ([jeStr containsString:@"."])  //包含小数位
    {
        //检测小数位数
        NSRange rangePoint = [[NSString stringWithFormat:@"%@", deci] rangeOfString:@"\\d+\\." options:(NSRegularExpressionSearch)];
        NSString *strPoint = [jeStr substringFromIndex:rangePoint.length];
        NSDecimalNumber *decimalPoint = ZeroDecimal;
        if (strPoint.length >= scale) 
        {
            decimalPoint = [deci gxSetScale:scale roundingMode:NSRoundPlain];
            ret = [NSString stringWithFormat:@"%@", decimalPoint];
        } 
        else 
        {
            NSUInteger left = scale - strPoint.length;
            NSMutableString *fmtPoint = [NSMutableString string];
            for (NSUInteger i = 0; i < left; i++) {
                [fmtPoint appendString:@"0"];
            }
            ret = [NSString stringWithFormat:@"%@%@", deci, fmtPoint.toString];
        }
        
    }
    else  //不包含小数位
    {
        NSMutableString *fmtScale = [NSMutableString string];
        for (NSUInteger i = 0; i < scale; i++) {
            [fmtScale appendString:@"0"];
        }
        
        if (scale == 0) {
            ret = [NSString stringWithFormat:@"%@", jeStr];
        } else {
            ret = [NSString stringWithFormat:@"%@.%@", jeStr, fmtScale.toString];
        }
    }
    return ret;
}


// 一个double数对一个int取模，返回double
+ (double)doubleNum:(double)doubleNum mode:(int)another {
    int temp = doubleNum / another;
    return doubleNum - temp * another;
}














@end

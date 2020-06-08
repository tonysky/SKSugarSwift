//
//  NSDecimalNumber+BigDecimal.m
//  SQLData
//
//  Created by Locke on 2017/1/16.
//  Copyright © 2017年 lainkai. All rights reserved.
//

#import "NSDecimalNumber+BigDecimal.h"



@implementation NSDecimalNumber (ToString)

- (NSString *)toString {
    NSString *str = [NSString stringWithFormat:@"%@", self];
    if ([str.lowercaseString isEqualToString:@"NaN".lowercaseString]) {
        str = @"0";
    }
    
    return str;
}

- (NSString *)toString:(short)scale;
{
    NSString *str = [self toString];
    
    NSString *pointTra = @"00";
    if ([str contains:@"."]) {
        NSArray *arr = [str componentsSeparatedByString:@"."];
        float rightF = [[NSString stringWithFormat:@"0.%@", arr.lastObject] floatValue];
        pointTra = [NSString stringWithFormat:@"%.2f", rightF];
        
        NSString *re = [NSString stringWithFormat:@"%@.%@", arr.firstObject, [pointTra componentsSeparatedByString:@"."].lastObject];
        return re;
    } 
    
    return [NSString stringWithFormat:@"%@.%@", str, pointTra];
}

@end


@implementation NSDecimalNumber (Check)

// 是否为空 - isNullOrEmpty 不合法，NaN或空 (注意：NSDecimalNumber.zero 是合法的不为空，返回false)
+ (BOOL)isNullOrEmptyDeciNum:(NSDecimalNumber *)value;
{
    if (value == nil 
        || [value isEqual:nil] 
        || value == NSDecimalNumber.notANumber
        || [value isKindOfClass:[NSNull class]] 
        || [[value class] isEqual:[NSNull null]]
        || value.doubleValue == NAN
        || [value.description.lowercaseString isEqualToString:@"NaN".lowercaseString])
    {
        return YES;
    }
    return NO;
}

// 获取非空合法的decimalNumber (注意：NSDecimalNumber.zero 是合法的不为空，做“除法”时需要自行判断)
+ (NSDecimalNumber *)getNonEmptyDeciNum:(NSDecimalNumber *)value;
{
    if ([NSDecimalNumber isNullOrEmptyDeciNum:value]) {
        return NSDecimalNumber.zero;
    }
    return value;
}



@end




@implementation NSDecimalNumber (BigDecimal)

+ (NSDecimalNumber *_Nonnull)dNumberWithString:(NSString *_Nonnull)value {
    return [self decimalNumberWithString:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithChar:(char)value {
    return (NSDecimalNumber *)[self numberWithChar:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithUnsignedChar:(unsigned char)value {
    return (NSDecimalNumber *)[self numberWithUnsignedChar:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithShort:(short)value {
    return (NSDecimalNumber *)[self numberWithShort:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithUnsignedShort:(unsigned short)value {
    return (NSDecimalNumber *)[self numberWithUnsignedShort:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithInt:(int)value {
    return (NSDecimalNumber *)[self numberWithInt:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithUnsignedInt:(unsigned int)value {
    return (NSDecimalNumber *)[self numberWithUnsignedInt:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithLong:(long)value {
    return (NSDecimalNumber *)[self numberWithLong:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithUnsignedLong:(unsigned long)value {
    return (NSDecimalNumber *)[self numberWithUnsignedLong:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithLongLong:(long long)value {
    return (NSDecimalNumber *)[self numberWithLongLong:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithUnsignedLongLong:(unsigned long long)value {
    return (NSDecimalNumber *)[self numberWithUnsignedLongLong:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithFloat:(float)value {
    return (NSDecimalNumber *)[self numberWithFloat:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithDouble:(double)value {
    return (NSDecimalNumber *)[self numberWithDouble:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithBool:(BOOL)value {
    return (NSDecimalNumber *)[self numberWithBool:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithInteger:(NSInteger)value NS_AVAILABLE(10_5, 2_0) {
    return (NSDecimalNumber *)[self numberWithInteger:value];
}
+ (NSDecimalNumber *_Nonnull)dNumberWithUnsignedInteger:(NSUInteger)value NS_AVAILABLE(10_5, 2_0) {
    return (NSDecimalNumber *)[self numberWithUnsignedInteger:value];
}



+ (NSDecimalNumber *)numberWithLKDouble:(double)value{
    return (NSDecimalNumber *)[self numberWithDouble:value];
}

/**
 加
 
 @param decimalNumber 被加数
 @return 和
 */
- (NSDecimalNumber *_Nonnull)add:(NSDecimalNumber *_Nonnull)decimalNumber {
    if (!decimalNumber || [decimalNumber.description isEqualToString:@"NaN"] || [decimalNumber isKindOfClass:[NSNull class]] || [[decimalNumber class] isEqual:[NSNull null]])
    {
        decimalNumber = NSDecimalNumber.zero;
    }
    return [self decimalNumberByAdding:decimalNumber];
}
/**
 减
 
 @param decimalNumber 被减数
 @return 差
 */
- (NSDecimalNumber *_Nonnull)subtract:(NSDecimalNumber *_Nonnull)decimalNumber {
    if (!decimalNumber || [decimalNumber.description isEqualToString:@"NaN"] || [decimalNumber isKindOfClass:[NSNull class]] || [[decimalNumber class] isEqual:[NSNull null]]) {
        return self;
    }
    return [self decimalNumberBySubtracting:decimalNumber];
}

/**
 乘
 
 @param decimalNumber 被乘数
 @return 积
 */
- (NSDecimalNumber *_Nonnull)multiply:(NSDecimalNumber *_Nonnull)decimalNumber {
    if ([decimalNumber isEqual:nil] || [decimalNumber isKindOfClass:[NSNull class]] || [decimalNumber.toString isEqualToString:@"NaN"] || decimalNumber.floatValue == NAN)
    {
        decimalNumber = [NSDecimalNumber zero];
    }
    return [self decimalNumberByMultiplyingBy:decimalNumber];
}

/**
 除
 
 @param decimalNumber 被除数
 @return 商
 */
- (NSDecimalNumber *_Nonnull)divide:(NSDecimalNumber *_Nonnull)decimalNumber {
    if ([decimalNumber isEqual:[NSDecimalNumber zero]]) {
        NSLog(@"NSDecimalNumber divide --除数不能为0！");
        return [NSDecimalNumber zero];
    }
    return [self decimalNumberByDividingBy:decimalNumber];
}

- (NSDecimalNumber *_Nonnull)divide:(NSDecimalNumber *_Nonnull)decimalNumber roundingMode:(NSRoundingMode)roundingMode
{
    return [self divide:decimalNumber scale:2 roundingMode:roundingMode];
}

- (NSDecimalNumber *_Nonnull)divide:(NSDecimalNumber *_Nonnull)decimalNumber scale:(int)scale roundingMode:(NSRoundingMode)roundingMode {
    if ([decimalNumber isEqual:[NSDecimalNumber zero]]) {
        NSLog(@"NSDecimalNumber divide --除数不能为0！");
        return [NSDecimalNumber zero];
    }
    //
    return [self decimalNumberByDividingBy:decimalNumber withBehavior:[NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:scale raiseOnExactness:0 raiseOnOverflow:0 raiseOnUnderflow:0 raiseOnDivideByZero:0]];
}

/**
 次幂
 
 @param power 次幂数
 @return 结果
 */
- (NSDecimalNumber *_Nonnull)raise:(NSUInteger)power {
    return [self decimalNumberByRaisingToPower:power];
}
/**
 乘以10的次幂
 
 @param power 10的次幂数
 @return 结果
 */
- (NSDecimalNumber *_Nonnull)multiplyOf10:(short)power {
    return [self decimalNumberByMultiplyingByPowerOf10:power];
}


#pragma mark - point

- (NSDecimalNumber *)gxSetScale:(short)scale roundingMode:(NSRoundingMode)mode {
    return [self decimalNumberByRoundingAccordingToBehavior:[NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:mode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO]];
}


/**
 绝对值

 @return 绝对值
 */
- (NSDecimalNumber *)abs {
    return [self compare:[NSDecimalNumber zero]] > 0 ? self : [self multiply:[NSDecimalNumber decimalNumberWithString:@"-1"]];
}

/**
 相反数

 @return 相反数
 */
- (NSDecimalNumber *)negate {
    return [self multiply:[NSDecimalNumber decimalNumberWithString:@"-1"]];
}


- (NSDecimalNumber *)stripTrailingZeros {
    return [NSDecimalNumber decimalNumberWithString:[self toStringStripTrailingZeros]];
}

- (NSString *)toStringStripTrailingZeros {
    if ([self compare:[NSDecimalNumber zero]] == 0) {
        return @"0";
    }
    
    return [MathHelper stripTrailingZerosWithDeciaml:self];
}

// 转为 string
- (NSString *)toPlainString {
    return [self toString];
}





@end



























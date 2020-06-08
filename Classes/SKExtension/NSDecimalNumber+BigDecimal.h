//
//  NSDecimalNumber+BigDecimal.h
//  SQLData
//
//  Created by Locke on 2017/1/16.
//  Copyright © 2017年 lainkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathHelper.h"


@interface NSDecimalNumber (ToString)

- (NSString *)toString;
- (NSString *)toString:(short)scale;



@end


@interface NSDecimalNumber (Check)

/// 是否为空 - isNullOrEmpty 不合法，NaN或空 (注意：NSDecimalNumber.zero 是合法的不为空，返回false)
+ (BOOL)isNullOrEmptyDeciNum:(NSDecimalNumber *)value;

/// 获取非空合法的decimalNumber (注意：NSDecimalNumber.zero 是合法的不为空，做“除法”时需要自行判断)
+ (NSDecimalNumber *)getNonEmptyDeciNum:(NSDecimalNumber *)value;



@end




@interface NSDecimalNumber (BigDecimal)

//系统代码注释
/****************************
1.类初始化为0 <zero>
2.类创建 <numberWith+>
3.普通初始化 <[[ alloc ] initWith+]>
4.取值 <+value>
5.比较 <compare> 返回【 NSOrderedAscending = -1L递增, NSOrderedSame相同, NSOrderedDescending递减 】
6.对比 <isEqualToNumber>  返回BOOL
****************************/

+ (NSDecimalNumber *_Nonnull)dNumberWithString:(NSString *_Nonnull)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithChar:(char)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithUnsignedChar:(unsigned char)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithShort:(short)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithUnsignedShort:(unsigned short)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithInt:(int)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithUnsignedInt:(unsigned int)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithLong:(long)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithUnsignedLong:(unsigned long)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithLongLong:(long long)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithUnsignedLongLong:(unsigned long long)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithFloat:(float)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithDouble:(double)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithBool:(BOOL)value;
+ (NSDecimalNumber *_Nonnull)dNumberWithInteger:(NSInteger)value NS_AVAILABLE(10_5, 2_0);
+ (NSDecimalNumber *_Nonnull)dNumberWithUnsignedInteger:(NSUInteger)value NS_AVAILABLE(10_5, 2_0);


/**
 double类型转NSdecimalNumber

 @param value double value
 @return NSdecimalNumber
 */
+ (NSDecimalNumber *_Nonnull)numberWithLKDouble:(double)value;

/**
 ”加“

 @param decimalNumber 被加数
 @return 和
 */
- (NSDecimalNumber *_Nonnull)add:(NSDecimalNumber *_Nonnull)decimalNumber;

/**
 ”减“

 @param decimalNumber 被减数
 @return 差
 */
- (NSDecimalNumber *_Nonnull)subtract:(NSDecimalNumber *_Nonnull)decimalNumber;

/**
 “乘”

 @param decimalNumber 被乘数
 @return 积
 */
- (NSDecimalNumber *_Nonnull)multiply:(NSDecimalNumber *_Nonnull)decimalNumber;

/**
 “除”

 @param decimalNumber 被除数
 @return 商
 */
- (NSDecimalNumber *_Nonnull)divide:(NSDecimalNumber *_Nonnull)decimalNumber;


/**
 ”除“

 @param decimalNumber 被除数 
 @param roundingMode 四舍五入模式
 @return 商
 */
- (NSDecimalNumber *_Nonnull)divide:(NSDecimalNumber *_Nonnull)decimalNumber roundingMode:(NSRoundingMode)roundingMode;

/**
 除法运算

 @param decimalNumber 被除数(除号后面的数)
 @param scale 精度（几位小数）
 @param roundingMode 四舍五入模式
 @return decimalNumber
 */
- (NSDecimalNumber *_Nonnull)divide:(NSDecimalNumber *_Nonnull)decimalNumber scale:(int)scale roundingMode:(NSRoundingMode)roundingMode;

/**
 次幂

 @param power 次幂数
 @return 结果
 */
- (NSDecimalNumber *_Nonnull)raise:(NSUInteger)power;
/**
 乘以10的次幂

 @param power 10的次幂数
 @return 结果
 */
- (NSDecimalNumber *_Nonnull)multiplyOf10:(short)power;


#pragma mark - point

/**
 舍入

 @param scale 保留小数位数
 @param mode 四舍五入模式-默认NSRoundPlain
 @return 返回保留小数并自定义 ’四舍五入‘ 后的decimalNumber
 */
- (NSDecimalNumber *_Nonnull)gxSetScale:(short)scale roundingMode:(NSRoundingMode)mode;


/**
 绝对值
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *_Nonnull abs;

/**
 相反数
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *_Nonnull negate;


/// 去掉 NSDecimalNumber 小数部分最右侧的零
- (NSDecimalNumber *_Nonnull)stripTrailingZeros;

/// 去掉 NSDecimalNumber 小数部分最右侧的零
- (NSString *_Nonnull)toStringStripTrailingZeros;

/// 转为 string 并保留 2 位小数
- (NSString *_Nonnull)toPlainString;






@end
















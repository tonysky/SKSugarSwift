//
//  TelephonyHelper.h
//  FXDAL-from-Android
//
//  Created by Locke on 2017/1/17.
//  Copyright © 2017年 liankai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCallCenter.h>



/// 设备名称的枚举类型 iPhone_6/iPhone_6Plus...
typedef NS_ENUM(NSInteger, DeviceNameType) {
    iPhone_Simulator = 0,
    
    iPhone_1G,
    iPhone_2G,
    iPhone_3G,
    iPhone_3GS,
    iPhone_4,
    iPhone_Verizon_4,
    iPhone_4S,
    iPhone_5,
    iPhone_5C,
    iPhone_5S,
    iPhone_6,
    iPhone_6Plus,
    iPhone_6S,
    iPhone_6sPlus,
    iPhone_SE,
    iPhone_7,
    iPhone_7Plus,
    iPhone_8,
    iPhone_8Plus,
    iPhone_X,
    
    iPodTouch_1G,
    iPodTouch_2G,
    iPodTouch_3G,
    iPodTouch_4G,
    iPodTouch_5G,
    iPodTouch_6G,
    
    iPad_1,
    iPad_2,
    iPad_3,
    iPad_4,
    iPad_Mini_1,
    iPad_Mini_2,
    iPad_Mini_3,
    iPad_Mini_4,
    iPad_Air,
    iPad_Air_2,
    iPad_Pro_9_7_inch,
    iPad_Pro_12_9_inch,
    iPad_5Th,
    iPad_Pro_12_9_inch_2nd,
    iPad_Pro_10_5_inch,
    
    HomePod,
    
    AppleTV_2,
    AppleTV_3,
    AppleTV_4,
    AppleTV_4K,
    
    Apple_Watch_1,
    Apple_Watch_Series_1,
    Apple_Watch_Series_2,
    Apple_Watch_Series_3,
    
    AirPods,
    
    iOtherDevice,
};


@interface TelephonyHelper : NSObject

/**
 * wifi 是否连接
 * @return Bool
 */
+ (BOOL)isWifi;

/**
 * 数据连接 否开启
 * @return Bool
 */
+ (BOOL)isDataOpen;





// !!! 是否开启飞行模式,没有实现

/**
 * 检测是否已开启飞行模式
 *
 * @return 返回true时已开启飞行模式；否则为false时未开启。
 */
+ (BOOL)isAirplaneModeOn;



/**
 * 检测网络是否可用（移动数据或WIFI）。
 *
 * @return 返回true时表示网络可用；为false时不可用。
 */
+ (BOOL)isNetworkAvailable;

/**
 * 检测移动数据网络是否可用。
 *
 * @return 返回true时表示移动网络可用；为false时不可用。
 */
+ (BOOL)isMobileNetworkAvailable;

/**
 * 检测WIFI网络是否处于工作状态。如果WIFI和移动数据同时开启，会优先使用WIFI。
 * 例如需要传输图片、文件时，需要检测处于WIFI传输状态时才能进行。
 *
 * @return 为true时表示使用WIFI；为false时没有使用。
 */
+ (BOOL)isWifiNetworkWorking;

/**
 * 获取当前的网络连接类型
 *
 * @return 0-Wifi连接，1-移动数据连接，2-网络无连接
 */
+ (int)getNetworkStatus;

/**
 * 打开网络连接。如果没有连接，则提示用户，可以自动打开网络连接设置。
 *
 * @return 网络连接状态。
 */
+ (BOOL)openNetwork;

/**
 * 盘点手机号是否是正确的手机号，这里采用比较宽泛的范式进行的检测
 * 为了防止以后有新添加的号段。
 * @param mobiles 电话号码
 * @return Bool
 */
+ (BOOL)isMobileNO:(NSString *)mobiles;


/**
 * 获取存放在keychain中的uuid
 */
+ (NSString *)getMoblieIMEI;

///**
// * 获取手机IMEI（15位），不足15位的前面补0，超过15位的截取前面15位。
// *
// * @param imei 手机IMEI。
// * @return 手机IMEI（15位），不足15位的前面补0，超过15位的截取前面15位。
// */
//+ (NSString *)getMoblieIMEI:(NSString *)imei;

+ (BOOL)isWifiEnabled;


/**
 * 获取手机号码，不一定能获取到
 */
+ (NSString *)getPhoneNumber;

/// 获取设备型号名称的枚举类型 - iPhone_X: DeviceNameType
+ (DeviceNameType)getDeviceType;

/// 获取设备名称 - @"iPhone X"
+ (NSString *)getDeviceName;



@end

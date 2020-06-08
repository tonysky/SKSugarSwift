//
//  TelephonyHelper.m
//  FXDAL-from-Android
//
//  Created by Locke on 2017/1/17.
//  Copyright © 2017年 liankai. All rights reserved.
//

#import "TelephonyHelper.h"
#import <AFNetworking/AFNetworking.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
//#import "LZKeychain.h"

static AFNetworkReachabilityManager *reachabilityManager;

static CTCallCenter *callCenter;

static CTTelephonyNetworkInfo *networkInfo;

extern NSString *CTSettingCopyMyPhoneNumber();


static BOOL isFinished = false;

@interface TelephonyHelper ()


@end

@implementation TelephonyHelper

+ (void)initialize{
    reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    callCenter = [[CTCallCenter alloc] init];
    networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        isFinished = YES;
    }];
    [reachabilityManager startMonitoring];
    
    while (!isFinished) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.0001]];
    }
}

+ (BOOL)isWifi{
//    [reachabilityManager startMonitoring];
    return [reachabilityManager isReachableViaWiFi];
}

+ (BOOL)isDataOpen{
//    [reachabilityManager startMonitoring];
    return [reachabilityManager isReachable];
}






/**
 * 检测网络是否可用（移动数据或WIFI）。
 *
 * @return 返回true时表示网络可用；为false时不可用。
 */
+ (BOOL)isNetworkAvailable{

    return [reachabilityManager isReachable];
}

/**
 * 检测移动数据网络是否可用。
 *
 * @return 返回true时表示移动网络可用；为false时不可用。
 */
+ (BOOL)isMobileNetworkAvailable{
    return [reachabilityManager isReachableViaWWAN];
}

/**
 * 检测WIFI网络是否处于工作状态。如果WIFI和移动数据同时开启，会优先使用WIFI。
 * 例如需要传输图片、文件时，需要检测处于WIFI传输状态时才能进行。
 *
 * @return 为true时表示使用WIFI；为false时没有使用。
 */
+ (BOOL)isWifiNetworkWorking{
    return [reachabilityManager isReachableViaWiFi];
}

/**
 * 获取当前的网络连接类型
 *
 * @return 0-Wifi连接，1-移动数据连接，2-网络无连接
 */
+ (int)getNetworkStatus{
//    __block int i;
//    __block BOOL isFinish = NO;
//    reachabilityManager = [AFNetworkReachabilityManager sharedManager];
//    [reachabilityManager startMonitoring];
//    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                i = 0;
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                i = 1;
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//                i = 2;
//                break;
//                
//            default:
//                break;
//        }
//        isFinish = YES;
//    }];
//    while (!isFinish) {
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
//    }
//    
//    return i;
    
    
    int i;
    if ([reachabilityManager isReachableViaWiFi]) {
        i = 0;
    } else if ([reachabilityManager isReachableViaWWAN]) {
        i = 1;
    } else {
        i = 2;
    }
    
    return i;
    
}

/**
 * 打开网络连接。如果没有连接，则提示用户，可以自动打开网络连接设置。
 *
 * @param myContext 当前Activity。
 * @return 网络连接状态。
 */
+ (BOOL)openNetwork{
    if ([reachabilityManager isReachable]) {
        return YES;
    }
    
    // 打开设置界面
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"没有可用的网络" message:@"当前没有可用的网络，请打开WIFI或手机3G网络。" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }]];
    return NO;
    
}

/**
 * 盘点手机号是否是正确的手机号，这里采用比较宽泛的范式进行的检测
 * 为了防止以后有新添加的号段。
 * @param mobiles 电话号码
 * @return
 */
+ (BOOL)isMobileNO:(NSString *)mobiles{
    mobiles = [mobiles stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobiles.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobiles];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobiles];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobiles];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}




+ (NSString *)getMoblieIMEI{
    // !!!: 苹果不允许获取手机的IMEI, 下面两个方法没有实现
    //    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor toString];
    //    a.添加框架
    //    AdSupport.framework
    //    b.添加头文件
    //#import <AdSupport/ASIdentifierManager.h>
    //    [[[ASIdentifierManager sharedManager] advertisingIdentifier] toString];
    //    return identifierForVendor;
    
    
    
    //返回的是存储在keychain中的uuid。
#warning mark - 获取不到IMEI，且限制字符数在20以内，现已‘iOS’暂时代替
    return @"iOS";
    //    return [LZKeychain getDeviceIDInKeychain];
    
}

///**
// * 获取手机IMEI（15位），不足15位的前面补0，超过15位的截取前面15位。
// *
// * @param imei 手机IMEI。
// * @return 手机IMEI（15位），不足15位的前面补0，超过15位的截取前面15位。
// */
//+ (NSString *)getMoblieIMEI:(NSString *)imei{
//    NSString *str = @"";
//    @try {
//        if ([imei isEqualToString:@""]) {
//            imei = @"000000000000000";
//        }
//        
//        if (imei.length <= 15) {
//            str = [NSString stringWithFormat:@"%@%@", [@"000000000000000" substringFromIndex:0 toIndex:15 - imei.length], imei];
//        } else {
//            str = [imei substringFromIndex:0 toIndex:15];
//        }
//    } @catch (NSException *exception) {
//        
//    } @finally {
//        
//    }
//    
//    return str;
//}




+ (BOOL)isWifiEnabled{
    return [reachabilityManager isReachableViaWiFi];
}


+ (NSString *)getPhoneNumber {

    if (CTSettingCopyMyPhoneNumber() == nil) {
        return @"";
    } else {
        return CTSettingCopyMyPhoneNumber();
    }
}


// 获取设备型号名称的枚举类型 - ‘iPhone_X’
+ (DeviceNameType)getDeviceType {
    NSString *name = [TelephonyHelper getDeviceName];
    //模拟器
    if ([name isEqualToString:@"Simulator"])         return iPhone_Simulator;
    if ([name isEqualToString:@"Simulator"])       return iPhone_Simulator;
    
    //iPod
    if ([name isEqualToString:@"iPod Touch 1G"])      return iPodTouch_1G;
    if ([name isEqualToString:@"iPod Touch 2G"])      return iPodTouch_2G;
    if ([name isEqualToString:@"iPod Touch 3G"])      return iPodTouch_3G;
    if ([name isEqualToString:@"iPod Touch 4G"])      return iPodTouch_4G;
    if ([name isEqualToString:@"iPod Touch 5G"])      return iPodTouch_5G;
    if ([name isEqualToString:@"iPod Touch 6G"])      return iPodTouch_6G;
    
    //iPad
    if ([name isEqualToString:@"iPad"])      return iPad_1;
    if ([name isEqualToString:@"iPad 2 (WiFi)"])      return iPad_2;
    if ([name isEqualToString:@"iPad 2 (GSM)"])      return iPad_2;
    if ([name isEqualToString:@"iPad 2 (CDMA)"])      return iPad_2;
    if ([name isEqualToString:@"iPad 2 (32nm)"])      return iPad_2;
    if ([name isEqualToString:@"iPad mini (WiFi)"])      return iPad_Mini_1;
    if ([name isEqualToString:@"iPad mini (GSM)"])      return iPad_Mini_1;
    if ([name isEqualToString:@"iPad mini (CDMA)"])      return iPad_Mini_1;
    
    if ([name isEqualToString:@"iPad 3(WiFi)"])      return iPad_3;
    if ([name isEqualToString:@"iPad 3(CDMA)"])      return iPad_3;
    if ([name isEqualToString:@"iPad 3(4G)"])      return iPad_3;
    if ([name isEqualToString:@"iPad 4 (WiFi)"])      return iPad_4;
    if ([name isEqualToString:@"iPad 4 (4G)"])      return iPad_4;
    if ([name isEqualToString:@"iPad 4 (CDMA)"])      return iPad_4;
    
    if ([name isEqualToString:@"iPad Air"])      return iPad_Air;
    if ([name isEqualToString:@"iPad Air"])      return iPad_Air;
    if ([name isEqualToString:@"iPad Air"])      return iPad_Air;
    if ([name isEqualToString:@"iPad mini 2"])      return iPad_Mini_2;
    
    if ([name isEqualToString:@"iPad mini 3"])      return iPad_Mini_3;
    
    if ([name isEqualToString:@"iPad mini 4"])      return iPad_Mini_4;
    
    if ([name isEqualToString:@"iPad Air 2"])      return iPad_Air_2;
    if ([name isEqualToString:@"iPad Air 2"])      return iPad_Air_2;
    
    if ([name isEqualToString:@"iPad Pro 9.7-inch"])      return iPad_Pro_9_7_inch;
    if ([name isEqualToString:@"iPad Pro 12.9-inch"])      return iPad_Pro_12_9_inch;
    if ([name isEqualToString:@"iPad 5Th"])      return iPad_5Th;//五代
    
    if ([name isEqualToString:@"iPad Pro 12.9-inch 2nd"])      return iPad_Pro_12_9_inch_2nd;
    if ([name isEqualToString:@"iPad Pro 10.5-inch"])      return iPad_Pro_10_5_inch;
    
    //AirPods
    if ([name isEqualToString:@"AirPods"])      return AirPods;
    
    //Apple TV
    if ([name isEqualToString:@"AppleTV 2"])      return AppleTV_2;
    if ([name isEqualToString:@"AppleTV 3"])      return AppleTV_3;
    if ([name isEqualToString:@"AppleTV 4"])      return AppleTV_4;
    if ([name isEqualToString:@"AppleTV 4K"])      return AppleTV_4K;
    
    //Apple Watch
    if ([name isEqualToString:@"Apple Watch1"])      return Apple_Watch_1;
    if ([name isEqualToString:@"Apple Watch Series 1"])      return Apple_Watch_Series_1;
    if ([name isEqualToString:@"Apple Watch Series 2"])      return Apple_Watch_Series_2;
    if ([name isEqualToString:@"Apple Watch Series 3"])      return Apple_Watch_Series_3;
    
    //HomePod
    if ([name isEqualToString:@"HomePod"])      return HomePod;
    
    
    //iPhone
    if ([name isEqualToString:@"iPhone 1G"])    return iPhone_1G;
    if ([name isEqualToString:@"iPhone 3G"])    return iPhone_3G;
    if ([name isEqualToString:@"iPhone 3GS"])    return iPhone_3GS;
    if ([name isEqualToString:@"iPhone 4"])    return iPhone_4;
    if ([name isEqualToString:@"Verizon iPhone 4"])    return iPhone_Verizon_4;
    if ([name isEqualToString:@"iPhone 4S"])    return iPhone_4S;
    if ([name isEqualToString:@"iPhone 5"])    return iPhone_5;
    if ([name isEqualToString:@"iPhone 5C"])    return iPhone_5C;
    if ([name isEqualToString:@"iPhone 5S"])    return iPhone_5S;
    if ([name isEqualToString:@"iPhone 6 Plus"])    return iPhone_6Plus;
    if ([name isEqualToString:@"iPhone 6"])    return iPhone_6;
    if ([name isEqualToString:@"iPhone 6s"])    return iPhone_6S;
    if ([name isEqualToString:@"iPhone 6s Plus"])    return iPhone_6sPlus;
    if ([name isEqualToString:@"iPhone SE"])    return iPhone_SE;
    if ([name isEqualToString:@"iPhone 7"])    return iPhone_7;
    if ([name isEqualToString:@"iPhone 7 Plus"])    return iPhone_7Plus;
    if ([name isEqualToString:@"iPhone 8"])    return iPhone_8;
    if ([name isEqualToString:@"iPhone 8 Plus"])    return iPhone_8Plus;
    if ([name isEqualToString:@"iPhone X"])    return iPhone_X;
    
    return iOtherDevice;
}

+ (NSString *)getDeviceName {
    return [self _deviceName];
}

+ (NSString *)_deviceName {
    
//    需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    //模拟器
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([deviceString isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    if ([deviceString isEqualToString:@"iPad5,1"]
        || [deviceString isEqualToString:@"iPad5,2"])      return @"iPad mini 4";
    
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([deviceString isEqualToString:@"iPad6,3"]
        || [deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch";
    if ([deviceString isEqualToString:@"iPad6,7"]
        || [deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch";
    if ([deviceString isEqualToString:@"iPad6,11"]
        || [deviceString isEqualToString:@"iPad6,12"])      return @"iPad 5Th";//五代
    
    if ([deviceString isEqualToString:@"iPad7,1"]
        || [deviceString isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9-inch 2nd";
    if ([deviceString isEqualToString:@"iPad7,3"]
        || [deviceString isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5-inch";
    
    //AirPods
    if ([deviceString isEqualToString:@"AirPods1,1"])      return @"AirPods";
    
    //Apple TV
    if ([deviceString isEqualToString:@"AppleTV2,1"])      return @"AppleTV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"]
        ||[deviceString isEqualToString:@"AppleTV3,2"])      return @"AppleTV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])      return @"AppleTV 4";
    if ([deviceString isEqualToString:@"AppleTV6,2"])      return @"AppleTV 4K";
    
    //Apple Watch
    if ([deviceString isEqualToString:@"Watch1,1"]
        ||[deviceString isEqualToString:@"Watch1,2"])      return @"Apple Watch1";
    if ([deviceString isEqualToString:@"Watch2,6"]
        ||[deviceString isEqualToString:@"Watch2,7"])      return @"Apple Watch Series 1";
    if ([deviceString isEqualToString:@"Watch2,3"]
        ||[deviceString isEqualToString:@"Watch2,4"])      return @"Apple Watch Series 2";
    if ([deviceString isEqualToString:@"Watch3,1"]
        ||[deviceString isEqualToString:@"Watch3,2"]
        ||[deviceString isEqualToString:@"Watch3,3"]
        ||[deviceString isEqualToString:@"Watch3,4"])      return @"Apple Watch Series 3";
    
    //HomePod
    if ([deviceString isEqualToString:@"AudioAccessory1,1"])      return @"HomePod";
    
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"]
        || [deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"]
        || [deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"]
        || [deviceString isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"]
        || [deviceString isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"]
        || [deviceString isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    
    return deviceString;
    
}










@end










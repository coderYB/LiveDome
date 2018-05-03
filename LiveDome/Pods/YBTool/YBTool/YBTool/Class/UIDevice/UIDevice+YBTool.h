//
//  UIDevice+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/12.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, NetworkType) {
    NetworkTypeUnknown = -1, //
    NetworkType2G = 0,
    NetworkType3G,
    NetworkType4G,
    NetworkTypeWifi,
    NetworkTypeLTE
};
@interface UIDevice (YBTool)

/**
 屏幕宽度

 @return <#return value description#>
 */
+ (CGFloat)getDeviceScreenWidth;

/**
 屏幕高度

 @return <#return value description#>
 */
+ (CGFloat)getDeviceScreenHeight;


/**
 设备的名称

 @return <#return value description#>
 */
+ (NSString *)getDeviceName;


/**
 设备类型

 @return <#return value description#>
 */
+ (NSString *)getDeviceTypeName;



/**
 获取BundleID

 @return <#return value description#>
 */
+ (NSString*)getBundleID;


/**
 app版本号

 @return <#return value description#>
 */
+ (NSString *)getAPPVerion;


/**
 app_build版本号

 @return <#return value description#>
 */
+ (NSString *)getAPPBuildVersion;


/**
 app名字

 @return <#return value description#>
 */
+ (NSString *)getAPPName;


/**
 设备UUID

 @return <#return value description#>
 */
+ (NSString *)getiPhoneUUID;


/**
 设备系统版本

 @return <#return value description#>
 */
+ (NSString *)getSystemVersion;


/**
 获取电池剩余电量

 @return <#return value description#>
 */
+ (CGFloat)getBatteryLevel;


/**
 获取手机IP

 @return <#return value description#>
 */
+ (NSString *)getDeviceIPAdress;


/**
 获取总内存大小(单位：字节 B)

 @return <#return value description#>
 */
+ (long long)getTotalMemorySize;


/**
 获取当前可用内存(单位：字节 B)

 @return <#return value description#>
 */
+ (long long)getAvailableMemorySize;


/**
 获取总磁盘容量(单位：字节 B)

 @return <#return value description#>
 */
+ (long long)getTotalDiskSize;


/**
 获取可用磁盘容量(单位：字节 B)

 @return <#return value description#>
 */
+ (long long)getAvailableDiskSize;


/**
 获取精准电池电量

 @return <#return value description#>
 */
+ (CGFloat)getCurrentBatteryLevel;


/**
 获取当前语言

 @return <#return value description#>
 */
+ (NSString *)getDeviceLanguage;


/**
 获取运营商名称

 @return <#return value description#>
 */
+ (NSString *)getCarrierName;


/**
 获取网络类型(确保statusbar没有隐藏，否则获取不到）

 @return <#return value description#>
 */
+ (NetworkType)getNetworkType;


/**
 获取网络类型名称(确保statusbar没有隐藏，否则获取不到）

 @return <#return value description#>
 */
+ (NSString *)getNetworkTypeName;

@end

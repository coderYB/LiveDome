//
//  UIApplication+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/12.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, YBPrefsType) {
    YBPrefsSystemSetting = 0,   //系统设置页面
    YBPrefsWiFi,                //无限局域网
    YBPrefsBluetooth,           //蓝牙
    YBPrefsMobileData,          //蜂窝移动网络
    YBPrefsInternetTethering,   //个人热点
    YBPrefsCarrier,             //运营商
    YBPrefsNotification,        //通知
    YBPrefsGeneral,             //通用
    YBPrefsAbout,               //通用-关于本机
    YBPrefsKeyboard,            //通用-键盘
    YBPrefsAccessibility,       //通用-辅助功能
    YBPrefsInternational,       //通用-语言与地区
    YBPrefsWallpaper,           //墙纸
    YBPrefsSiri,                //Siri
    YBPrefsPrivacy,             //隐私
    YBPrefsSafari,              //Safari
    YBPrefsMusic,               //音乐
    YBPrefsPhotos,              //照片与相机
    YBPrefsFaceTime             //FaceTime
};

@interface UIApplication (YBTool)

/**
 应用程序之间跳转(如调起电话：tel://1234567890 )

 @param urlString <#urlString description#>
 */
+ (void)quickOpenURLString:(NSString *)urlString;


/**
 跳转到app设置页面
 */
+ (void)goToAppSetting;


/**
 拨打电话

 @param telephone <#telephone description#>
 */
+ (void)goToTelephone:(NSString *)telephone;


/**
 跳转系统设置中相关功能的设置

 @param prefsType <#prefsType description#>
 */
+ (void)goToSettingWith:(YBPrefsType)prefsType;


@end

//
//  UIApplication+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/12.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "UIApplication+YBTool.h"

@implementation UIApplication (YBTool)

/**
 应用程序之间跳转

 @param urlString <#urlString description#>
 */
+ (void)quickOpenURLString:(NSString *)urlString{
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:urlString];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}


/**
 跳转到app设置页面
 */
+ (void)goToAppSetting{
    [UIApplication quickOpenURLString:UIApplicationOpenSettingsURLString];
}

/**
 拨打电话

 @param telephone <#telephone description#>
 */
+ (void)goToTelephone:(NSString *)telephone{
    NSString *urlString = [@"tel://" stringByAppendingString:telephone];
    [UIApplication quickOpenURLString:urlString];
}

/**
 跳转系统设置中相关功能的设置

 @param prefsType <#prefsType description#>
 */
+ (void)goToSettingWith:(YBPrefsType)prefsType{
    NSArray *rootPaths  =  @[@"App-Prefs:root",
                             @"App-Prefs:root=WIFI",
                             @"App-Prefs:root=Bluetooth",
                             @"App-Prefs:root=MOBILE_DATA_SETTINGS_ID",
                             @"App-Prefs:root=INTERNET_TETHERING",
                             @"App-Prefs:root=Carrier",
                             @"App-Prefs:root=NOTIFICATIONS_ID",
                             @"App-Prefs:root=General",
                             @"App-Prefs:root=General&path=About",
                             @"App-Prefs:root=General&path=Keyboard",
                             @"App-Prefs:root=General&path=ACCESSIBILITY",
                             @"App-Prefs:root=General&path=INTERNATIONAL",
                             @"App-Prefs:root=Wallpaper",
                             @"App-Prefs:root=SIRI",
                             @"App-Prefs:root=Privacy",
                             @"App-Prefs:root=SAFARI",
                             @"App-Prefs:root=MUSIC",
                             @"App-Prefs:root=Photos",
                             @"App-Prefs:root=FACETIME"];
    
    NSString *urlString = [rootPaths objectAtIndex:(NSUInteger)prefsType];
    [UIApplication quickOpenURLString:urlString];
}
@end

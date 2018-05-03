//
//  UIWindow+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/12.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "UIWindow+YBTool.h"

@implementation UIWindow (YBTool)

/**
 获取当前屏幕中present出来的viewcontroller

 @return <#return value description#>
 */
+ (UIViewController *)getCurrentPresentedVC{
    
    UIWindow *keywindow = [[[UIApplication sharedApplication] delegate] window];
    UIViewController *topVC = keywindow.rootViewController;
    
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

/**
 获取当前屏幕显示的viewcontroller

 @return <#return value description#>
 */
+ (UIViewController *)getCurrentVC{
    UIViewController *currentViewController = [UIWindow getCurrentPresentedVC];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]]
           && [(UINavigationController *) currentViewController topViewController]) {
        
        currentViewController = [(UINavigationController *) currentViewController topViewController];
    }
    
    return currentViewController;
    
}

@end

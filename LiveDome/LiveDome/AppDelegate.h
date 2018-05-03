//
//  AppDelegate.h
//  LiveDome
//
//  Created by zbwx on 2018/5/2.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RootTabbarViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *rootNavTabbar;
@property (strong, nonatomic) RootTabbarViewController *rootTabBarController;

/**
 当前app显示的ViewController
 */
@property (strong, nonatomic) UIViewController *currentViewController;
@end


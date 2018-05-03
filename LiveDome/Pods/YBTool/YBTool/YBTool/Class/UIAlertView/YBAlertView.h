//
//  YBAlertView.h
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

#define ALERT [YBAlertView shareAlert]
@interface YBAlertView : NSObject<MBProgressHUDDelegate>

@property (nonatomic,strong) MBProgressHUD *HUD;
+ (YBAlertView *)shareAlert;
/**
 *  加载等待
 *
 *  @param title   标题
 *  @param message 子标题
 *  @param view    所在视图
 */
- (void)showLodingWithTitle:(NSString*)title message:(NSString*)message withView:(UIView *)view;
/**
 *  加载等待
 *
 *  @param title 标题
 *  @param view  所在视图
 */
-(void)showLoadingWithTitle:(NSString*)title withView:(UIView*)view;
/**
 *  加载等待
 *
 *  @param view <#view description#>
 */
-(void)showLoadingWithView:(UIView*)view;

- (void)hiddenHUD;

- (void)showMessage:(NSString*)message;
- (void)showMessage:(NSString*)message time:(NSInteger)time;




@end

//
//  YBAlertView.m
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "YBAlertView.h"
#import "YBUtils.h"
#import "UILabel+YBTool.h"
#import "UIView+YBTool.h"
static YBAlertView *defaultAlert = nil;
@implementation YBAlertView
+ (YBAlertView *)shareAlert{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultAlert = [[YBAlertView alloc] init];
    });
    return defaultAlert;
}

/**
 *  加载等待
 *
 *  @param title   标题
 *  @param message 子标题
 *  @param view    所在视图
 */
- (void)showLodingWithTitle:(NSString*)title message:(NSString*)message withView:(UIView *)view{
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!view) {
            self.HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] delegate].window];
            [[[UIApplication sharedApplication] delegate].window addSubview:self.HUD];
        }else{
            if (self.HUD) {
                [self.HUD hideAnimated:YES];
            }
            self.HUD = [[MBProgressHUD alloc] initWithView:view];
            [view addSubview:self.HUD];
        }
        self.HUD.delegate = self;
        self.HUD.label.text = title;
        self.HUD.detailsLabel.text = message;
        self.HUD.square = YES;
        [self.HUD showAnimated:YES];
    });
}
/**
 *  加载等待
 *
 *  @param title 标题
 *  @param view  所在视图
 */
-(void)showLoadingWithTitle:(NSString*)title withView:(UIView*)view{
    [self showLodingWithTitle:title message:nil withView:view];
}

/**
 *  加载等待
 *
 *  @param view <#view description#>
 */
-(void)showLoadingWithView:(UIView*)view{
    [self showLodingWithTitle:nil message:nil withView:view];
}

- (void)hiddenHUD{
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.HUD) {
            [self.HUD hideAnimated:YES];
        }
    });
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [self.HUD removeFromSuperview];
    self.HUD = nil;
}

- (void)showMessage:(NSString*)message{
    if (message == nil||message.length == 0) {
        return;
    }
    [self showMessage:message time:1];
}

- (void)showMessage:(NSString*)message time:(NSInteger)time{
    //移除上次的
    for (UIView *view in [[UIApplication sharedApplication].keyWindow subviews]) {
        if (view.tag == 10000) {
            [view removeFromSuperview];
        }
    }
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *mianView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].delegate.window.bounds];
        [mianView setTag:10000];
        UIView *contentView = [[UIView alloc] init];
        [contentView.layer setMasksToBounds:YES];
        [contentView.layer setCornerRadius:5.0];
        [contentView setBackgroundColor:[UIColor clearColor]];
        [mianView addSubview:contentView];
        
        UIView *blackBackView = [[UIView alloc] init];
        [blackBackView setBackgroundColor:[UIColor blackColor]];
        [blackBackView setAlpha:0.7];
        [contentView addSubview:blackBackView];
        
        UILabel *messageLabel = [[UILabel alloc] init];
        [messageLabel setTextColor:[UIColor whiteColor]];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        [messageLabel setTextAlignment:NSTextAlignmentCenter];
        [messageLabel setFont:[UIFont systemFontOfSize:14]];
        [messageLabel setText:message];
        [contentView addSubview:messageLabel];
        
        [messageLabel setWidth:messageLabel.textWidth];
        [messageLabel setHeight:messageLabel.textHeight];
        
        [contentView setWidth:messageLabel.textWidth+25];
        [contentView setHeight:messageLabel.textHeight+15];
        [contentView setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)];
        [blackBackView setFrame:contentView.bounds];
        [messageLabel setCenter:CGPointMake(contentView.frame.size.width/2, contentView.frame.size.height/2)];
        
        [[UIApplication sharedApplication].delegate.window addSubview:mianView];
        
        [UIView animateWithDuration:0.2 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeScale(1.1, 1.1);
            [contentView setTransform:transform];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 1.0);
                [contentView setTransform:transform];
            } completion:^(BOOL finished) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:0.2 animations:^{
                        CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.5);
                        [contentView setTransform:transform];
                        [contentView setAlpha:0];
                    } completion:^(BOOL finished) {
                        [mianView removeFromSuperview];
                    }];
                });
            }];
        }];
    });
}

@end

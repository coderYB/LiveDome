//
//  BaseViewController.h
//  LiveDome
//
//  Created by zbwx on 2018/5/2.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/**
 *  返回按钮Item
 */
@property(nonatomic,strong) UIBarButtonItem *backBarButtonItem;
/**
 *  返回按钮
 */
@property(nonatomic,strong) UIButton *backButton;

/**
 页面名称
 */
@property(nonatomic,strong) NSString *pageTrueName;

/**
 *  返回事件
 *
 *  @param touchButton <#touchButton description#>
 */
-(void)backAction:(UIButton*)touchButton;
@end

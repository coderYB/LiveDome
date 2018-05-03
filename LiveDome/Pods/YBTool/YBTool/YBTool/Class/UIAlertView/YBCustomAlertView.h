//
//  YBCustomeAlertView.h
//  YBTool
//
//  Created by zbwx on 2018/4/12.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBCustomAlertView : UIView
typedef void(^CustomAlertBlock)( YBCustomAlertView * _Nonnull customAlertView ,NSInteger index);
@property(nonatomic,copy) _Nonnull CustomAlertBlock block;

+(void)initWithTitle:(nullable NSString*)title message:(nullable NSString*)message contentView:(nullable UIView*)contentView confirmButtonTitle:(nullable NSString*)confirmButtonTitle cancleButtonTitle:(nullable NSString*)cancleButtonTitle alertBlock:(nullable CustomAlertBlock)alertBlock otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
@end

//
//  UIImageView+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^LBBlurredImageCompletionBlock)(void);

extern CGFloat const kLBBlurredImageDefaultBlurRadius;
@interface UIImageView (YBTool)
/**
 *  外层封装sdwebimage 外加圆角需求
 *
 *  @param urlStr         ·····
 *  @param placeHolderStr ·····
 *  @param radius         ·····
 */
- (void)yb_loadImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius;
- (void)yb_loadImageUrlStr:(NSString *)urlStr radius:(CGFloat)radius;
- (void)yb_loadImageUrlStr:(NSString *)urlStr;
- (void)yb_loadImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr;
/**
 *  加载图片  但是全局控制  关闭省流量
 *
 *  @param urlStr         url
 *  @param placeHolderStr 占位图
 */
- (void)kkloadImageButControlUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr;
- (void)kkloadImageButControlUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius;

@end

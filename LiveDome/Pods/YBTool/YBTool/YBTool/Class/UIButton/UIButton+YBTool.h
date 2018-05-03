//
//  UIButton+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YBTool)
/**
 *  快捷创建btn
 *
 */
+ (UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color withBlock:(void(^)(id sender))block;
+ (UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color normalImage:(UIImage *)image withBlock:(void(^)(id sender))block;
+ (UIButton *)buttonWithNormalTitle:(NSString *)title selectedTitle:(NSString *)selectedtitle font:(UIFont *)font NormaltitleColor:(UIColor *)color selectedTitleColor:(UIColor *)selectedColor normalImage:(UIImage *)image selectedImage:(UIImage *)selectedImage withBlock:(void(^)(id sender))block;
/**
 *  设置btn
 *
 */
- (void)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color withBlock:(void(^)(id sender))block;
- (void)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color normalImage:(UIImage *)image withBlock:(void(^)(id sender))block;
- (void)buttonWithNormalTitle:(NSString *)title selectedTitle:(NSString *)selectedtitle font:(UIFont *)font NormaltitleColor:(UIColor *)color selectedTitleColor:(UIColor *)selectedColor normalImage:(UIImage *)image selectedImage:(UIImage *)selectedImage withBlock:(void(^)(id sender))block;

/**
 设置Normal下的图片
 
 @param image 图片
 */
- (void)setNormalImage:(UIImage *)image;

/**
 设置hlighted]下的图片
 
 @param image 图片
 */
- (void)setHighlightedImage:(UIImage *)image;

/**
 设置Selected下的图片
 
 @param image 图片
 */
- (void)setSelectedImage:(UIImage *)image;

/**
 设置Normal下的图片
 
 @param name 图片名
 */
- (void)setNormalImageName:(NSString *)name;

/**
 设置hlighted]下的图片
 
 @param name 图片名
 */
- (void)setHighlightedImageName:(NSString *)name;

/**
 设置Selected下的图片
 
 @param name 图片名
 */
- (void)setSelectedImageName:(NSString *)name;

/**
 设置Normal下的背景图片
 @param image 图片
 */
-(void)setNormalBackgroundImage:(UIImage*)image;

/**
 设置hlighted]下的背景图片
 @param image 图片
 */
-(void)setHighlightedBackgroundImage:(UIImage*)image;

/**
 设置Selected下的背景图片
 @param image 图片
 */
-(void)setSelectedBackgroundImage:(UIImage*)image;

/**
 设置Normal下的背景图片
 @param name 图片名
 */
-(void)setNormalBackgroundImageName:(NSString*)name;

/**
 设置Highlighted下的背景图片
 @param name 图片名
 */
-(void)setHighlightedBackgroundImageName:(NSString*)name;

/**
 设置Selected下的背景图片
 @param name 图片名
 */
-(void)setSelectedBackgroundImageName:(NSString*)name;

/**
 设置Normal下的Title
 
 @param title <#title description#>
 */
-(void)setNormalTitle:(NSString*)title;

/**
 设置Highlighted下的Title
 
 @param title <#title description#>
 */
-(void)setHighlightedTitle:(NSString*)title;

/**
 设置Selected下的Title
 
 @param title <#title description#>
 */
-(void)setSelectedTitle:(NSString*)title;

/**
 设置Normal下的Title Color
 
 @param color <#color description#>
 */
-(void)setNormalTitleColor:(UIColor *)color;

/**
 设置Highlighted下的Title Color
 
 @param color <#color description#>
 */
-(void)setHighlightedTitleColor:(UIColor *)color;

/**
 设置Selected下的Title Color
 
 @param color <#color description#>
 */
-(void)setSelectedTitleColor:(UIColor *)color;
/**
 创建便捷的通用点击事件
 
 @param controlEvent button事件
 @param handler 回调block
 */
-(void)handlerControlEvent:(UIControlEvents)controlEvent handler:(void (^)(id sender))handler;

/**
 创建最常用的TouchUpInside点击
 
 @param handler 回调block
 */
-(void)handlerTouchUpInsideEvent:(void (^)(id sender))handler;

/**
 移除target
 
 @param event <#event description#>
 */
-(void)removeTargetWithEvent:(UIControlEvents)event;

/**
 *  设置不同状态背景颜色
 *
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
@end

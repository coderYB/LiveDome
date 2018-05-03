//
//  UIColor+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>
// 颜色RBG
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
//颜色RBGA
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface UIColor (YBTool)
/**
 *  16进制颜色转RGB
 *
 *  @param hexValue   色值
 *  @param alphaValue 透明度
 *
 *  @return <#return value description#>
 */
+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

/**
 *   16进制颜色转RGB
 *
 *  @param hexValue 色值
 *
 *  @return <#return value description#>
 */
+ (UIColor*) colorWithHex:(NSInteger)hexValue;

/**
 *  RGB转16进制颜色
 *
 *  @param color RGB颜色
 *
 *  @return 16进制颜色字符串
 */
+ (NSString *) hexFromUIColor: (UIColor*) color;

/**
 根据html对应的色值(可以设置透明度) 生成颜色类 如：#000000

 @param hexString <#hexString description#>
 @param alpha <#alpha description#>
 @return <#return value description#>
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString
                          alpha:(float)alpha;


/**
 随机颜色

 @return <#return value description#>
 */
+ (UIColor *)getRandomColor;

/**
 随机颜色(透明度)

 @param alpha <#alpha description#>
 @return <#return value description#>
 */
+ (UIColor *)getRandomColorWithAlpha:(float)alpha;


/**
 渐变颜色(开始颜色，结束颜色，渐变高度)

 @param c1 <#c1 description#>
 @param c2 <#c2 description#>
 @param height <#height description#>
 @return <#return value description#>
 */
+ (UIColor *)getGradientColorFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;
@end

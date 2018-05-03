//
//  UILabel+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YBTool)
/**
 固定宽度计算文字高度
 
 @return <#return value description#>
 */
-(CGFloat)textHeight;

/**
 固定高度计算文字宽度
 
 @return <#return value description#>
 */
-(CGFloat)textWidth;

/**
 *  创建Label
 *
 */
+ (UILabel *)labelWithTitle:(NSString *)title textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font color:(UIColor*)color;
-(void)labelWithTitle:(NSString *)title textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font color:(UIColor*)color;
/**
 *  加某一个字符串的某个字符的字间距
 *
 *  @param substr 摸个字符
 *  @param number 间距
 *
 *  @return <#return value description#>
 */

- (void)addKernAttributeForSubStr:(NSString *)substr  value:(int)number;
@end

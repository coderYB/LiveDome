//
//  UILabel+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "UILabel+YBTool.h"
#import "YBUtils.h"
#import "UIView+YBTool.h"
@implementation UILabel (YBTool)
/**
 固定宽度计算文字高度
 
 @return <#return value description#>
 */
-(CGFloat)textHeight{
    return [YBUtils textHeight:self.text font:self.font width:self.width];
}

/**
 固定高度计算文字宽度
 
 @return <#return value description#>
 */
-(CGFloat)textWidth{
    return [YBUtils textWidth:self.text font:self.font height:self.height];
}
+ (UILabel *)labelWithTitle:(NSString *)title textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font color:(UIColor*)color{
    UILabel * label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.font = font;
    return label;
}
-(void)labelWithTitle:(NSString *)title textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font color:(UIColor*)color{
    self.text = title;
    self.textColor = color;
    self.textAlignment = textAlignment;
    self.font = font;
}

/**
 加某一个字符串的某个字符的字间距
 
 @param substr 摸个字符
 @param number 间距
 */
- (void)addKernAttributeForSubStr:(NSString *)substr  value:(int)number{
    NSMutableAttributedString * attrString= [self.attributedText mutableCopy];
    NSRegularExpression *urlRegex = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@".%@",substr] options:NSRegularExpressionCaseInsensitive error:nil];
    [urlRegex enumerateMatchesInString:self.text options:0 range:NSMakeRange(0, [self.text length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        NSRange range = result.range;
        [attrString addAttribute:NSKernAttributeName value:@(number) range:range ];
    }];
    self.attributedText = attrString;
}
@end

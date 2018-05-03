//
//  UINavigationBar+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (YBTool)
//修改导航条透明度
- (void)yb_setBackgroundColor:(UIColor *)backgroundColor;
- (void)yb_setTranslationY:(CGFloat)translationY;
- (void)yb_setElementsAlpha:(CGFloat)alpha;
@end

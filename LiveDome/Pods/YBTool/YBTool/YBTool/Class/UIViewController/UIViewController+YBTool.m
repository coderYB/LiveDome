//
//  UIViewController+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "UIViewController+YBTool.h"
#import "UIColor+YBTool.h"
#import "UIView+YBTool.h"
const static int barItemFont = 14;
const static int titleFont = 18;
@implementation UIViewController (YBTool)
/**
 *  添加导航按钮
 *
 *  @param image          常态图片  可以不传  为nil
 *  @param highlightImage 高亮图片  可以不传  为nil
 *  @param title          title    可以不传  为nil
 *  @param isLeft         左边或是右边  Yes为左
 *  @param selector       触发函数
 */
- (UIButton * )addNavBtnNormalImage:(NSString *)image HighlightedImage:(NSString *)highlightImage TItle:(NSString*)title Isleft:(BOOL) isLeft Selector:(SEL)selector{
    UIImage *image1 =[UIImage imageNamed:image?:@"aaaaaaa"];
    UIImage *image2 =[UIImage imageNamed:highlightImage?:@"aaaaaaa"];
    UIButton *sbtn = [[UIButton alloc] init];
    [sbtn setImage:image1  forState:UIControlStateNormal];
    [sbtn setImage:image2  forState:UIControlStateHighlighted];
    [sbtn setTitle:title forState:UIControlStateNormal];
    [sbtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    sbtn.titleLabel.font = [UIFont systemFontOfSize:barItemFont];
    [sbtn sizeToFit];
    [sbtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *Item = [[UIBarButtonItem alloc] initWithCustomView:sbtn];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = Item;
        
    }
    else{
        self.navigationItem.rightBarButtonItem = Item;
    }
    return sbtn;
}

- (UIButton *)addNavBtnWithTitle:(NSString*)title Isleft:(BOOL) isLeft Selector:(SEL)selector{
    return [self addNavBtnNormalImage:nil HighlightedImage:nil TItle:title Isleft:isLeft Selector:selector];
}

- (UIButton * )addNavBtnNormalImage:(NSString *)image HighlightedImage:(NSString *)highlightImage Isleft:(BOOL) isLeft Selector:(SEL)selector{
    return [self addNavBtnNormalImage:image HighlightedImage:highlightImage TItle:nil Isleft:isLeft Selector:selector];
}
//处理初始高度
-(void)dealViewHeight{
    float viewHeight = ([[UIScreen mainScreen] bounds]).size.height-20;
    if (self.navigationController&&self.navigationController.navigationBarHidden==NO) {
        viewHeight -= self.navigationController.navigationBar.height;
    }
    if (self.tabBarController&&self.tabBarController.tabBar.hidden==NO) {
        viewHeight -= self.tabBarController.tabBar.height;
    }
    self.view.height = viewHeight;
    
}
@end

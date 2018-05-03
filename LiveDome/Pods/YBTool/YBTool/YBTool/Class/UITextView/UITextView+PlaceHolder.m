//
//  UITextView+PlaceHolder.m
//  StockProject
//
//  Created by zbwx on 2018/2/22.
//  Copyright © 2018年 ZBWX. All rights reserved.
//

#import "UITextView+PlaceHolder.h"
#import <objc/runtime.h>
static const void *yb_placeHolderKey;
@interface UITextView ()
@property (nonatomic, readonly) UILabel *yb_placeHolderLabel;
@end

@implementation UITextView (PlaceHolder)
+(void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(zbPlaceHolder_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(zbPlaceHolder_swizzled_dealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(zbPlaceHolder_swizzled_setText:)));
}
#pragma mark - swizzled
- (void)zbPlaceHolder_swizzled_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self zbPlaceHolder_swizzled_dealloc];
}
- (void)zbPlaceHolder_swizzling_layoutSubviews {
    if (self.yb_placeHolder) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.yb_placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.yb_placeHolderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self zbPlaceHolder_swizzling_layoutSubviews];
}
- (void)zbPlaceHolder_swizzled_setText:(NSString *)text{
    [self zbPlaceHolder_swizzled_setText:text];
    if (self.yb_placeHolder) {
        [self updatePlaceHolder];
    }
}
#pragma mark - associated
-(NSString *)yb_placeHolder{
    return objc_getAssociatedObject(self, &yb_placeHolderKey);
}
-(void)setyb_placeHolder:(NSString *)yb_placeHolder{
    objc_setAssociatedObject(self, &yb_placeHolderKey, yb_placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}
-(UIColor *)yb_placeHolderColor{
    return self.yb_placeHolderLabel.textColor;
}
-(void)setyb_placeHolderColor:(UIColor *)yb_placeHolderColor{
    self.yb_placeHolderLabel.textColor = yb_placeHolderColor;
}
-(NSString *)placeholder{
    return self.yb_placeHolder;
}
-(void)setPlaceholder:(NSString *)placeholder{
    self.yb_placeHolder = placeholder;
}
#pragma mark - update
- (void)updatePlaceHolder{
    if (self.text.length) {
        [self.yb_placeHolderLabel removeFromSuperview];
        return;
    }
    self.yb_placeHolderLabel.font = self.font?self.font:self.cacutDefaultFont;
    self.yb_placeHolderLabel.textAlignment = self.textAlignment;
    self.yb_placeHolderLabel.text = self.yb_placeHolder;
    [self insertSubview:self.yb_placeHolderLabel atIndex:0];
}
#pragma mark - lazzing
-(UILabel *)yb_placeHolderLabel{
    UILabel *placeHolderLab = objc_getAssociatedObject(self, @selector(yb_placeHolderLabel));
    if (!placeHolderLab) {
        placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.numberOfLines = 0;
        placeHolderLab.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(yb_placeHolderLabel), placeHolderLab, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    return placeHolderLab;
}
- (UIFont *)cacutDefaultFont{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @" ";
        font = textview.font;
    });
    return font;
}
@end

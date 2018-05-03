//
//  UIButton+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "UIButton+YBTool.h"
#import <objc/runtime.h>
#import "UIImage+YBTool.h"
@interface HandlerInvoke : NSObject <NSCopying>{}

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;
@property (nonatomic) UIControlEvents controlEvents;
@property (nonatomic, copy) void (^handler)(id sender);

@end

@implementation HandlerInvoke

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents{
    self = [super init];
    if (self) {
        self.handler = handler;
        self.controlEvents = controlEvents;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    return [[HandlerInvoke alloc] initWithHandler:self.handler forControlEvents:self.controlEvents];
}

- (void)invoke:(id)sender{
    self.handler(sender);
}

-(void)dealloc{
    
}

@end

static const void *LHandlersKey = &LHandlersKey;

@implementation UIButton (YBTool)
+ (UIButton *)buttonWithNormalTitle:(NSString *)title selectedTitle:(NSString *)selectedtitle font:(UIFont *)font NormaltitleColor:(UIColor *)color selectedTitleColor:(UIColor *)selectedColor normalImage:(UIImage *)image selectedImage:(UIImage *)selectedImage withBlock:(void(^)(id sender))block{
    UIButton * btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (block) {
        [btn handlerControlEvent:UIControlEventTouchUpInside handler:block];
    }
    if (selectedColor) {
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    if (selectedtitle) {
        [btn setTitle:title forState:UIControlStateSelected];
    }
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [btn setImage:selectedImage forState:UIControlStateSelected];
    }
    return btn;
}

+ (UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color withBlock:(void(^)(id sender))block{
    return  [self buttonWithNormalTitle:title selectedTitle:nil font:font NormaltitleColor:color selectedTitleColor:nil normalImage:nil selectedImage:nil withBlock:block];
}

+ (UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color normalImage:(UIImage *)image withBlock:(void(^)(id sender))block{
    return  [self buttonWithNormalTitle:title selectedTitle:nil font:font NormaltitleColor:color selectedTitleColor:nil normalImage:image selectedImage:nil withBlock:block];
}
- (void)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color withBlock:(void(^)(id sender))block{
    [self buttonWithNormalTitle:title selectedTitle:nil font:font NormaltitleColor:color selectedTitleColor:nil normalImage:nil selectedImage:nil withBlock:block];
}
- (void)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color normalImage:(UIImage *)image withBlock:(void(^)(id sender))block{
    [self buttonWithNormalTitle:title selectedTitle:nil font:font NormaltitleColor:color selectedTitleColor:nil normalImage:image selectedImage:nil withBlock:block];
}
- (void)buttonWithNormalTitle:(NSString *)title selectedTitle:(NSString *)selectedtitle font:(UIFont *)font NormaltitleColor:(UIColor *)color selectedTitleColor:(UIColor *)selectedColor normalImage:(UIImage *)image selectedImage:(UIImage *)selectedImage withBlock:(void(^)(id sender))block{
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = font;
    [self setTitleColor:color forState:UIControlStateNormal];
    if (block) {
        [self handlerControlEvent:UIControlEventTouchUpInside handler:block];
    }
    if (selectedColor) {
        [self setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    if (selectedtitle) {
        [self setTitle:title forState:UIControlStateSelected];
    }
    if (image) {
        [self setImage:image forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [self setImage:selectedImage forState:UIControlStateSelected];
    }
}


/**
 设置Normal下的图片
 
 @param image 图片
 */
- (void)setNormalImage:(UIImage *)image{
    [self setImage:image forState:UIControlStateNormal];
}

/**
 设置hlighted]下的图片
 
 @param image 图片
 */
- (void)setHighlightedImage:(UIImage *)image{
    [self setImage:image forState:UIControlStateHighlighted];
}

/**
 设置Selected下的图片
 
 @param image 图片
 */
- (void)setSelectedImage:(UIImage *)image{
    [self setImage:image forState:UIControlStateSelected];
}

/**
 设置Normal下的图片
 
 @param name 图片名
 */
- (void)setNormalImageName:(NSString *)name{
    [self setImage:YBNameImage(name) forState:UIControlStateNormal];
}

/**
 设置hlighted]下的图片
 
 @param name 图片名
 */
- (void)setHighlightedImageName:(NSString *)name{
    [self setImage:YBNameImage(name) forState:UIControlStateHighlighted];
}

/**
 设置Selected下的图片
 
 @param name 图片名
 */
- (void)setSelectedImageName:(NSString *)name{
    [self setImage:YBNameImage(name) forState:UIControlStateSelected];
}

/**
 设置Normal下的背景图片
 @param image 图片
 */
-(void)setNormalBackgroundImage:(UIImage*)image{
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

/**
 设置hlighted]下的背景图片
 @param image 图片
 */
-(void)setHighlightedBackgroundImage:(UIImage*)image{
    [self setBackgroundImage:image forState:UIControlStateHighlighted];
}

/**
 设置Selected下的背景图片
 @param image 图片
 */
-(void)setSelectedBackgroundImage:(UIImage*)image{
    [self setBackgroundImage:image forState:UIControlStateSelected];
}

/**
 设置Normal下的背景图片
 @param name 图片名
 */
-(void)setNormalBackgroundImageName:(NSString*)name{
    [self setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
}

/**
 设置Highlighted下的背景图片
 @param name 图片名
 */
-(void)setHighlightedBackgroundImageName:(NSString*)name{
    [self setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateHighlighted];
}

/**
 设置Selected下的背景图片
 @param name 图片名
 */
-(void)setSelectedBackgroundImageName:(NSString*)name{
    [self setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateSelected];
}

/**
 设置Normal下的Title
 
 @param title <#title description#>
 */
-(void)setNormalTitle:(NSString*)title{
    [self setTitle:title forState:UIControlStateNormal];
}

/**
 设置Highlighted下的Title
 
 @param title <#title description#>
 */
-(void)setHighlightedTitle:(NSString*)title{
    [self setTitle:title forState:UIControlStateHighlighted];
}

/**
 设置Selected下的Title
 
 @param title <#title description#>
 */
-(void)setSelectedTitle:(NSString*)title{
    [self setTitle:title forState:UIControlStateSelected];
}

/**
 设置Normal下的Title Color
 
 @param color <#color description#>
 */
-(void)setNormalTitleColor:(UIColor *)color{
    [self setTitleColor:color forState:UIControlStateNormal];
}

/**
 设置Highlighted下的Title Color
 
 @param color <#color description#>
 */
-(void)setHighlightedTitleColor:(UIColor *)color{
    [self setTitleColor:color forState:UIControlStateHighlighted];
}
/**
 设置Selected下的Title Color
 
 @param color <#color description#>
 */
-(void)setSelectedTitleColor:(UIColor *)color{
    [self setTitleColor:color forState:UIControlStateSelected];
}
/**
 创建便捷的通用点击事件
 
 @param controlEvent button事件
 @param handler 回调block
 */
-(void)handlerControlEvent:(UIControlEvents)controlEvent handler:(void (^)(id sender))handler{
    NSMutableArray *events = objc_getAssociatedObject(self, LHandlersKey);
    if (!events) {
        events = [NSMutableArray array];
        objc_setAssociatedObject(self, LHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    HandlerInvoke *target = [[HandlerInvoke alloc] initWithHandler:handler forControlEvents:controlEvent];
    [events addObject:target];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvent];
}

/**
 创建最常用的TouchUpInside点击
 
 @param handler 回调block
 */
-(void)handlerTouchUpInsideEvent:(void (^)(id sender))handler{
    [self handlerControlEvent:UIControlEventTouchUpInside handler:handler];
}

/**
 移除target
 
 @param event <#event description#>
 */
-(void)removeTargetWithEvent:(UIControlEvents)event{
    NSMutableArray *events = objc_getAssociatedObject(self, LHandlersKey);
    NSMutableArray *copyArray = [events mutableCopy];
    [copyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HandlerInvoke *target = events[idx];
        if (target.controlEvents == event) {
            [self removeTarget:target action:NULL forControlEvents:event];
            [events removeObject:target];
        }
    }];
}

/**
 *  设置不同状态背景颜色
 *
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIImage imageWithColor:backgroundColor] forState:state];
    
}

@end

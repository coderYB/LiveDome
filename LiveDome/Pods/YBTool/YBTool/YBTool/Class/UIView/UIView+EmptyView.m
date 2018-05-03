//
//  UIView+EmptyView.m
//  YBTool
//
//  Created by zbwx on 2018/4/12.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "UIView+EmptyView.h"
#import "UIImage+YBTool.h"
#import "UIView+YBTool.h"
#import "UIColor+YBTool.h"
#import "UIFont+YBTool.h"
#import "UIButton+YBTool.h"
#import "UILabel+YBTool.h"
#import <objc/runtime.h>
typedef void (^ActionBlock)(void);
@implementation UIView (EmptyView)
static char emptyViewKey;
/**
 显示空view
 
 @param text <#text description#>
 @param image <#image description#>
 */
-(void)showEmptyViewWithText:(NSString *)text image:(NSString *)image{
    [self hiddenEmptyView];
    
    UIView *emptyView = [[UIView alloc] initWithFrame:self.bounds];
    [emptyView setTag:5463156];
    [emptyView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:emptyView];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:YBNameImage(image)];
    [iconImageView setCenter:CGPointMake(emptyView.width/2, emptyView.height/2-iconImageView.height/2)];
    [emptyView addSubview:iconImageView];
    
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconImageView.bottom+15, emptyView.width, 14)];
    [textLabel setTextColor:[UIColor colorWithHex:0xcccccc]];
    [textLabel setFont:YBSystemFont(15)];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [textLabel setText:text];
    [textLabel setNumberOfLines:0];
    [emptyView addSubview:textLabel];
    
    if ([image length]) {
        [iconImageView setCenter:CGPointMake(emptyView.width/2, emptyView.height/2-iconImageView.height/2)];
        [textLabel setFrame:CGRectMake(0, iconImageView.bottom+24, emptyView.width, textLabel.textHeight)];
    }else{
        [iconImageView setFrame:CGRectMake(0, 0, 0, 0)];
        [textLabel setFrame:CGRectMake(0, (emptyView.height-textLabel.textHeight)/2, emptyView.width, textLabel.textHeight)];
    }
    
    UIButton *reloadButton = [[UIButton alloc] initWithFrame:emptyView.bounds];
    [reloadButton setBackgroundColor:[UIColor clearColor]];
    [emptyView addSubview:reloadButton];
    __weak typeof(self)weakSelf = self;
    [reloadButton handlerTouchUpInsideEvent:^(id sender) {
        ActionBlock block = (ActionBlock)objc_getAssociatedObject(weakSelf, &emptyViewKey);
        if (block) {
            block();
        }
    }];
}
/**
 *  隐藏空view
 */
-(void)hiddenEmptyView{
    UIView *emptyView = [self viewWithTag:5463156];
    if (emptyView) {
        [emptyView removeFromSuperview];
        emptyView = nil;
    }
}

/**
 *  获取空view
 */
-(UIView*)emptyView{
    return [self viewWithTag:5463156];
}


/**
 *  点击空视图回调
 *
 *  @param handleBlock <#handleBlock description#>
 */
-(void)emptyViewHandle:(void (^)(void))handleBlock{
    objc_setAssociatedObject(self, &emptyViewKey, handleBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end

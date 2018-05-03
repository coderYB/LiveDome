//
//  UIView+EmptyView.h
//  YBTool
//
//  Created by zbwx on 2018/4/12.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EmptyView)
/**
 显示空view
 
 @param text <#text description#>
 @param image <#image description#>
 */
-(void)showEmptyViewWithText:(NSString *)text image:(NSString *)image;

/**
 *  隐藏空view
 */
-(void)hiddenEmptyView;

/**
 *  获取空view
 */
-(UIView*)emptyView;

/**
 *  点击空视图回调
 *
 *  @param handleBlock <#handleBlock description#>
 */
-(void)emptyViewHandle:(void (^)(void))handleBlock;
@end

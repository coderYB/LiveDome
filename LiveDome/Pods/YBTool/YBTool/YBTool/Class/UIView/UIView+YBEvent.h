//
//  UIView+YBEvent.h
//  YBTool
//
//  Created by zbwx on 2018/4/12.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ActionBlock)(NSDictionary *param);
@interface UIView (YBEvent)

/**
 如果需要传参，请给param赋值
 */
@property(nonatomic, copy) NSDictionary *param;


/**
 添加tap手势

 @param tapBlock <#tapBlock description#>
 */
- (void)addTapActionWithBlock:(ActionBlock)tapBlock;

/**
 移除所有tap手势
 */
- (void)removeAllTapGesture;


/**
 添加长按手势

 @param longPressBlock <#longPressBlock description#>
 */
- (void)addLongPressActionWithBlock:(ActionBlock)longPressBlock;

/**
 移除所有长按手势
 */
- (void)removeAllLongPressGesture;
@end

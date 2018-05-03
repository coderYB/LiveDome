//
//  NSArray+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/13.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - ------------- 不可变数组 -------------
@interface NSArray (YBTool)

/**
 数据为空判断

 @param array <#array description#>
 @return <#return value description#>
 */
+ (BOOL)isEmptyWithArray:(NSArray *)array;


/**
 取值

 @param index <#index description#>
 @return <#return value description#>
 */
- (id)safeObjectAtIndex:(NSInteger)index;

/**
 随机元素

 @return <#return value description#>
 */
- (id)randomObject;


/**
 添加

 @param object <#object description#>
 @return <#return value description#>
 */
- (NSMutableArray *)safeAddObject:(id)object;


/**
 删除元素

 @param index <#index description#>
 @return <#return value description#>
 */
- (NSMutableArray *)safeArrayRemoveObjectAtIndex:(NSInteger)index;


/**
 遍历数组转化

 @param block <#block description#>
 @return <#return value description#>
 */
- (NSArray *)mapArrayUsingBlock:(id (^)(id object, NSInteger index))block;


/**
 筛选数组找到符合条件的数据数组

 @param findBlock <#findBlock description#>
 @param stopWhenFind <#stopWhenFind description#>
 @return <#return value description#>
 */
- (NSArray *)filterArrayUsingBlock:(BOOL (^) (id object))findBlock stopWhenFind:(BOOL)stopWhenFind;


/**
 删除符合条件的元素

 @param deleteBlock <#deleteBlock description#>
 @param stopWhenDelete <#stopWhenDelete description#>
 @return <#return value description#>
 */
- (NSArray *)deleteArrayUsingBlock:(BOOL (^)(id object))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete;


/**
 重组数组(打乱顺序)

 @return <#return value description#>
 */
- (NSArray *)shuffledArray;

/**
 数组倒序

 @return <#return value description#>
 */
- (NSArray *)reversedArray;

/**
 数组去重

 @return <#return value description#>
 */
- (NSArray *)uniqueArray;

@end

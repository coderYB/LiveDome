//
//  NSMutableArray+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/13.
//  Copyright © 2018年 zbwx. All rights reserved.
//

/**
 说明，所有的-方法是建立在self存在的情况会执行，如果为nil或NULL，这些-方法是不会执行的
 **/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSMutableArray (YBTool)

/**
 添加

 @param object <#object description#>
 */
- (void)safeAddObject:(id)object;
- (void)safeAddObjectsFromArray:(NSArray *)array;
- (void)safeInsertObject:(id)object atIndex:(NSInteger)index;

/**
 替换

 @param index <#index description#>
 @param object <#object description#>
 */
- (void)safeReplaceObjectAtIndex:(NSInteger)index  withObject:(id)object;


/**
 添加基本类型数组元素

 @param number <#number description#>
 */
- (void)safeAddObjectWithInteger:(NSInteger)number;
- (void)safeAddObjectWithDouble:(double)number;
- (void)safeAddObjectWithFloat:(float)number;
- (void)safeAddObjectWithLong:(long long)number;
- (void)safeAddObjectWithRang:(NSRange)rang;
- (void)safeAddObjectWithRect:(CGRect)rect;
- (void)safeAddObjectWithPoint:(CGPoint)point;
- (void)safeAddObjectWithSize:(CGSize)size;


/**
 删除元素

 @param index <#index description#>
 */
- (void)safeRemoveObjectAtIndex:(NSInteger)index;


/**
 遍历数组转化

 @param block <#block description#>
 */
- (void)mapUsingBlock:(id (^)(id object, NSInteger index))block;


/**
 筛选数组找到符合条件的数据数组

 @param findBlock <#findBlock description#>
 @param stopWhenFind <#stopWhenFind description#>
 */
- (void)filterUsingBlock:(BOOL (^) (id object))findBlock stopWhenFind:(BOOL)stopWhenFind;


/**
 删除符合条件的元素

 @param deleteBlock <#deleteBlock description#>
 @param stopWhenDelete <#stopWhenDelete description#>
 */
- (void)deleteUsingBlock:(BOOL (^)(id object))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete;


/**
 重组数组(打乱顺序)
 */
- (void)shuffle;

/**
 数组倒序
 */
- (void)reverse;

/**
 数组去重
 */
- (void)unique;

@end

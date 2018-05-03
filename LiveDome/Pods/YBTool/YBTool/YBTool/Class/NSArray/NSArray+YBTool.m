//
//  NSArray+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/13.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "NSArray+YBTool.h"
#import "NSMutableArray+YBTool.h"
#pragma mark - ------------- 不可变数组 -------------
@implementation NSArray (YBTool)

+ (BOOL)isEmptyWithArray:(NSArray *)array {
    if (array && (array.count > 0)) {
        return NO;
    }
    return YES;
}

- (id)safeObjectAtIndex:(NSInteger)index {
    if ((self.count > index) && (index >= 0)) {
        id obj = [self objectAtIndex:index];
        if (![obj isKindOfClass:[NSNull class]]) {
            return obj;
        }
    }
    NSLog(@"注意-------------->数组越界");
    return nil;
}


/**
 取随机元素

 @return <#return value description#>
 */
- (id)randomObject {
    if (self && self.count > 0) {
        NSInteger index = arc4random() % self.count;
        return [self safeObjectAtIndex:index];
    }
    return nil;
}


/**
 添加

 @param object <#object description#>
 @return <#return value description#>
 */
- (NSMutableArray *)safeAddObject:(id)object {
    NSMutableArray *mutArray = [NSMutableArray array];
    
    if (self) {
        [mutArray safeAddObjectsFromArray:self];
    }
    [mutArray safeAddObject:object];
    return mutArray;
    
}

/**
 删除元素

 @param index <#index description#>
 @return <#return value description#>
 */
- (NSMutableArray *)safeArrayRemoveObjectAtIndex:(NSInteger)index {
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self];
    [array safeRemoveObjectAtIndex:index];
    return array;
}


/**
 转换

 @param block <#block description#>
 @return <#return value description#>
 */
- (NSArray *)mapArrayUsingBlock:(id (^)(id, NSInteger))block {
    
    if (block) {
        __block NSMutableArray *array = [NSMutableArray array];
        
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array safeAddObject:block(obj, idx)];
        }];
        return [array copy];
    }
    return self;
}


/**
 筛选

 @param findBlock <#findBlock description#>
 @param stopWhenFind <#stopWhenFind description#>
 @return <#return value description#>
 */
- (NSArray *)filterArrayUsingBlock:(BOOL (^) (id object))findBlock stopWhenFind:(BOOL)stopWhenFind {
    
    if (findBlock) {
        __block NSMutableArray *array = [NSMutableArray array];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (findBlock(obj)) {
                [array safeAddObject:obj];
                *stop = stopWhenFind;
            }
        }];
        
        return [array copy];
    }
    return self;
}


/**
 删除符合条件的元素

 @param deleteBlock <#deleteBlock description#>
 @param stopWhenDelete <#stopWhenDelete description#>
 @return <#return value description#>
 */
- (NSArray *)deleteArrayUsingBlock:(BOOL (^)(id object))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete {
    
    if (deleteBlock) {
        __block NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *mutArray = [NSMutableArray array];
        [mutArray safeAddObjectsFromArray:self];
        
        [mutArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (deleteBlock(obj)) {
                [array safeAddObject:obj];
                *stop = stopWhenDelete;
            }
        }];
        [mutArray removeObjectsInArray:[array copy]];
        return [mutArray copy];
    }
    
    return self;
}


/**
 数组乱序

 @return <#return value description#>
 */
- (NSArray *)shuffledArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    NSMutableArray *copy = [self mutableCopy];
    while (copy.count > 0)
    {
        NSInteger index = arc4random() % copy.count;
        id objectToMove = [copy objectAtIndex:index];
        [array addObject:objectToMove];
        [copy removeObjectAtIndex:index];
    }
    return [array copy];
}


/**
 数组倒序

 @return <#return value description#>
 */
- (NSArray *)reversedArray {
    NSArray *reversedArray = [[self reverseObjectEnumerator] allObjects];
    return reversedArray;
}


/**
 数组去重

 @return <#return value description#>
 */
- (NSArray *)uniqueArray {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([array containsObject:obj] == NO){
            [array addObject:obj];
        }
    }];
    return [array copy];
}

@end

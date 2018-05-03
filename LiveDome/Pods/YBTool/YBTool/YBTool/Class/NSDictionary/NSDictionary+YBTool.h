//
//  NSDictionary+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/13.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - ------------- 不可变字典 -------------
@interface NSDictionary (YBTool)

/**
 是否有key

 @param key <#key description#>
 @return <#return value description#>
 */
- (BOOL)hasKey:(id)key;


/**
 赋值

 @param value <#value description#>
 @param key <#key description#>
 */
- (void)safeSetValue:(id)value forKey:(id)key;


/**
 取值

 @param key <#key description#>
 @return <#return value description#>
 */
- (id)safeValueForKey:(id)key;

- (NSString*)stringForKey:(id)key;
- (NSNumber*)numberForKey:(id)key;
- (NSArray*)arrayForKey:(id)key;
- (NSDictionary*)dictionaryForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
- (BOOL)boolForKey:(id)key;
- (double)doubleForKey:(id)key;


/**
 合并

 @param dict1 <#dict1 description#>
 @param dict2 <#dict2 description#>
 @return <#return value description#>
 */
+ (NSMutableDictionary *)safeDictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
- (NSMutableDictionary *)safeDictionaryByMergingWith:(NSDictionary *)dict;



/**
 转换为json字符串

 @return <#return value description#>
 */
- (NSString *)safeJSONString;


/**
 删除元素

 @param key <#key description#>
 @return <#return value description#>
 */
- (NSDictionary *)safeDictionaryRemoveObjectForKey:(id)key;


/**
 遍历字典转化修改

 @param block <#block description#>
 @return <#return value description#>
 */
- (NSDictionary *)mapDictionaryUsingBlock:(id (^)(id object, NSString *key))block;


/**
 筛选符合条件的键值对

 @param findBlock <#findBlock description#>
 @param stopWhenFind <#stopWhenFind description#>
 @return <#return value description#>
 */
- (NSDictionary *)filterDictionaryUsingBlock:(BOOL (^) (id object, NSString *key))findBlock stopWhenFind:(BOOL)stopWhenFind;


/**
 删除符合条件的元素

 @param deleteBlock <#deleteBlock description#>
 @param stopWhenDelete <#stopWhenDelete description#>
 @return <#return value description#>
 */
- (NSDictionary *)deleteDictionaryUsingBlock:(BOOL (^)(id object, NSString *key))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete;

/**
 根据参数字典获取url编码字符串

 @return <#return value description#>
 */
- (NSString *)URLQueryString;

/**
 根据参数字典获取url编码过的字典

 @return <#return value description#>
 */
- (NSDictionary *)URLQueryDictionary;


/**
 根据url编码字符串获取参数字典

 @param query <#query description#>
 @return <#return value description#>
 */
+ (NSDictionary *)dictionaryWithURLQuery:(NSString *)query;



@end


#pragma mark - ------------- 可变字典 -------------
@interface NSMutableDictionary (YBTool)


/**
 对象赋值

 @param object <#object description#>
 @param key <#key description#>
 */
- (void)safeSetObject:(id)object forKey:(id)key;


/**
 基本类型赋值

 @param number <#number description#>
 @param key <#key description#>
 */
- (void)safeSetBoolObject:(BOOL)number forKey:(id)key;
- (void)safeSetIntObject:(int)number forKey:(id)key;
- (void)safeSetIntegerObject:(NSInteger)number forKey:(id)key;
- (void)safeSetUnsignedIntegerObject:(NSUInteger)number forKey:(id)key;

- (void)safeSetCharObject:(char)c forKey:(id)key;
- (void)safeSetDoubleObject:(double)number forKey:(id)key;
- (void)safeSetFloatObject:(float)number forKey:(id)key;
- (void)safeSetLongLongObject:(long long)number forKey:(id)key;

- (void)safeSetCGFloatObject:(CGFloat)f forKey:(id)key;
- (void)safeSetPointObject:(CGPoint)point forKey:(id)key;
- (void)safeSetSizeObject:(CGSize)size forKey:(id)key;
- (void)safeSetRectObject:(CGRect)rect forKey:(id)key;


/**
 删除元素

 @param key <#key description#>
 */
- (void)safeRemoveObjectForKey:(id)key;


/**
 遍历字典转化修改

 @param block <#block description#>
 */
- (void)mapUsingBlock:(id (^)(id object, NSString *key))block;


/**
 筛选符合条件的键值对

 @param findBlock <#findBlock description#>
 @param stopWhenFind <#stopWhenFind description#>
 */
- (void)filterUsingBlock:(BOOL (^) (id object, NSString *key))findBlock stopWhenFind:(BOOL)stopWhenFind;


/**
 删除符合条件的元素

 @param deleteBlock <#deleteBlock description#>
 @param stopWhenDelete <#stopWhenDelete description#>
 */
- (void)deleteUsingBlock:(BOOL (^)(id object, NSString *key))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete;


@end

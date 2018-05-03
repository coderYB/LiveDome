//
//  NSDictionary+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/13.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "NSDictionary+YBTool.h"
#pragma mark - ------------- 不可变字典 -------------
@implementation NSDictionary (YBTool)

/**
 是否有key

 @param key <#key description#>
 @return <#return value description#>
 */
- (BOOL)hasKey:(id)key {
    return [self objectForKey:key] != nil;
}
/**
 赋值

 @param value <#value description#>
 @param key <#key description#>
 */
- (void)safeSetValue:(id)value forKey:(id)key {
    if (key && value) {
        [self setValue:value forKey:key];
    }
}

/**
 取值

 @param key <#key description#>
 @return <#return value description#>
 */
- (id)safeValueForKey:(id)key {
    if ([self hasKey:key]) {
        id value = [self valueForKey:key];
        if (![value isEqual:[NSNull null]]) {
            return value;
        }
    }
    return nil;
}


- (NSString*)stringForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([[value description] isEqualToString:@"(null)"]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}

- (NSNumber*)numberForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}


- (NSArray*)arrayForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}


- (NSDictionary*)dictionaryForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSInteger)integerForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (BOOL)boolForKey:(id)key {
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

- (double)doubleForKey:(id)key {
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value doubleValue];
    }
    return 0;
}

/**
 合并

 @param dict1 <#dict1 description#>
 @param dict2 <#dict2 description#>
 @return <#return value description#>
 */
+ (NSMutableDictionary *)safeDictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2 {
    NSMutableDictionary * result = [NSMutableDictionary dictionaryWithDictionary:dict1];
    [dict2 enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        if (![dict1 objectForKey:key]) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary * newVal = [[dict1 objectForKey: key] safeDictionaryByMergingWith: (NSDictionary *) obj];
                if (newVal && key) {
                    [result setObject: newVal forKey: key];
                }
                
            } else {
                if (obj && key) {
                    [result setObject: obj forKey: key];
                }
            }
        }
    }];
    return [result copy];
}

- (NSMutableDictionary *)safeDictionaryByMergingWith:(NSDictionary *)dict {
    return [[self class] safeDictionaryByMerging:self with: dict];
}

/**
 转换为json字符串

 @return <#return value description#>
 */
- (NSString *)safeJSONString {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

/**
 删除元素

 @param key <#key description#>
 @return <#return value description#>
 */
- (NSDictionary *)safeDictionaryRemoveObjectForKey:(id)key {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:self];
    [dict safeRemoveObjectForKey:key];
    return [dict copy];
}

/**
 遍历字典转化修改

 @param block <#block description#>
 @return <#return value description#>
 */
- (NSDictionary *)mapDictionaryUsingBlock:(id (^)(id object, NSString *key))block {
    if (block) {
        __block NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [dict setObject:block(obj, key) forKey:key];
        }];
        return [dict copy];
    }
    return self;
}

/**
 筛选符合条件的键值对

 @param findBlock <#findBlock description#>
 @param stopWhenFind <#stopWhenFind description#>
 @return <#return value description#>
 */
- (NSDictionary *)filterDictionaryUsingBlock:(BOOL (^) (id object, NSString *key))findBlock stopWhenFind:(BOOL)stopWhenFind {
    if (findBlock) {
        __block NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (findBlock (obj, key)) {
                [dict setObject:obj forKey:key];
                *stop = stopWhenFind;
            }
        }];
        return [dict copy];
    }
    
    return self;
}

/**
 删除符合条件的元素

 @param deleteBlock <#deleteBlock description#>
 @param stopWhenDelete <#stopWhenDelete description#>
 @return <#return value description#>
 */
- (NSDictionary *)deleteDictionaryUsingBlock:(BOOL (^)(id object, NSString *key))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete {
    
    if (deleteBlock) {
        __block NSMutableArray *keys = [NSMutableArray array];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:self];
        
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (deleteBlock(obj,key)) {
                [keys addObject:key];
                *stop = stopWhenDelete;
            }
        }];
        [dict removeObjectsForKeys:keys];
        return [dict copy];
    }
    
    return self;
}

/**
 根据参数字典获取url编码字符串

 @return <#return value description#>
 */
- (NSString *)URLQueryString{
    
    NSMutableString *string = [NSMutableString string];
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    
    for (NSString *key in [self allKeys]) {
        if ([string length]) {
            [string appendString:@"&"];
        }
        NSString *encodedUrl = [self[key] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        [string appendFormat:@"%@=%@", key, encodedUrl];
    }
    return [string copy];
}

/**
 根据参数字典获取url编码过的字典

 @return <#return value description#>
 */
- (NSDictionary *)URLQueryDictionary{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    
    for (NSString *key in [self allKeys]) {
        NSString *encodedUrl = [self[key] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        if (key && encodedUrl) {
            [dict setObject:encodedUrl forKey:key];
        }
    }
    return [dict copy];
}

/**
 根据url编码字符串获取参数字典

 @param query <#query description#>
 @return <#return value description#>
 */
+ (NSDictionary *)dictionaryWithURLQuery:(NSString *)query{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *parameters = [query componentsSeparatedByString:@"&"];
    for(NSString *parameter in parameters) {
        NSArray *contents = [parameter componentsSeparatedByString:@"="];
        if(contents.count == 2) {
            NSString *key = [contents objectAtIndex:0];
            NSString *value = [contents objectAtIndex:1];
            value = [value stringByRemovingPercentEncoding];
            if (key && value) {
                [dict setObject:value forKey:key];
            }
        }
    }
    return [dict copy];
}

@end


#pragma mark - ------------- 可变字典 -------------
@implementation NSMutableDictionary (YBTool)

/**
 对象赋值

 @param object <#object description#>
 @param key <#key description#>
 */
- (void)safeSetObject:(id)object forKey:(id)key {
    if (key && object) {
        [self setObject:object forKey:key];
    }
}

/**
 基本类型赋值

 @param number <#number description#>
 @param key <#key description#>
 */
- (void)safeSetBoolObject:(BOOL)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}
- (void)safeSetIntObject:(int)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}
- (void)safeSetIntegerObject:(NSInteger)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}
- (void)safeSetUnsignedIntegerObject:(NSUInteger)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}

- (void)safeSetCharObject:(char)c forKey:(id)key {
    if (key) {
        [self setObject:@(c) forKey:key];
    }
}
- (void)safeSetDoubleObject:(double)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}
- (void)safeSetFloatObject:(float)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}
- (void)safeSetLongLongObject:(long long)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}

- (void)safeSetCGFloatObject:(CGFloat)f forKey:(id)key {
    if (key) {
        [self setObject:@(f) forKey:key];
    }
}
- (void)safeSetPointObject:(CGPoint)point forKey:(id)key {
    if (key) {
        [self setObject:NSStringFromCGPoint(point) forKey:key];
    }
}
- (void)safeSetSizeObject:(CGSize)size forKey:(id)key {
    if (key) {
        [self setObject:NSStringFromCGSize(size) forKey:key];
    }
}
- (void)safeSetRectObject:(CGRect)rect forKey:(id)key {
    if (key) {
        [self setObject:NSStringFromCGRect(rect) forKey:key];
    }
}

/**
 删除元素

 @param key <#key description#>
 */
- (void)safeRemoveObjectForKey:(id)key {
    if (key) {
        [self removeObjectForKey:key];
    }
}

/**
 遍历字典转化修改

 @param block <#block description#>
 */
- (void)mapUsingBlock:(id (^)(id object, NSString *key))block{
    
    if (block) {
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self safeSetObject:block(obj, key) forKey:key];
        }];
    }
    
}

/**
 筛选符合条件的键值对

 @param findBlock <#findBlock description#>
 @param stopWhenFind <#stopWhenFind description#>
 */
- (void)filterUsingBlock:(BOOL (^) (id object, NSString *key))findBlock stopWhenFind:(BOOL)stopWhenFind {
    
    if (findBlock) {
        __block NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (findBlock (obj, key)) {
                [dict safeSetObject:obj forKey:key];
                *stop = stopWhenFind;
            }
        }];
        [self removeAllObjects];
        [self setDictionary:dict];
    }
}


/**
 删除符合条件的元素

 @param deleteBlock <#deleteBlock description#>
 @param stopWhenDelete <#stopWhenDelete description#>
 */
- (void)deleteUsingBlock:(BOOL (^)(id object, NSString *key))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete {
    
    if (deleteBlock) {
        __block NSMutableArray *keys = [NSMutableArray array];
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (deleteBlock(obj,key)) {
                [keys addObject:key];
                *stop = stopWhenDelete;
            }
        }];
        [self removeObjectsForKeys:keys];
    }
}
@end

//
//  NSObject+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "NSObject+YBTool.h"
#import <objc/message.h>
#import <objc/runtime.h>
static const void *extendObjectKey = @"extentObject";

@implementation NSObject (YBTool)
/**
 runtime 扩展属性
 
 @return <#return value description#>
 */
-(NSMutableDictionary *)extentObject{
    NSMutableDictionary *object = objc_getAssociatedObject(self, &extendObjectKey);
    if (object == nil) {
        object = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &extendObjectKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return object;
}

-(void)setExtentObject:(NSMutableDictionary *)extentObject{
    objc_setAssociatedObject(self, &extendObjectKey, extentObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/**
 归档

 @param aCoder <#aCoder description#>
 */
- (void)encodeObjectWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        //kvc取出属性值，归档
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);
}


/**
 解档

 @param aDecoder <#aDecoder description#>
 */
- (void)decodeObjectCoder:(NSCoder *)aDecoder{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        //kvc取出属性值，解档
        id value = [aDecoder decodeObjectForKey:key];
        //设置到成员变量身上
        [self setValue:value forKey:key];
    }
    free(ivars);
}
/* 获取对象的成员变量*/
- (NSArray *)getAllIvars{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        const char *ivarName = ivar_getName(ivars[i]);
        [array addObject:[NSString stringWithUTF8String:ivarName]];
    }
    free(ivars);
    return [array copy];
}

/* 获取对象的所有属性*/
- (NSArray *)getAllProperties{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        [array addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(properties);
    return [array copy];
}

/* 获取对象的所有方法*/
- (NSArray *)getAllMethods{
    
    unsigned int count =0;
    Method* methodList = class_copyMethodList([self class],&count);
    
    NSMutableArray *array = [NSMutableArray array];
    
    for(int i = 0; i<count; i++){
        Method method = methodList[i];
        SEL sel = method_getName(method);
        const char *name = sel_getName(sel);
        [array addObject:[NSString stringWithUTF8String:name]];
    }
    free(methodList);
    
    return [array copy];
}

@end

//
//  NSObject+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (YBTool)
/**
 runtime 扩展属性
 */
@property (nonatomic,strong) NSMutableDictionary *extentObject;

/**
 归档

 @param aCoder <#aCoder description#>
 */
- (void)encodeObjectWithCoder:(NSCoder *)aCoder;

/**
 解档

 @param aDecoder <#aDecoder description#>
 */
- (void)decodeObjectCoder:(NSCoder *)aDecoder;

/* 获取对象的成员变量*/
- (NSArray *)getAllIvars;

/* 获取对象的所有属性*/
- (NSArray *)getAllProperties;

/* 获取对象的所有方法*/
- (NSArray *)getAllMethods;

@end

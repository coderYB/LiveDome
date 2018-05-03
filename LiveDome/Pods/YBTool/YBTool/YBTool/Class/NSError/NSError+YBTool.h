//
//  NSError+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/13.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (YBTool)

/**
 新建error

 @param domain <#domain description#>
 @param code <#code description#>
 @param description <#description description#>
 @param failReason <#failReason description#>
 @return <#return value description#>
 */
+ (NSError *)errorWithDomain:(NSString *)domain
                        code:(NSInteger)code
                 description:(NSString *)description
               failureReason:(NSString *)failReason;
+ (NSError *)errorWithDomain:(NSString *)domain
                        code:(NSInteger)code
                 description:(NSString *)description;


/**
 获取error信息

 @return <#return value description#>
 */
- (NSString *)getErrorDomain;
- (NSInteger)getErrorCode;
- (NSString *)getErrorDescription;
- (NSString *)getErrorReason;

@end

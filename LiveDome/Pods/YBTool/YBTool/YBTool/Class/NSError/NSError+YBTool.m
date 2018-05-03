//
//  NSError+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/13.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "NSError+YBTool.h"

@implementation NSError (YBTool)
+ (NSError *)errorWithDomain:(NSString *)domain
                        code:(NSInteger)code
                 description:(NSString *)description {
    
    NSError *error = [NSError errorWithDomain:domain
                                         code:code
                                     userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description,NSLocalizedDescriptionKey,nil]];
    return error;
}


+ (NSError *)errorWithDomain:(NSString *)domain
                        code:(NSInteger)code
                 description:(NSString *)description
               failureReason:(NSString *)failureReason {
    
    NSError *error = [NSError errorWithDomain:domain
                                         code:code
                                     userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, NSLocalizedDescriptionKey,
                                               failureReason, NSLocalizedFailureReasonErrorKey,nil]];
    return error;
}

- (NSString *)getErrorDomain{
    return [self domain];
}
- (NSInteger)getErrorCode{
    return [self code];
}
- (NSString *)getErrorDescription{
    return [self localizedDescription];
}
- (NSString *)getErrorReason{
    return [self localizedFailureReason];
}

@end

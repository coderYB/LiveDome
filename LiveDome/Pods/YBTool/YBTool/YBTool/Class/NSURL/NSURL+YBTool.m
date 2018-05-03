//
//  NSURL+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/13.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "NSURL+YBTool.h"

@implementation NSURL (YBTool)

/**
 创建一个url

 @param URLString <#URLString description#>
 @return <#return value description#>
 */
+ (NSURL *)URLWithStringOrNil:(NSString *)URLString {
    if (URLString) {
        return [NSURL URLWithString:URLString];
    }
    return nil;
}

/**
 url是否相同

 @param otherURL <#otherURL description#>
 @return <#return value description#>
 */
- (BOOL) isEqualToURL:(NSURL*)otherURL {
    return [[self absoluteURL] isEqual:[otherURL absoluteURL]] ||
    ([self isFileURL] && [otherURL isFileURL] && [[self path] isEqual:[otherURL path]]);
}


@end

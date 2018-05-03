//
//  NSURL+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/13.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (YBTool)


/**
 创建一个url

 @param URLString <#URLString description#>
 @return <#return value description#>
 */
+ (NSURL *)URLWithStringOrNil:(NSString *)URLString;

/**
 url是否相同

 @param otherURL <#otherURL description#>
 @return <#return value description#>
 */
- (BOOL) isEqualToURL:(NSURL*)otherURL;
@end

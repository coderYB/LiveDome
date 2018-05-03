//
//  NSObject+Swizzling.h
//  YBTool
//
//  Created by zbwx on 2018/4/18.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                         bySwizzledSelector:(SEL)swizzledSelector;
@end

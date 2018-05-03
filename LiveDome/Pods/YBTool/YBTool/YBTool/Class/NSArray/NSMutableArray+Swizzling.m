//
//  NSMutableArray+Swizzling.m
//  YBTool
//
//  Created by zbwx on 2018/4/18.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "NSMutableArray+Swizzling.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
@implementation NSMutableArray (Swizzling)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(removeObject:) bySwizzledSelector:@selector(yb_RemoveObject:) ];
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(addObject:) bySwizzledSelector:@selector(yb_AddObject:)];
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(removeObjectAtIndex:) bySwizzledSelector:@selector(yb_RemoveObjectAtIndex:)];
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(insertObject:atIndex:) bySwizzledSelector:@selector(yb_InsertObject:atIndex:)];
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) bySwizzledSelector:@selector(yb_ObjectAtIndex:)];
    });
}
- (void)yb_AddObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s can add nil object into NSMutableArray", __FUNCTION__);
    } else {
        [self yb_AddObject:obj];
    }
}
- (void)yb_RemoveObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s call -removeObject:, but argument obj is nil", __FUNCTION__);
        return;
    }
    [self yb_RemoveObject:obj];
}
- (void)yb_InsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        NSLog(@"%s can't insert nil into NSMutableArray", __FUNCTION__);
    } else if (index > self.count) {
        NSLog(@"%s index is invalid", __FUNCTION__);
    } else {
        [self yb_InsertObject:anObject atIndex:index];
    }
}
- (id)yb_ObjectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return nil;
    }
    if (index > self.count) {
        NSLog(@"%s index out of bounds in array", __FUNCTION__);
        return nil;
    }
    return [self yb_ObjectAtIndex:index];
}
- (void)yb_RemoveObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return;
    }
    if (index >= self.count) {
        NSLog(@"%s index out of bound", __FUNCTION__);
        return;
    }
    [self yb_RemoveObjectAtIndex:index];
}

@end

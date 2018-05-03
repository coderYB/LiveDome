//
//  NSNumber+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/13.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "NSNumber+YBTool.h"

static NSNumberFormatter *numberFormatter = nil;

@implementation NSNumber (YBTool)
/**
 NSString转换为NSNumber
 
 @param string <#string description#>
 @return <#return value description#>
 */
+ (NSNumber *)numberWithString:(NSString *)string {
    if(numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    
    if (string) {
        @try {
            return [numberFormatter numberFromString:string];
        }
        @catch (NSException * e) {
            NSLog(@"NSNumberFormatter exception! parsing: %@", string);
        }
    }
    return nil;
}

@end

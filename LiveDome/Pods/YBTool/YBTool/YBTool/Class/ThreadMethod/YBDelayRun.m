//
//  YBDelayRun.m
//  YBTool
//
//  Created by zbwx on 2018/4/12.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "YBDelayRun.h"

void YBDelayRun(NSTimeInterval delay,void(^run)(void)){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (run) {
            run();
        }
    });
}

//
//  YBMainThredRun.m
//  YBTool
//
//  Created by zbwx on 2018/4/12.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "YBMainThredRun.h"

void YBMainThreadRun(void(^run)(void)){
    dispatch_async(dispatch_get_main_queue(), ^{
        if (run) {
            run();
        }
    });
}

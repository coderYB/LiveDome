//
//  YBOnceRun.m
//  YBTool
//
//  Created by zbwx on 2018/4/12.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "YBOnceRun.h"

void YBOnceRun(dispatch_once_t *onceToken,void(^run)(void)){
    dispatch_once(onceToken, ^{
        if (run) {
            run();
        }
    });
}



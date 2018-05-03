//
//  ClearTheCacheTools.m
//  StockProject
//
//  Created by zbwx on 2018/3/15.
//  Copyright © 2018年 ZBWX. All rights reserved.
//

#import "ClearTheCacheTools.h"

@implementation ClearTheCacheTools
static ClearTheCacheTools * tool = nil;
+(ClearTheCacheTools *)tool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tool == nil) {
            tool = [[ClearTheCacheTools alloc] init];
        }
    });
    return tool;
}

/**
 *  删除文件夹所有文件
 *
 *  @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath{
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        // 抛异常
        // name:异常名称
        // reason:报错原因
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"" userInfo:nil];
        [excp raise];
        
    }
    
    // 获取cache文件夹下所有文件,不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *subPath in subPaths) {
        // 拼接完成全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 删除路径
        [mgr removeItemAtPath:filePath error:nil];
    }
    
}
/**
 *  获取文件夹尺寸
 *
 *  @param directoryPath 文件夹路径
 *
 *  @return 返回文件夹尺寸
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion{
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        // 抛异常
        // name:异常名称
        // reason:报错原因
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"" userInfo:nil];
        [excp raise];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 获取文件夹下所有的子路径,包含子路径的子路径
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        
        NSInteger totalSize = 0;
        
        for (NSString *subPath in subPaths) {
            // 获取文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            // 判断隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            
            // 判断是否文件夹
            BOOL isDirectory;
            // 判断文件是否存在,并且判断是否是文件夹
            BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            
            // 获取文件属性
            // attributesOfItemAtPath:只能获取文件尺寸,获取文件夹不对,
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            
            // 获取文件尺寸
            NSInteger fileSize = [attr fileSize];
            
            totalSize += fileSize;
        }
        
        // 计算完成回调(为了避免计算大的文件夹,比较耗时,如果直接返回结果,控制器跳转的时候回产生卡顿,所以采用block回调的方式)
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
    });
}

/**
 获取缓存尺寸字符串
 
 @param totalSize <#totalSize description#>
 @return <#return value description#>
 */
+ (NSString *)getFileSizeWithTotalSize:(NSInteger)totalSize{
    NSString * fileSizeString = @"";
    // MB KB B
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        fileSizeString = [NSString stringWithFormat:@"%@(%.1fMB)",fileSizeString,sizeF];
    }else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        fileSizeString = [NSString stringWithFormat:@"%@(%.1fKB)",fileSizeString,sizeF];
    }else if (totalSize > 0) {
        // B
        fileSizeString = [NSString stringWithFormat:@"%@(%.ldB)",fileSizeString,totalSize];
    }else{
        // 0
        //fileSizeString = @"0";
    }
    return fileSizeString;
}
@end

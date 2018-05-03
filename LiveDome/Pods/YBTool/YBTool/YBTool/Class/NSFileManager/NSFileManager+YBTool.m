//
//  NSFileManager+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/13.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "NSFileManager+YBTool.h"

@implementation NSFileManager (YBTool)

/**
 获取App沙盒根路径

 @return <#return value description#>
 */
+ (NSString *)getDirHome{
    return NSHomeDirectory();
}

/**
 获取App_Documents路径

 @return <#return value description#>
 */
+ (NSString *)getDirDocumentsPath{
    return [self getPathForDirectory:NSDocumentDirectory];
}

/**
 获取App_Library路径

 @return <#return value description#>
 */
+ (NSString *)getDirLibraryPath{
    return [self getPathForDirectory:NSLibraryDirectory];
    
}

/**
 获取App_Cache路径

 @return <#return value description#>
 */
+ (NSString *)getDirCachePath{
    return [self getPathForDirectory:NSCachesDirectory];
}

/**
 获取App_Tmp根路径

 @return <#return value description#>
 */
+ (NSString *)getDirTmpPath{
    return NSTemporaryDirectory();
}

+ (NSString *)getPathForDirectory:(NSSearchPathDirectory)directory{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

/**
 路径文件是否存在

 @param path <#path description#>
 @return <#return value description#>
 */
+ (BOOL)fileExistsAtPath:(NSString *)path{
    return [[self defaultManager] fileExistsAtPath:path];
}

/**
 递归获取目录下所有文件名（文件和文件夹）

 @param path <#path description#>
 @return <#return value description#>
 */
+ (NSArray *)getSubpathsAtPath:(NSString *)path{
    if ([self fileExistsAtPath:path]) {
        return [[self defaultManager] subpathsAtPath:path];
    }
    return nil;
}

/**
 非递归获取目录下所有文件名（文件和文件夹）

 @param path <#path description#>
 @return <#return value description#>
 */
+ (NSArray *)getContentsOfDirectoryAtPath:(NSString *)path{
    NSError *error;
    if ([self fileExistsAtPath:path]) {
        NSArray *fileArray = [[self defaultManager] contentsOfDirectoryAtPath:path error:&error];
        if (!error) {
            return fileArray;
        }else{
            NSLog(@"getContentsOfDirectoryAtPath error:%@",error);
        }
    }
    return nil;
}

/**
 创建文件夹

 @param path <#path description#>
 @param dirName <#dirName description#>
 @return <#return value description#>
 */
+ (BOOL)createDirectoryAtPath:(NSString *)path dirName:(NSString *)dirName{
    
    if ([self fileExistsAtPath:path]) {
        NSString *newDirectory = [path stringByAppendingPathComponent:dirName];
        // 创建目录
        BOOL res=[[self defaultManager] createDirectoryAtPath:newDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        return res;
    }else{
        NSLog(@"the path is not exist！");
    }
    return NO;
}

/**
 创建文件

 @param path <#path description#>
 @param fileName <#fileName description#>
 @return <#return value description#>
 */
+ (BOOL)createFileAtPath:(NSString *)path fileName:(NSString *)fileName{
    
    if ([self fileExistsAtPath:path]) {
        NSString *newFile = [path stringByAppendingPathComponent:fileName];
        if ([self fileExistsAtPath:newFile]) {
            NSLog(@"Duplicate creation is not required， because the file is already exist! ");
            return YES;
        }
        // 创建文件
        BOOL res=[[self defaultManager] createFileAtPath:newFile contents:nil attributes:nil];
        return res;
    }else{
        NSLog(@"the path is not exist！");
    }
    return NO;
}

/**
 写文件

 @param data <#data description#>
 @param path <#path description#>
 @param fileName <#fileName description#>
 @return <#return value description#>
 */
+ (BOOL)writeWithData:(NSData *)data toPath:(NSString *)path fileName:(NSString *)fileName{
    if ([self fileExistsAtPath:path]) {
        NSString *newFile = [path stringByAppendingPathComponent:fileName];
        return [data writeToFile:newFile atomically:YES];
    }
    return NO;
}

/**
 读取文件

 @param path <#path description#>
 @return <#return value description#>
 */
+ (NSData *)readFileAtPath:(NSString *)path{
    BOOL isDir = NO;
    if ([[self defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
        if (!isDir) {
            NSData *data = [NSData dataWithContentsOfFile:path];
            return data;
        }
    }
    return nil;
}

/**
 删除文件或文件夹

 @param path <#path description#>
 @return <#return value description#>
 */
+ (BOOL)deleteFileOrDicAtPath:(NSString *)path{
    if ([self fileExistsAtPath:path]) {
        return [[self defaultManager] removeItemAtPath:path error:nil];
    }
    return YES;
}

/**
 移动文件

 @param srcPath <#srcPath description#>
 @param dstPath <#dstPath description#>
 @return <#return value description#>
 */
+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath{
    if ([self fileExistsAtPath:srcPath]) {
        return [[self defaultManager] moveItemAtPath:srcPath toPath:dstPath error:nil];
    }
    return NO;
}

/**
 复制文件

 @param scrPath <#scrPath description#>
 @param dstPath <#dstPath description#>
 @return <#return value description#>
 */
+ (BOOL)copyItemAtPath:(NSString *)scrPath toPath:(NSString *)dstPath{
    if ([self fileExistsAtPath:scrPath]) {
        return [[self defaultManager] copyItemAtPath:scrPath toPath:dstPath error:nil];
    }
    return NO;
}

@end

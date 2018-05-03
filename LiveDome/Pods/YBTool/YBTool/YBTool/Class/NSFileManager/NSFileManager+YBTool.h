//
//  NSFileManager+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/13.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (YBTool)

/**
 获取App沙盒根路径

 @return <#return value description#>
 */
+ (NSString *)getDirHome;

/**
 获取App_Documents路径

 @return <#return value description#>
 */
+ (NSString *)getDirDocumentsPath;

/**
 获取App_Library路径

 @return <#return value description#>
 */
+ (NSString *)getDirLibraryPath;

/**
 获取App_Cache路径

 @return <#return value description#>
 */
+ (NSString *)getDirCachePath;

/**
 获取App_Tmp根路径

 @return <#return value description#>
 */
+ (NSString *)getDirTmpPath;

/**
 路径文件是否存在

 @param path <#path description#>
 @return <#return value description#>
 */
+ (BOOL)fileExistsAtPath:(NSString *)path;

/**
 递归获取目录下所有文件名（文件和文件夹）

 @param path <#path description#>
 @return <#return value description#>
 */
+ (NSArray *)getSubpathsAtPath:(NSString *)path;

/**
 非递归获取目录下所有文件名（文件和文件夹）

 @param path <#path description#>
 @return <#return value description#>
 */
+ (NSArray *)getContentsOfDirectoryAtPath:(NSString *)path;

/**
 创建文件夹

 @param path <#path description#>
 @param dirName <#dirName description#>
 @return <#return value description#>
 */
+ (BOOL)createDirectoryAtPath:(NSString *)path dirName:(NSString *)dirName;

/**
 创建文件

 @param path <#path description#>
 @param fileName <#fileName description#>
 @return <#return value description#>
 */
+ (BOOL)createFileAtPath:(NSString *)path fileName:(NSString *)fileName;

/**
 写文件

 @param data <#data description#>
 @param path <#path description#>
 @param fileName <#fileName description#>
 @return <#return value description#>
 */
+ (BOOL)writeWithData:(NSData *)data toPath:(NSString *)path fileName:(NSString *)fileName;

/**
 读取文件

 @param path <#path description#>
 @return <#return value description#>
 */
+ (NSData *)readFileAtPath:(NSString *)path;

/**
 删除文件或文件夹

 @param path <#path description#>
 @return <#return value description#>
 */
+ (BOOL)deleteFileOrDicAtPath:(NSString *)path;

/**
 移动文件

 @param srcPath <#srcPath description#>
 @param dstPath <#dstPath description#>
 @return <#return value description#>
 */
+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;

/**
 复制文件

 @param scrPath <#scrPath description#>
 @param dstPath <#dstPath description#>
 @return <#return value description#>
 */
+ (BOOL)copyItemAtPath:(NSString *)scrPath toPath:(NSString *)dstPath;
@end

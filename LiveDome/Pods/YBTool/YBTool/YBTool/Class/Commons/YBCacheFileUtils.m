//
//  YBCacheFileUtils.m
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "YBCacheFileUtils.h"

@implementation YBCacheFileUtils
+ (void)archiveListObject:(id)objc
                 pathName:(NSString *)fileName
                   userId:(NSString*)userId{
    NSString * realfileName = fileName;
    NSString * path = realfileName = [NSString stringWithFormat:@"%@_%@",userId?:@"",fileName];
    path = [self cacheListPathwithFilename:realfileName];
    [NSKeyedArchiver archiveRootObject:objc toFile:path];
}

+ (instancetype)unarchivedListObjectwithFilePathName:(NSString *)fileName
                                              userId:(NSString*)userId{
    NSString * realfileName = fileName;
    NSString * path = realfileName = [NSString stringWithFormat:@"%@_%@",userId?:@"",fileName];
    path = [self cacheListPathwithFilename:realfileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

+ (BOOL)deleteListObjectwithFilePathName:(NSString *)fileName
                                  userId:(NSString*)userId{
    NSString * realfileName = fileName;
    NSString * path = realfileName = [NSString stringWithFormat:@"%@_%@",userId?:@"",fileName];;
    path = [self cacheListPathwithFilename:realfileName];
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

/**
 *  界面缓存
 *
 *  @return <#return value description#>
 */
+ (NSString *)cacheListPath{
    NSString * removeCache = [self canRemovePath];
    NSString * path = [removeCache stringByAppendingPathComponent:@"ListDataChe_cache"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    return path;
}

/**
 *  可以随时删除的缓存数据  不是很重要
 *
 *  @return <#return value description#>
 */
+ (NSString *)canRemovePath{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [documentPath stringByAppendingPathComponent:@"canRemove_cache"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    return path;
}
+ (NSString *)cacheListPathwithFilename:(NSString *)fileName{
    return [[self cacheListPath] stringByAppendingPathComponent:fileName];
}

+(BOOL)archiveModalObject:(id)objc withFilePath:(NSString *)path{
    return [NSKeyedArchiver archiveRootObject:objc toFile:path];
}

+(instancetype)unarchivedModalObjectwithPath:(NSString *)path{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}
@end

//
//  YBUtils.m
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "YBUtils.h"
#import <SDWebImage/SDWebImageManager.h>
#import <objc/runtime.h>
#import <MJExtension/MJExtension.h>
@implementation YBUtils
/**
 获取sdwebImage缓存  如果没有下载图片
 */
+(void)loadImageWithUrl:(NSString *)picUrl finishBlock:(ZYGetSDWebCacheWithFinishedBlock)finishBlock{
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:picUrl]];
    SDImageCache* cache = [SDImageCache sharedImageCache];
    //此方法会先从memory中取。
    UIImage * cacheImage = [cache imageFromCacheForKey:key];
    if (cacheImage) {
        finishBlock(cacheImage);
        return;
    }
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:picUrl] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (finished&&image) {
            [[SDWebImageManager sharedManager] saveImageToCache:image forURL:imageURL];
            
        }
        finishBlock(image);
    }];
    
}

/**
 动态获取一个类
 
 @param nameForclass 类名
 @param propertys 属性
 @return id类型  可能为nil  nil时是没有此类型
 */
+ (id)getClassWithClassName:(NSString *)nameForclass propertys:(NSDictionary *)propertys{
    // 类名
    NSString *class =[NSString stringWithFormat:@"%@", nameForclass];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass){
        return nil;//无此类
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    // 对该对象赋值属性
    if (propertys) {
        //mj 会便利所有属性  并没此属性的setValue不会出错  里面有相关判断操作
        [instance mj_setKeyValues:propertys];
    }
    return instance;
}

/**
 计算文字宽度
 
 @param text <#text description#>
 @param font <#font description#>
 @param height <#height description#>
 @return <#return value description#>
 */
+(CGFloat)textWidth:(NSString*)text font:(UIFont*)font height:(CGFloat)height{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    return [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:
            NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading attributes:attribute
                              context:nil].size.width;
}


/**
 计算文字高度
 
 @param text <#text description#>
 @param font <#font description#>
 @param width <#width description#>
 @return <#return value description#>
 */
+(CGFloat)textHeight:(NSString*)text font:(UIFont*)font width:(CGFloat)width{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    return [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:
            NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading attributes:attribute
                              context:nil].size.height;
}

/**
 判断创建归档文件夹
 
 @return <#return value description#>
 */
+(NSString*)judgeCreateybArchiveFolder{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/ybArchive"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"create ybArchiveFolder failure. info:%@",error.userInfo);
        }
    }
    return filePath;
}

/**
 归档
 
 @param object <#object description#>
 @param name <#fileName description#>
 @return <#return value description#>
 */
+(BOOL)yb_archiveWithObject:(id)object fileName:(NSString*)name{
    NSString *filePath = [[YBUtils judgeCreateybArchiveFolder] stringByAppendingPathComponent:name];
    return [NSKeyedArchiver archiveRootObject:object toFile:filePath];
}

/**
 解档
 
 @param name <#name description#>
 @return <#return value description#>
 */
+(id)yb_unArchiveWithFileName:(NSString*)name{
    NSString *filePath = [[YBUtils judgeCreateybArchiveFolder] stringByAppendingPathComponent:name];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

/**
 删除归档文件
 
 @param name <#name description#>
 @return <#return value description#>
 */
+(BOOL)yb_deleteArchiveWithFileName:(NSString*)name{
    NSString *filePath = [[YBUtils judgeCreateybArchiveFolder] stringByAppendingPathComponent:name];
    NSError *error;
    BOOL flag = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    if (error) {
        NSLog(@"delete ybArchive file failure. info:%@",error.userInfo);
    }
    return flag;
}

@end

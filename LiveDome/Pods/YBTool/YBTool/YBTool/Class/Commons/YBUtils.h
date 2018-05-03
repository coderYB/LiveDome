//
//  YBUtils.h
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YBUtils : NSObject
typedef void(^ZYGetSDWebCacheWithFinishedBlock)(UIImage *image);
/**
 获取sdwebImage缓存  如果没有下载图片
 */
+(void)loadImageWithUrl:(NSString *)picUrl finishBlock:(ZYGetSDWebCacheWithFinishedBlock)finishBlock;


/**
 动态获取一个类
 
 @param nameForclass 类名
 @param propertys 属性
 @return id类型  可能为nil  nil时是没有此类型
 */
+ (id)getClassWithClassName:(NSString *)nameForclass propertys:(NSDictionary *)propertys;


/**
 计算文字宽度
 
 @param text <#text description#>
 @param font <#font description#>
 @param height <#height description#>
 @return <#return value description#>
 */
+(CGFloat)textWidth:(NSString*)text font:(UIFont*)font height:(CGFloat)height;

/**
 计算文字高度
 
 @param text <#text description#>
 @param font <#font description#>
 @param width <#width description#>
 @return <#return value description#>
 */
+(CGFloat)textHeight:(NSString*)text font:(UIFont*)font width:(CGFloat)width;


/**
 归档
 
 @param object <#object description#>
 @param name <#fileName description#>
 @return <#return value description#>
 */
+(BOOL)yb_archiveWithObject:(id)object fileName:(NSString*)name;

/**
 解档
 
 @param name <#name description#>
 @return <#return value description#>
 */
+(id)yb_unArchiveWithFileName:(NSString*)name;

/**
 删除归档文件
 
 @param name <#name description#>
 @return <#return value description#>
 */
+(BOOL)yb_deleteArchiveWithFileName:(NSString*)name;

@end

//
//  VideoCompressTools.h
//  videoUpload
//
//  Created by zbwx on 2018/3/29.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 压缩成功之后的回调, 要将这个视频的路径传递出去

 @param compressVideoPath <#compressVideoPath description#>
 */
typedef void(^SuccessBlock)(NSString *compressVideoPath);

/**
 压缩失败之后的回调
 */
typedef void(^FailedBlock)(void);

/**
 压缩失败之后的回调
 */
typedef void(^NotSupportBlock)(void);

@interface 
VideoCompressTools : NSObject

/**
 压缩视频的方法

 @param sourceVideoPath <#sourceVideoPath description#>
 @param compressType <#compressType description#>
 @param compressSuccessBlock <#compressSuccessBlock description#>
 @param compressFailedBlock <#compressFailedBlock description#>
 @param compressNotSupportBlock <#compressNotSupportBlock description#>
 */
+ (void)compressVideoWithSourceVideoPath:(NSString *)sourceVideoPath
                            CompressType:(NSString *)compressType
                    CompressSuccessBlock:(SuccessBlock)compressSuccessBlock
                     CompressFailedBlock:(FailedBlock)compressFailedBlock
                 CompressNotSupportBlock:(NotSupportBlock)compressNotSupportBlock;

/**
 删除压缩视频, 比如说压缩视频在上传完成之后不再使用了, 可以将它删除掉

 @param compressVideoPath <#compressVideoPath description#>
 */
+ (void)deleteCompressVideoFromPath:(NSString *)compressVideoPath;

@end

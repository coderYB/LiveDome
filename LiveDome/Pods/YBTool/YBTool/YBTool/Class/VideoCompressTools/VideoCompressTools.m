//
//  VideoCompressTools.m
//  videoUpload
//
//  Created by zbwx on 2018/3/29.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "VideoCompressTools.h"
#import <AVFoundation/AVFoundation.h>

@implementation VideoCompressTools
/**
 压缩视频的方法
 
 @param sourceVideoPath <#sourceVideoPath description#>
 @param compressType <#compressType description#>
 @param compressSuccessBlock <#compressSuccessBlock description#>
 @param compressFailedBlock <#compressFailedBlock description#>
 @param compressNotSupportBlock <#compressNotSupportBlock description#>
 */
+ (void)compressVideoWithSourceVideoPath:(NSString *)sourceVideoPath CompressType:(NSString *)compressType CompressSuccessBlock:(SuccessBlock)compressSuccessBlock CompressFailedBlock:(FailedBlock)compressFailedBlock CompressNotSupportBlock:(NotSupportBlock)compressNotSupportBlock{
    // 源视频路径
    NSURL *sourceVideoPathUrl = [NSURL fileURLWithPath:sourceVideoPath];
    // 利用源视频路径将源视频转化为 AVAsset 多媒体载体对象
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:sourceVideoPathUrl options:nil];
    
    // 源视频载体对象支持的压缩格式
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    // 源视频载体对象支持的压缩格式中是否包含我们选择的压缩格式
    if ([compatiblePresets containsObject:compressType]) {
        
        // 存放压缩视频的文件夹
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *compressVideoFolder = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/compressVideoFolder"];
        if (![fileManager fileExistsAtPath:compressVideoFolder]) {
            
            [fileManager createDirectoryAtPath:compressVideoFolder withIntermediateDirectories:YES attributes:nil error:nil];
        }
        // 用当前系统时间给文件命名, 避免因名字重复而覆盖存储
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        NSString *currentDateString = [formatter stringFromDate:[NSDate date]];
        
        /**
         *  第一个参数 : 要压缩的 AVAsset 对象
         第二个参数 : 我们选择的压缩方式
         */
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:compressType];
        // 压缩视频的输出路径
        NSString *compressVideoPathString = [compressVideoFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"compressVideo-%@.mp4", currentDateString]];
        NSURL *compressFilePathUrl = [NSURL fileURLWithPath:compressVideoPathString];
        exportSession.outputURL = compressFilePathUrl;
        // 压缩文件的输出格式
        exportSession.outputFileType = AVFileTypeMPEG4;
        // 压缩文件应保证优化网络使用
        exportSession.shouldOptimizeForNetworkUse = YES;
        // 开始压缩
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void) {
            
            if (exportSession.status == AVAssetExportSessionStatusCompleted) {
                
                compressSuccessBlock(compressVideoPathString);
            }else {
                
                compressFailedBlock();
            }
        }];
    }else {
        
        compressNotSupportBlock();
    }
}
/**
 删除压缩视频, 比如说压缩视频在上传完成之后不再使用了, 可以将它删除掉
 
 @param compressVideoPath <#compressVideoPath description#>
 */
+ (void)deleteCompressVideoFromPath:(NSString *)compressVideoPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *compressVideoFolder = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/compressVideoFolder"];
    if ([fileManager fileExistsAtPath:compressVideoFolder]) {
        
        [fileManager removeItemAtPath:compressVideoFolder error:nil];
    }
}

@end

//
//  UIImageView+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "UIImageView+YBTool.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>
#import "UIImage+YBTool.h"
CGFloat const kLBBlurredImageDefaultBlurRadius            = 20.0;
CGFloat const kLBBlurredImageDefaultSaturationDeltaFactor = 1.8;
static BOOL noPic = NO;//是否省流量 不加载图片  暂放  以后有需求  放全局变量

@implementation UIImageView (YBTool)
- (void)yb_loadImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius{
    NSURL *url;
    //这里传CGFLOAT_MIN，就是默认以图片宽度的一半为圆角
    if (radius == CGFLOAT_MIN) {
        radius = self.frame.size.width/2.0;
    }
    
    url = [NSURL URLWithString:urlStr];
    
    if (radius != 0.0) {
        //头像需要手动缓存处理成圆角的图片
        NSString *cacheurlStr = [urlStr stringByAppendingString:@"radiusCache"];
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlStr];
        if (cacheImage) {
            self.image = cacheImage;
        } else {
            __weak typeof (self) tempSelf = self;
            [self sd_setImageWithURL:url placeholderImage:placeHolderStr?[UIImage imageNamed:placeHolderStr]:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
                    UIImage *radiusImage = [UIImage createRoundedRectImage:image size:tempSelf.frame.size radius:radius];
                    tempSelf.image = radiusImage;
                    [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:cacheurlStr completion:^{
                        //清除原有非圆角图片缓存
                        [[SDImageCache sharedImageCache] removeImageForKey:urlStr withCompletion:^{
                            
                        }];
                    }];
                }
            }];
        }
    }
    else {
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeHolderStr] completed:nil];
    }
}
- (void)yb_loadImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    [self sd_setImageWithURL:url placeholderImage:placeHolderStr?[UIImage imageNamed:placeHolderStr]:nil  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
- (void)yb_loadImageUrlStr:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    [self sd_setImageWithURL:url placeholderImage:nil  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
- (void)yb_loadImageUrlStr:(NSString *)urlStr radius:(CGFloat)radius{
    NSURL *url;
    //这里传CGFLOAT_MIN，就是默认以图片宽度的一半为圆角
    if (radius == CGFLOAT_MIN) {
        radius = self.frame.size.width/2.0;
    }
    
    url = [NSURL URLWithString:urlStr];
    
    if (radius != 0.0) {
        //头像需要手动缓存处理成圆角的图片
        NSString *cacheurlStr = [urlStr stringByAppendingString:@"radiusCache"];
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlStr];
        if (cacheImage) {
            self.image = cacheImage;
        }
        else {
            __weak typeof (self) tempSelf = self;
            [self sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
                    UIImage *radiusImage = [UIImage createRoundedRectImage:image size:tempSelf.frame.size radius:radius];
                    tempSelf.image = radiusImage;
                    [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:cacheurlStr completion:^{
                        [[SDImageCache sharedImageCache] removeImageForKey:urlStr withCompletion:^{
                            
                        }];
                    }];
                }
            }];
        }
    }else {
        [self sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
}

- (void)kkloadImageButControlUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr{
    
    if(noPic){
        [self yb_loadImageUrlStr:urlStr placeHolderImageName:placeHolderStr];
    }else{
        if (placeHolderStr) {
            self.image = [UIImage imageNamed:placeHolderStr];
        }
        
    }
}
- (void)kkloadImageButControlUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius{
    if(noPic){
        [self yb_loadImageUrlStr:urlStr placeHolderImageName:placeHolderStr radius:radius];
    }else{
        if (placeHolderStr) {
            self.image = [UIImage imageNamed:placeHolderStr];
        }
    }
    
}

/**
 设置图片
 
 @param name 图片名
 */
-(void)setImageWithName:(NSString*)name{
    [self setImage:YBNameImage(name)];
}

@end

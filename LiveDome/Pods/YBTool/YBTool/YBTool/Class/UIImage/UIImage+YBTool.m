//
//  UIImage+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "UIImage+YBTool.h"
#import <Accelerate/Accelerate.h>
#import <float.h>

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

@implementation UIImage (YBTool)
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r{
    CGSize cornerRadii = CGSizeMake(r,r);
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners:UIRectCornerAllCorners cornerRadii:cornerRadii];
    [cornerPath addClip];
    // Draw your image
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // Get the image, here setting the UIImageView image
    UIImage * newImage  = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/**
 图片合成
 
 @param topImage 上边图片
 @param bottomImage 上边图片
 @param margin 两者间隔
 @return <#return value description#>
 */
+ (UIImage *) combineWithTopImg:(UIImage*)topImage
                      bottomImg:(UIImage*)bottomImage
                     withMargin:(NSInteger)margin
                          scale:(CGFloat)scale{
    if (topImage == nil) {
        return topImage;
    }
    
    CGFloat width = topImage.size.width;
    CGFloat scaleHeight = bottomImage.size.height*topImage.size.width/bottomImage.size.width;
    CGSize offScreenSize = CGSizeMake(width, topImage.size.height+scaleHeight);
    
    // UIGraphicsBeginImageContext(offScreenSize);用这个重绘图片会模糊
    UIGraphicsBeginImageContextWithOptions(offScreenSize, NO, scale);
    
    CGRect rectT = CGRectMake(0, 0, width,topImage.size.height);
    [topImage drawInRect:rectT];
    
    CGRect rectB = CGRectMake(0, rectT.origin.y + topImage.size.height + margin, width, scaleHeight);
    [bottomImage drawInRect:rectB];
    
    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return imagez;
}

/**
 图片合成
 
 @param topImage 上边图片
 @param bottomImage 上边图片
 @param imageWidth 两者间隔
 @param scale <#scale description#>
 @return <#return value description#>
 */
+ (UIImage *) combineWithTopImg:(UIImage*)topImage
                      bottomImg:(UIImage*)bottomImage
                     ImageWidth:(float)imageWidth
                          scale:(CGFloat)scale{
    if (topImage == nil) {
        return topImage;
    }
    CGFloat width= imageWidth;
    CGFloat height = imageWidth*topImage.size.height/topImage.size.width + imageWidth*bottomImage.size.height/bottomImage.size.width;
    
    CGSize offScreenSize = CGSizeMake(width, height);
    
    // UIGraphicsBeginImageContext(offScreenSize);用这个重绘图片会模糊
    UIGraphicsBeginImageContextWithOptions(offScreenSize, NO, scale);
    
    CGRect rectT = CGRectMake(0, 0, width,imageWidth*topImage.size.height/topImage.size.width );
    [topImage drawInRect:rectT];
    
    CGRect rectB = CGRectMake(0, rectT.origin.y + imageWidth*topImage.size.height/topImage.size.width, width, imageWidth*bottomImage.size.height/bottomImage.size.width);
    [bottomImage drawInRect:rectB];
    
    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return imagez;
}
/**
 截取屏幕某一部分图片
 
 @param frame <#frame description#>
 @return <#return value description#>
 */
+(UIImage *)fullScreenshots:(CGSize)frame{
    
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContextWithOptions(frame, YES, [[UIScreen mainScreen] scale]);
    
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    return viewImage;
}
/**
 *  传入图片放缓一个像素大小的UIImage图片
 *
 *  @param color <#color description#>
 *
 *  @return <#return value description#>
 */
+(UIImage*)imageWithColor:(UIColor*)color{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, 1, 1);
    layer.backgroundColor=[color CGColor];
    [layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 压缩图片至目标尺寸
 
 @param sourceImage sourceImage 源图片
 @param targetWidth 图片最终尺寸的宽
 @return 返回按照源图片的宽、高比例压缩至目标宽、高的图片
 */
+(UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
//加水印
+ (instancetype)waterMarkWithImage:(UIImage *)backgroundImage markImage:(UIImage *)markImage location:(CGRect)markLocation{
    
    CGFloat sizeWith = backgroundImage.size.width;
    CGFloat sizeHeight = backgroundImage.size.height;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sizeWith, sizeHeight), NO, 0.0);
    [backgroundImage drawInRect:CGRectMake(0, 0, sizeWith, sizeHeight)];
    
    [markImage drawInRect:markLocation];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//等比缩放
+ (instancetype)scaleImage:(UIImage *)scaleImage toScale:(float)scaleSize{
    
    CGFloat sizeWith = scaleImage.size.width * scaleSize;
    CGFloat sizeHeight = scaleImage.size.height * scaleSize;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sizeWith, sizeHeight), NO, 0.0);
    
    [scaleImage drawInRect:CGRectMake(0, 0, sizeWith, sizeHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//自定义大小缩放
+ (instancetype)customSizeImage:(UIImage *)image customSize:(CGSize)customSize{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(customSize.width, customSize.height), NO, 0.0);
    
    [image drawInRect:CGRectMake(0, 0, customSize.width, customSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

// 自定义剪切后的图片
+ (instancetype)customCutImage:(UIImage *)image AtRect:(CGRect)rect{
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage* subImage = [UIImage imageWithCGImage: subImageRef];
    CGImageRelease(subImageRef);
    
    return subImage;
}

//根据颜色和大小获取一张图片
+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//对图片自定义角度旋转（以中心点为旋转点，以°为旋转单位，如90°）
+ (instancetype)customImageRotate:(UIImage *)image rotatedDegrees:(CGFloat)degrees{
    
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width / 2, -image.size.height / 2, image.size.width, image.size.height), image.CGImage);
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
}

//对图片自定义角度旋转（以中心点为旋转点,以M_PI为旋转单位，如M_PI/4.0）
+ (instancetype)customImageRotate:(UIImage *)image rotatedRadians:(CGFloat)radians{
    return [UIImage customImageRotate:image rotatedDegrees:RadiansToDegrees(radians)];
}

+ (instancetype)cutRoundimage:(UIImage *)image borderImage:(UIImage *)borderImage border:(int)border{
    
    CGSize size = CGSizeMake(image.size.width + border, image.size.height + border);
    
    //创建图片上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    //绘制边框的圆
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
    
    //剪切可视范围
    CGContextClip(context);
    
    //绘制边框图片
    [borderImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    //设置头像frame
    CGFloat iconX = border / 2;
    CGFloat iconY = border / 2;
    CGFloat iconW = image.size.width;
    CGFloat iconH = image.size.height;
    
    //绘制圆形头像范围
    CGContextAddEllipseInRect(context, CGRectMake(iconX, iconY, iconW, iconH));
    
    //剪切可视范围
    CGContextClip(context);
    
    //绘制头像
    [image drawInRect:CGRectMake(iconX, iconY, iconW, iconH)];
    
    //取出整个图片上下文的图片
    UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return iconImage;
}

//改变图片大小（不是压缩图片，会拉伸）
+ (instancetype)imageChangeSizeDrawWithImage:(UIImage *)image size:(CGSize)size{
    CGFloat destW = size.width;
    CGFloat destH = size.height;
    
    CGFloat sourceW = size.width;
    CGFloat sourceH = size.height;
    
    CGImageRef imageRef = image.CGImage;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,destW,destH, CGImageGetBitsPerComponent(imageRef), 4*destW, CGImageGetColorSpace(imageRef),(kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap,CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    
    UIImage *result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    return result;
}

//改变图片大小（不是压缩图片，不会拉伸）
+ (instancetype)imageChangeSizeUnDrawWithImage:(UIImage *)image size:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, size) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor){
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
            scaledWidth  = width * scaleFactor;
            scaledHeight = height * scaleFactor;
        }
        // center the image
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    // this is actually the interesting part:
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [image drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}

//获取圆角图片
+ (instancetype)getRadiusImage:(UIImage*)image size:(CGSize)size radius:(CGFloat)r{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    JYAddRadiusToPath(context, rect, r, r);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}

static void JYAddRadiusToPath(CGContextRef context, CGRect rect, float ovalWidth,float ovalHeight){
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0){
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

/* 根据UIView和大小生成图片*/
+ (instancetype)getImageWithView:(UIView *)view withSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

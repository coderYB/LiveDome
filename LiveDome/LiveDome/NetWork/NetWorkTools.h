//
//  NetWorkTools.h
//  LiveDome
//
//  Created by zbwx on 2018/5/2.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkTools : NSObject
/**
 *  普通的GET请求，并且将服务器返回的字典转换成json字符串进行返回
 *
 *  @param URLString  url
 *  @param parameters 参数字典
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GET:(nullable NSString *)URLString
 parameters:(nullable id)parameters
    success:(nullable void (^ )( id  _Nonnull json))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

/// POST请求 参数解释同上
+ (void)POST:(nullable NSString *)URLString
  parameters:(nullable id)parameters
     success:(nullable void (^ )(id  _Nonnull json))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;



+ (void)spec_GET:(nullable NSString *)URLString
      parameters:(nullable id)parameters
         success:(nullable void (^ )( id  _Nonnull json))success
         failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

//同时进行多个请求用这个
+ (void)async_GET:(nullable NSString *)URLString
       parameters:(nullable id)parameters
          success:(nullable void (^ )( id  _Nonnull json))success
          failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;


@end

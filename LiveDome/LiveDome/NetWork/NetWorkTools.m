//
//  NetWorkTools.m
//  LiveDome
//
//  Created by zbwx on 2018/5/2.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "NetWorkTools.h"

@implementation NetWorkTools
+ (AFHTTPSessionManager *)shareManager {
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
        
    });
    
    return manager;
}

+ (AFHTTPSessionManager *)manager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];;
    manager.securityPolicy.allowInvalidCertificates = true;
    
    return manager;
}


+ (void)GET:(nullable NSString *)URLString
 parameters:(nullable id)parameters
    success:(nullable void (^ )(  id  _Nonnull json))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    NSString * str = [[NSString stringWithFormat:@"%@",URLString]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[NetWorkTools shareManager] GET:str parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [ALERT hiddenHUD];
        if (success) {
            //服务器中获取到数据是字典形式的，这里习惯使用json字符串，进行解析
            NSError *error = nil;
            if (error != nil) {
                [ALERT showMessage:@"数据解析失败，请重新尝试"];
                return;
            }
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ALERT showMessage:@"请求失败，请检查网络,或者刷新频率过快"];
        if (failure) {
            failure(task,error);
        }
    }];
}

+ (void)spec_GET:(nullable NSString *)URLString
      parameters:(nullable id)parameters
         success:(nullable void (^ )(  id  _Nonnull json))success
         failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    
    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    if (status == AFNetworkReachabilityStatusNotReachable) {
        //(status == AFNetworkReachabilityStatusUnknown) ||
        [ALERT showMessage:@"网络连接失败~"];
        
        return;
    }
    [NetWorkTools shareManager].requestSerializer = [AFHTTPRequestSerializer serializer];
    [NetWorkTools shareManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [[NetWorkTools shareManager].requestSerializer setTimeoutInterval:3.0];
    [[NetWorkTools shareManager] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            //服务器中获取到数据是字典形式的，这里习惯使用json字符串，进行解析
            NSError *error = nil;
            if (error != nil) {
                [ALERT showMessage:@"数据解析失败，请重新尝试"];
                return;
            }
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ALERT showMessage:@"请求失败，请检查网络,或者刷新频率过快"];
        if (failure) {
            failure(task,error);
        }
    }];
}


+ (void)async_GET:(nullable NSString *)URLString
       parameters:(nullable id)parameters
          success:(nullable void (^ )( id  _Nonnull json))success
          failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure {
    
    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    if (status == AFNetworkReachabilityStatusNotReachable) {
        [ALERT showMessage:@"网络连接失败~"];
        return;
    }
    [[NetWorkTools manager] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ALERT hiddenHUD];
        if (success) {
            //服务器中获取到数据是字典形式的，这里习惯使用json字符串，进行解析
            NSError *error = nil;
            if (error != nil) {
                [ALERT showMessage:@"数据解析失败，请重新尝试"];
                return;
            }
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ALERT showMessage:@"请求失败，请检查网络,或者刷新频率过快"];
        if (failure) {
            failure(task,error);
        }
    }];
}

+ (void)POST:(nullable NSString *)URLString
  parameters:(nullable id)parameters
     success:(nullable void (^ )( id  _Nonnull json))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure {
    
    NSString * str = [[NSString stringWithFormat:@"%@",URLString]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [self shareManager];
    //    manager.securityPolicy.allowInvalidCertificates = true;
    //    [AFNetwork shareManager].requestSerializer = [AFJSONRequestSerializer serializer];
    //    [AFNetwork shareManager].responseSerializer = [AFJSONResponseSerializer serializer];
    //    [[AFNetwork shareManager].requestSerializer setTimeoutInterval:2.0];
    
    [manager POST:str parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ALERT hiddenHUD];
        if (success) {
            //服务器中获取到数据是字典形式的，这里习惯使用json字符串，进行解析
            NSError *error = nil;
            if (error != nil) {
                [ALERT showMessage:@"数据解析失败，请重新尝试"];
                return;
            }
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ALERT showMessage:@"请求失败，请检查网络"];
        if (failure) {
            failure(task,error);
        }
    }];
}

@end

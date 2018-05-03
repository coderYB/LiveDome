//
//  NSData+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YBTool)
/**
 *  aes265加密
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
- (NSData *)aes256_encrypt:(NSString *)key;

/**
 *  aes265 解密
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
- (NSData *)aes256_decrypt:(NSString *)key;

/**
 *  des加密
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
-(NSData*)desEncryptWithKey:(NSString*)key;

/**
 *  des解密
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
-(NSData*)desDecrypttWithKey:(NSString*)key;

/**
 *  转16进制字符串
 *
 *  @return <#return value description#>
 */
- (NSString*)encryptHex;

/**
 NSData-->String

 @return <#return value description#>
 */
- (NSString *)getString;


/**
 将APNS NSData类型token 格式化成字符串

 @return <#return value description#>
 */
- (NSString *)getAPNSToken;
@end

//
//  NSString+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (YBTool)

/**
 字符串是否为空的 空：YES 否：NO

 @param string <#string description#>
 @return <#return value description#>
 */
+ (BOOL)isEmptyWithString:(NSString *)string;

/**
 是否包含字符串

 @param string <#string description#>
 @return <#return value description#>
 */
- (BOOL)containString:(NSString *)string;

/**
 是否包含中文字符

 @return <#return value description#>
 */
- (BOOL)containsChineseCharacter;

/**
 判断字符串是否是条码

 @return <#return value description#>
 */
- (BOOL)isBarcode;


/**
 判断是否是url

 @return <#return value description#>
 */
- (BOOL)isUrl;

/**
 根据身份证号获取生日:YYYY-MM-dd字符串

 @return <#return value description#>
 */
- (NSString *)birthdayWithIdCard;

/**
 验证密码格式，数字，字母，符号组合验证

 @return <#return value description#>
 */
- (BOOL)isPassWord;

/**
 *  判断身份证号码是否正确
 *
 *  @return <#return value description#>
 */
-(BOOL)validateIDCardNumber;
/**
 *  判断是否为手机号码
 *
 *  @return <#return value description#>
 */
-(BOOL)validatePhoneNumber;
/**
 *  简单的11位手机号码校验
 *
 *  @return <#return value description#>
 */
-(BOOL)simpleValidatePhone;
/**
 *  判断是否为身份证
 *
 *  @return <#return value description#>
 */
-(BOOL) validateIdentityCard;
/**
 *  判断是否为车牌号
 *
 *  @return <#return value description#>
 */
-(BOOL) validateCarNo;
/**
 *  判断是否为邮箱
 *
 *  @return <#return value description#>
 */
-(BOOL) validateEmail;
/**
 *  字符串去首位空格
 *
 *  @return <#return value description#>
 */
-(NSString*)trim;

/**
 *  SHA1加密
 *
 *  @return <#return value description#>
 */
-(NSString*)sha1;

/**
 *  SHA256加密
 *
 *  @return <#return value description#>
 */
- (NSString *)sha256;

/**
 *  SHA384加密
 *
 *  @return <#return value description#>
 */
- (NSString *)sha384;

/**
 *  SHA512加密
 *
 *  @return <#return value description#>
 */
- (NSString *)sha512;

/**
 *  url编码
 *
 *  @return <#return value description#>
 */
-(NSString*)urlEncode;
/**
 *  url解码
 *
 *  @return <#return value description#>
 */
-(NSString*)urlDecode;
/**
 *  md5
 *
 *  @return <#return value description#>
 */
-(NSString*)md5;


/**
 DES+Base64加密
 
 @param key <#key description#>
 @return <#return value description#>
 */
- (NSString *)desEncryptWithKey:(NSString*)key;

/**
 DES+Base64解密
 
 @param key <#key description#>
 @return <#return value description#>
 */
- (NSString *)desDecryptWithKey:(NSString*)key;

/**
 AES加密
 
 @param key <#key description#>
 @return <#return value description#>
 */
- (NSString *)aesEncryptWitKey:(NSString*)key;

/**
 AES解密
 
 @param key <#key description#>
 @return <#return value description#>
 */
- (NSString *)aesDecryptWitKey:(NSString*)key;

/**
 *  base64编码
 *
 *  @return <#return value description#>
 */
-(NSString*)base64Encoding;
/**
 *  base64解码
 *
 *  @return <#return value description#>
 */
-(NSString*)base64Decodeing;

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters;
/**
 将某段字符串处理成带富文本属性的字符串
 
 @param partOfStr 需要将字符串中那些子串进行处理
 @param color 处理成的颜色
 @param font 处理成的字体
 @return <#return value description#>
 */
- (NSMutableAttributedString *)mutableAttributedStringWithPartStr:(NSString *)partOfStr changeToColor:(UIColor *)color font:(UIFont *)font;
- (NSMutableAttributedString *)mutableAttributedStringWithPartStrRange:(NSRange)range changeToColor:(UIColor *)color font:(UIFont *)font;

/**
 *  给字符串增加千位符
 *
 *  @param digitString <#digitString description#>
 *
 *  @return <#return value description#>
 */

+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString;

/**
 设备唯一标识符

 @return <#return value description#>
 */
+ (NSString *)getUUID;


/**
 获取字符串所占size(font,限制最大size)

 @param font <#font description#>
 @param constrainSize <#constrainSize description#>
 @return <#return value description#>
 */
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)constrainSize;


/**
 NSString转为NSData

 @return <#return value description#>
 */
- (NSData *)getData;


/**
 NSString转为Char

 @return <#return value description#>
 */
- (const char *)getChar;
@end

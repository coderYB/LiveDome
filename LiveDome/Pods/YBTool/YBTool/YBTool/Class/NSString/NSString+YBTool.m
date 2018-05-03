//
//  NSString+YBTool.m
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "NSString+YBTool.h"

#import <AdSupport/AdSupport.h>
#import "NSData+YBTool.h"
#import "UIColor+YBTool.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
@implementation NSString (YBTool)

/**
 字符串是否为空的 空：YES 否：NO

 @param string <#string description#>
 @return <#return value description#>
 */
+ (BOOL)isEmptyWithString:(NSString *)string{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/**
 是否包含字符串

 @param string <#string description#>
 @return <#return value description#>
 */
- (BOOL)containString:(NSString *)string{
    if (![NSString isEmptyWithString:self]) {
        return ([self rangeOfString:string].location == NSNotFound) ? NO : YES;
    }
    return NO;
}

/**
 是否包含中文字符

 @return <#return value description#>
 */
- (BOOL)containsChineseCharacter {
    for (int i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FFF) {
            return YES;
        }
    }
    return NO;
}

/**
 判断字符串是否是条码

 @return <#return value description#>
 */
- (BOOL)isBarcode {
    NSString *numberRegex = @"^[0-9]*$";
    NSPredicate *numPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numPre evaluateWithObject:self];
}

/**
 判断是否是url

 @return <#return value description#>
 */
- (BOOL)isUrl {
    NSString *regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

/**
 验证密码格式，数字，字母，符号组合验证

 @return <#return value description#>
 */
- (BOOL)isPassWord {
    NSString *phoneRegex = @"^[A-Za-z0-9!$#%@^&*_-~)(/.,\';+:]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

/**
 根据身份证号获取生日:YYYY-MM-dd字符串

 @return <#return value description#>
 */
- (NSString *)birthdayWithIdCard {
    if ([self validateIDCardNumber]) {
        NSMutableString *result = [NSMutableString stringWithCapacity:0];
        NSString *year = nil;
        NSString *month = nil;
        NSString *day = nil;
        
        year = [self substringWithRange:NSMakeRange(6, 4)];
        month = [self substringWithRange:NSMakeRange(10, 2)];
        day = [self substringWithRange:NSMakeRange(12, 2)];
        
        [result appendString:year];
        [result appendString:@"-"];
        [result appendString:month];
        [result appendString:@"-"];
        [result appendString:day];
        return result;
    }
    return nil;
}


/**
 *  判断身份证号码是否正确
 *
 *  @return <#return value description#>
 */
-(BOOL)validateIDCardNumber{
    NSString  *value = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
            case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            regularExpression = nil;
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
            case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            regularExpression = nil;
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}

/**
 *  判断是否为手机号码
 *
 *  @return <#return value description#>
 */
-(BOOL)validatePhoneNumber{
    NSString * MOBILE = @"^1(3[0-9]|4[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|77|8[019])[0-9]|349)\\d{7}$";
    
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    BOOL res1 = [regextestmobile evaluateWithObject:self];
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    BOOL res5 = [regextestphs evaluateWithObject:self];
    
    if (res1 || res2 || res3 || res4 ||res5) {
        return YES;
    }else{
        return NO;
    }
}
/**
 *  简单的11位手机号码校验
 *
 *  @return <#return value description#>
 */

-(BOOL)simpleValidatePhone{
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^\\d{11}$"];
    if ([regextestmobile evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}
/**
 *  身份证号
 *
 *  @return <#return value description#>
 */
-(BOOL) validateIdentityCard{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

/**
 *  车牌号验证
 *
 *  @return <#return value description#>
 */
-(BOOL) validateCarNo{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}

/**
 *  邮箱
 *
 *  @return <#return value description#>
 */
-(BOOL) validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
/**
 *  字符串去首位空格
 *
 *  @return <#return value description#>
 */
-(NSString*)trim{
    NSString *tmp = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [tmp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//SHA1加密
-(NSString*)sha1{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}
/**
 *  SHA256加密
 *
 *  @return <#return value description#>
 */
- (NSString *)sha256{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

/**
 *  SHA384加密
 *
 *  @return <#return value description#>
 */
- (NSString *)sha384{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

/**
 *  SHA512加密
 *
 *  @return <#return value description#>
 */
- (NSString *)sha512{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

/**
 *  url编码
 *
 *  @return <#return value description#>
 */
-(NSString*)urlEncode{
    return (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                  (CFStringRef)self,
                                                                                  NULL,
                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                  kCFStringEncodingUTF8));
}
/**
 *  url解码
 *
 *  @return <#return value description#>
 */
-(NSString*)urlDecode{
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
}

/**
 *  md5
 *
 *  @return <#return value description#>
 */
-(NSString*)md5{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

/**
 DES+Base64加密
 
 @param key <#key description#>
 @return <#return value description#>
 */
- (NSString *)desEncryptWithKey:(NSString*)key{
    return [self encrypt:self encryptOrDecrypt:kCCEncrypt key:key];
}

/**
 DES+Base64解密
 
 @param key <#key description#>
 @return <#return value description#>
 */
- (NSString *)desDecryptWithKey:(NSString*)key{
    //kCCDecrypt 解密
    return [self encrypt:self encryptOrDecrypt:kCCDecrypt key:key];
}

/**
 *  DES+Base64加密解密中间方法
 *
 *  @param sText            <#sText description#>
 *  @param encryptOperation <#encryptOperation description#>
 *  @param key              <#key description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key{
    const void *vplainText;
    size_t plainTextBufferSize;
    NSData *data = [sText dataUsingEncoding:NSUTF8StringEncoding];
    if (encryptOperation == kCCDecrypt){//解密
        NSData *encryptData = [[NSData alloc] initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
        plainTextBufferSize = [encryptData length];
        vplainText = [encryptData bytes];
    }else{//加密
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    // const void *vkey = (const void *)[DESKEY UTF8String];
    const void *vkey = (const void *)[[key dataUsingEncoding:NSUTF8StringEncoding] bytes];
    // NSString *initVec = @"init Vec";
    //const void *vinitVec = (const void *) [initVec UTF8String];
    //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    ccStatus = CCCrypt(encryptOperation,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    NSString *result;
    
    if (encryptOperation == kCCDecrypt){
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                               length:(NSUInteger)movedBytes]
                                       encoding:NSUTF8StringEncoding];
    }else{
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        return [myData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    
    return result;
}

/**
 AES加密
 
 @param key <#key description#>
 @return <#return value description#>
 */
- (NSString *)aesEncryptWitKey:(NSString*)key{
    NSData *data = [[self dataUsingEncoding:NSUTF8StringEncoding] aes256_encrypt:key];
    NSString *aesEncryp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return aesEncryp;
}


/**
 AES解密
 
 @param key <#key description#>
 @return <#return value description#>
 */
- (NSString *)aesDecryptWitKey:(NSString*)key{
    return [[NSString alloc] initWithData:[[self dataUsingEncoding:NSUTF8StringEncoding] aes256_encrypt:key] encoding:NSUTF8StringEncoding];
}
/**
 *  base64编码
 *
 *  @return <#return value description#>
 */
-(NSString*)base64Encoding{
    NSString *encodeString = [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //去掉oc自带算法的换行符
    encodeString = [encodeString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return encodeString;
}

/**
 *  base64解码
 *
 *  @return <#return value description#>
 */
-(NSString*)base64Decodeing{
    NSString *string =  [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters] encoding:NSUTF8StringEncoding];
    return string;
}


/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters{
    // 查找参数
    NSRange range = [self rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 截取参数
    NSString *parametersString = [self substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            id existValue = [params valueForKey:key];
            if (existValue != nil) {
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
            } else {
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        // 设置值
        [params setValue:value forKey:key];
    }
    return params;
}
/**
 将某段字符串处理成带富文本属性的字符串
 
 @param partOfStr 需要将字符串中那些子串进行处理
 @param color 处理成的颜色
 @param font 处理成的字体
 @return <#return value description#>
 */
- (NSMutableAttributedString *)mutableAttributedStringWithPartStr:(NSString *)partOfStr changeToColor:(UIColor *)color font:(UIFont *)font{
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    if(partOfStr.length){
        [attrStr addAttribute:NSFontAttributeName value:font range:[self rangeOfString:partOfStr]];
        [attrStr addAttribute:NSForegroundColorAttributeName value:color range:[self rangeOfString:partOfStr]];
    }
    return attrStr;
}


- (NSMutableAttributedString *)mutableAttributedStringWithPartStrRange:(NSRange)range changeToColor:(UIColor *)color font:(UIFont *)font{
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttribute:NSFontAttributeName value:font range:range];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attrStr;
}

/**
 *  给字符串增加千位符
 *
 *  @param digitString <#digitString description#>
 *
 *  @return <#return value description#>
 */

+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString{
    
    if (digitString.length <= 6) {
        return digitString;
    } else {
        NSString *string=[digitString substringToIndex:digitString.length-3];
        
        NSMutableString *processString = [NSMutableString stringWithString:string];
        NSInteger location = processString.length - 3;
        NSMutableArray *processArray = [NSMutableArray array];
        while (location >= 0) {
            NSString *temp = [processString substringWithRange:NSMakeRange(location, 3)];
            [processArray addObject:temp];
            if (location < 3 && location > 0)
            {
                NSString *t = [processString substringWithRange:NSMakeRange(0, location)];
                [processArray addObject:t];
            }
            location -= 3;
        }
        NSMutableArray *resultsArray = [NSMutableArray array];
        int k = 0;
        for (NSString *str in processArray)
        {
            k++;
            NSMutableString *tmp = [NSMutableString stringWithString:str];
            if (str.length > 2 && k < processArray.count )
            {
                [tmp insertString:@"," atIndex:0];
                [resultsArray addObject:tmp];
            } else {
                [resultsArray addObject:tmp];
            }
        }
        NSMutableString *resultString = [NSMutableString string];
        for (NSInteger i = resultsArray.count - 1 ; i >= 0; i--)
        {
            NSString *tmp = [resultsArray objectAtIndex:i];
            [resultString appendString:tmp];
        }
        return [resultString stringByAppendingString:[digitString substringFromIndex:digitString.length-3]];
    }
    
}

/**
 设备唯一标识符

 @return <#return value description#>
 */
+ (NSString *)getUUID{
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        if (idfa) {
            return idfa;
        } else {
            NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            return idfv;
        }
    } else {
        NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        return idfv;
    }
}

/**
 获取字符串所占size(font,限制最大size)

 @param font <#font description#>
 @param constrainSize <#constrainSize description#>
 @return <#return value description#>
 */
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)constrainSize{
    CGSize size = CGSizeZero;
    CGRect rect = [self boundingRectWithSize:constrainSize
                                     options:NSStringDrawingTruncatesLastVisibleLine
                   | NSStringDrawingUsesFontLeading
                   | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName : font}
                                     context:nil];
    size = rect.size;
    return size;
}

/**
 NSString转为NSData
 
 @return <#return value description#>
 */
- (NSData *)getData{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}


/**
 NSString转为Char
 
 @return <#return value description#>
 */
- (const char *)getChar{
    return [self UTF8String];
}
@end

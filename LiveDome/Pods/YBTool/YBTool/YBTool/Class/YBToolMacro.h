//
//  YBToolMacro.h
//  YBTool
//
//  Created by zbwx on 2018/4/12.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#ifndef YBToolMacro_h
#define YBToolMacro_h

//判断与相应的屏幕比例是否一致
#define SCALE_TO_SCREEN(w,h) [[NSString stringWithFormat:@"%0.5f",UIScreen.mainScreen.bounds.size.width/UIScreen.mainScreen.bounds.size.height] isEqualToString:[NSString stringWithFormat:@"%0.5f",w/h]]
//3.5寸屏比例
#define SCALE_3_5INCH SCALE_TO_SCREEN(640.f,960.f)
//4.7寸屏比例
#define SCALE_4INCH_SCREEN SCALE_TO_SCREEN(640.f,1136.f)
//5寸屏比例
#define SCALE_4_7INCH_SCREEN SCALE_TO_SCREEN(750.f,1334.f)
//5.5寸屏比例
#define SCALE_5_5INCH_SCREEN SCALE_TO_SCREEN(1242.f,2208.f)
//iPhone X屏幕比例
#define SCALE_IPHONE_X_SCREEN SCALE_TO_SCREEN(1125.f,2436.f)


//app框架高度
#define APP_FRAME_HEIGHT [[UIScreen mainScreen] applicationFrame].size.height
//app框架宽度
#define APP_FRAME_WIDTH [[UIScreen mainScreen] applicationFrame].size.width
//屏幕的尺寸
#define SCREEN_SIZE ([[UIScreen mainScreen] bounds]).size
//屏幕高度
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds]).size.height
//屏幕宽度
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds]).size.width

//沙盒目录
#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//应用keyWindow
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow


//文件根目录归档
#define YBArchive(object,name) [YBUtils yb_archiveWithObject:object fileName:name]
//文件根目录解档
#define YBUnArchive(name) [YBUtils yb_unArchiveWithFileName:name]
//删除根目录下的文件
#define YBDeleteArchiveFile(name) [YBUtils yb_deleteArchiveWithFileName:name]



#endif /* YBToolMacro_h */

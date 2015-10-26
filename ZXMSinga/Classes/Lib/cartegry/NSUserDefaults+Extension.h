//
//  NSUserDefaults+Extension.h
//  ZXMSinga
//
//  Created by  周学明 on 15/10/26.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZXVersionInShaBox @"versionInShaBox"


@interface NSUserDefaults (Extension)

//保存当期版本信息到沙盒
+ (void)saveCurrentVersion;


// 从沙盒获取版本号
+ (NSString *)versionFromShaBox;


//从info.plist 文件里面获取版本号
+ (NSString *)versionFromInfo;


@end

//
//  NSUserDefaults+Extension.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/26.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "NSUserDefaults+Extension.h"

@implementation NSUserDefaults (Extension)


//保存当期版本信息到沙盒
+ (void)saveCurrentVersion
{
//    获取info文件里面的版本信息
    NSString * currentVersion = [self versionFromInfo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentVersion forKey:ZXVersionInShaBox];
//    同步更新
    [defaults synchronize];
    
}



// 从沙盒获取版本号
+ (NSString *)versionFromShaBox
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:ZXVersionInShaBox];
    
}

//从info.plist 文件里面获取版本号
+ (NSString *)versionFromInfo
{
//    获取info
    NSDictionary * info = [NSBundle mainBundle].infoDictionary;
    NSString *bundleInfo = (__bridge NSString *)kCFBundleVersionKey;
    NSString * currentVersion = info[bundleInfo];
//    返回当前的版本信息
    return currentVersion;
    
}



@end

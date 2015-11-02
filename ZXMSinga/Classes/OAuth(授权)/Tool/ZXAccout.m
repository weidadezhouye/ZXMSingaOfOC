//
//  ZXAccout.m
//  ZXMSinga
//
//  Created by  周学明 on 15/11/2.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXAccout.h"


static ZXAccout *accout = nil;

@implementation ZXAccout


//提供创建单例的方法
+ (instancetype)shareAccout{
    
    if (accout==nil)
    {
        accout = [[ZXAccout alloc] init];
    }
    return accout;
}

//实现单例
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t outon;
    dispatch_once(&outon, ^{
        
        accout = [super allocWithZone:zone];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        accout.access_token =  [defaults objectForKey:@"access_token"];
        accout.expires_in =  [defaults objectForKey:@"expires_in"];
        accout.remind_in =  [defaults objectForKey:@"remind_in"];
        accout.uid =  [defaults objectForKey:@"uid"];
        
        
    });
    return accout;
    
}

//是否登录
- (BOOL)isLogin
{
    return self.access_token.length;
}

//保存数据到偏好设置
- (void)saveAccoutToShaBox
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.access_token forKey:@"access_token"];
    
    [defaults setObject:self.expires_in forKey:@"expires_in"];
    
    [defaults setObject:self.remind_in forKey:@"remind_in"];
    
    [defaults setObject:self.uid forKey:@"uid"];
    
    [defaults synchronize];
    
}




@end

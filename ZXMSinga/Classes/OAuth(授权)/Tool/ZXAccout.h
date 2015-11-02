//
//  ZXAccout.h
//  ZXMSinga
//
//  Created by  周学明 on 15/11/2.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXAccout : NSObject

/*
 access_token	string	用于调用access_token，接口获取授权后的access token。
 expires_in	    string	access_token的生命周期，单位是秒数。
 remind_in	    string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
 uid	        string  当前授权用户的UID。
 */

@property(nonatomic,copy) NSString *access_token;

@property(nonatomic,copy) NSString *expires_in;

@property(nonatomic,copy) NSString *remind_in;

@property(nonatomic,copy) NSString *uid;

//判断是否登录
- (BOOL)isLogin;

//保存数据到沙盒
- (void)saveAccoutToShaBox;

//创建单例
+ (instancetype)shareAccout;



@end

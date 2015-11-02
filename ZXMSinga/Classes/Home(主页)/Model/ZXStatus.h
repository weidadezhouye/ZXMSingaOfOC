//
//  ZXStatus.h
//  ZXMSinga
//
//  Created by  周学明 on 15/11/2.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZXUser;

@interface ZXStatus : NSObject

/**
 *  微博创建时间
 */
@property (nonatomic,copy) NSString * created_at;


/**
 *  字符串型的微博ID
 */
@property (nonatomic,copy) NSString * idstr;

/**
 *  	微博信息内容
 */
@property (nonatomic,copy) NSString * text;
/**
 *  微博来源
 */
@property (nonatomic,copy) NSString * source;

/**
 *  缩略图片地址，没有时不返回此字段
 */
@property (nonatomic,copy) NSString *thumbnail_pic;

//用户模型
@property(nonatomic,strong) ZXUser *user;


@end

//
//  ZXUser.h
//  ZXMSinga
//
//  Created by  周学明 on 15/11/2.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXUser : NSObject

//用户昵称
@property(nonatomic,copy) NSString * screen_name;

//用户头像地址（中图），50×50像素
@property(nonatomic,copy) NSString * profile_image_url;

//字符串型的用户UID
@property(nonatomic,copy) NSString * idstr;




@end

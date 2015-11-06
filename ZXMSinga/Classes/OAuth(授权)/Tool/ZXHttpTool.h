//
//  ZXHttpTool.h
//  ZXMSinga
//
//  Created by  周学明 on 15/11/6.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXHttpTool : NSObject

//网络工具类处理get请求
+ (void) GET:(NSString *)url parameters:(id)params
         success:(void (^)( id responseObject))success
         failure:(void (^)(NSError *error))failure;


//网络工具类处理post请求
+ (void) POST:(NSString *)url parameters:(id)params
     success:(void (^)( id responseObject))success
     failure:(void (^)(NSError *error))failure;


@end

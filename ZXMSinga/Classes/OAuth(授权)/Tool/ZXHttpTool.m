//
//  ZXHttpTool.m
//  ZXMSinga
//
//  Created by  周学明 on 15/11/6.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXHttpTool.h"
#import "AFNetworking.h"

@implementation ZXHttpTool

+ (void) GET:(NSString *)url parameters:(id)params
     success:(void (^)( id responseObject))success
     failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success)
        {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(error)
        {
            failure(error);
        }
    }];
    
}



+ (void) POST:(NSString *)url parameters:(id)params
      success:(void (^)( id responseObject))success
      failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success)
        {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(error)
        {
            failure(error);
        }
    }];
    
}


@end

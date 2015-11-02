//
//  ZXOAuthController.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/31.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXOAuthController.h"
#import "AFNetworking.h"
#import "ZXAccout.h"
#import "ZXTabBarController.h"


@interface ZXOAuthController ()<UIWebViewDelegate>




@end

@implementation ZXOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
//   创建webview
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    
    [self.view addSubview:webView];
    
//    设置它的代理
    webView.delegate = self;
//    拼接webView的路径
//    NSString *clientid = @"2003436477";
//    NSString *redirecturi = @"http://www.baidu.com";
//    学明博客
//   https://api.weibo.com/oauth2/authorize?client_id=2003436477&redirect_uri=http://www.baidu.com
    

    
    NSString *urlStr =  [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",zxClientId,zxRedirectUri];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    
} 



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if([request.URL.absoluteString hasPrefix:zxRedirectUri]){
        
        NSString *code = [request.URL.query componentsSeparatedByString:@"="][1];
        NSLog(@"授权成功code = %@",code);
        [self getAccessTokenWithCode:code];
    }

#warning 先返回一个yes来显示一下效果
    return YES;
}


//获取AccessToken
- (void)getAccessTokenWithCode:(NSString *)code
{
    NSString *accessTokenUrl = @"https://api.weibo.com/oauth2/access_token";
//    创建
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"client_id"] =  zxClientId;
    dict[@"client_secret"] = zxClientSecret;
    dict[@"grant_type"] = zxGrantType;
    dict[@"code"] = code;
    dict[@"redirect_uri"] = zxRedirectUri;
//    发送POST请求
    [manager POST:accessTokenUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * respStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",respStr);
        ZXAccout *accout = [ZXAccout objectWithJSONData:responseObject];
        
//        登录成功
        if(accout.access_token)
        {
            [accout saveAccoutToShaBox];
//            跳转控制器
            ZXTabBarController *tabVc = [[ZXTabBarController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabVc;
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}


@end

//
//  ZXComposeController.m
//  ZXMSinga
//
//  Created by  周学明 on 15/11/5.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXComposeController.h"
#import "ZXToolBar.h"
#import "ZXTextView.h"
#import "ZXStatus.h"
#import "ZXUser.h"
#import "ZXAccout.h"

@interface ZXComposeController ()<UITextViewDelegate>

//工具条
@property(nonatomic,strong)ZXToolBar *toolBar;

//文本框
@property(nonatomic,strong) ZXTextView *textView;



@end

@implementation ZXComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self prepareUI];
    
    [self keyboardNotification];
    
}

////通知监听键盘值的改变
//- (void)keyboardFrameWillChange:(NSNotification *)notification
//{
//    NSDictionary *keyAtt = notification.userInfo;
//    ZXLog(@"%@",keyAtt);
//    CGRect rect = [keyAtt[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
//    double duration = [keyAtt[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
//    CGFloat newToolBarY = rect.size.height;
//    [UIView animateWithDuration:duration animations:^{
//        
//        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -newToolBarY);
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//    
//}

//准备控件
- (void)prepareUI{
    [self setupNavgationBar];
    
    
    [self setupTextView];
    
    [self setupToolBar];
    
    
}

#pragma mark - 导航栏按钮处理
//设置导航条按钮
- (void)setupNavgationBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barBtnWithTitle:@"取消" target:self action:@selector(cancelBtnClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnWithTitle:@"发送" target:self action:@selector(sendBtnClick)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UILabel * titleLab = [[UILabel alloc] init];
    NSString *name = [[ZXUser alloc] init].screen_name;
    NSString *lib = @"发微博";
#warning 此处还需要获取昵称！
    if([ZXAccout shareAccout].isLogin)
    {
        lib = [NSString stringWithFormat:@"%@\n%@",lib,name];
        
    }
    else
    {
        lib = [NSString stringWithFormat:@"%@\n无名小辈",lib];
    }
    
    titleLab.numberOfLines = 0;
    titleLab.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    titleLab.textColor = [UIColor orangeColor];
    titleLab.text = lib;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:titleLab];
    self.navigationItem.titleView = titleLab;

}

//取消按钮的点击
- (void)cancelBtnClick{
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//发送按钮的点击
- (void)sendBtnClick{
    //    发送
    NSString *url = @"https://api.weibo.com/2/statuses/update.json";
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"access_token"] = [ZXAccout shareAccout].access_token;
    parame[@"status"] = self.textView.text;

    //    get请求数据
    [manager POST:url parameters:parame success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]])
        {
            ZXStatus *status = [ZXStatus objectWithKeyValues:responseObject];
            
            if(status.idstr){
//                发送成功
                ZXLog(@"发送成功");
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZXLog(@"%@",error);
    }];
    

    

}

#pragma mark - 设置toolBar
//设置toolBar
- (void)setupToolBar
{
    ZXToolBar *toolBar = [[ZXToolBar alloc] init];
    
    
    toolBar.bounds = CGRectMake(0, 0, self.view.w, 44);
    toolBar.y = self.view.h - toolBar.h;
    toolBar.x = 0;
    
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;

}

#pragma mark - 设置textView
- (void)setupTextView
{
    ZXTextView * textView = [[ZXTextView alloc] init];
    textView.placeHolder = @"写点什么吧";
    textView.placeHolderColor = [UIColor redColor];
    textView.backgroundColor = [UIColor blueColor];
    textView.font = [UIFont systemFontOfSize:18];
    
    textView.frame = self.view.bounds;
//    设置它可以上下滑动
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    
}

#pragma mark -键盘通知
-(void)keyboardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)kbWillShow:(NSNotification *)notifi{
    //改变toolbar的y = > 间接使用transfrom
    // 1.获取键盘高度
    double duration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
    // 2.键盘rect
    CGRect kbRect = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat kbHeihgt = kbRect.size.height;
    
    
    [UIView animateWithDuration:duration animations:^{
        //让toolbar 往上移 键盘高度
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -kbHeihgt);
    }];
    
    
    
    
}

-(void)kbWillHide:(NSNotification *)notifi{
    double duration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
    
    [UIView animateWithDuration:duration animations:^{
        //让toolbar 恢复原位
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
    
    
}




#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length > 0;
}




#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}




- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

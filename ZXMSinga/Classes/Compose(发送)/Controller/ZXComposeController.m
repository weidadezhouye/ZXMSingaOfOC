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
#import "ZXComposePictureView.h"
#import "ZXStatusBar.h"


@interface ZXComposeController ()<UITextViewDelegate,ZXToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

//工具条
@property(nonatomic,strong)ZXToolBar *toolBar;

//文本框
@property(nonatomic,strong) ZXTextView *textView;

//监听键盘是否弹出
@property(nonatomic,assign,getter=isKeyBoardShowing) BOOL keyBoardShowing;

//图片View
@property(nonatomic,strong) ZXComposePictureView *pictureView;

//记录发送微博的结果
@property(nonatomic,copy) NSString *result;


@end

@implementation ZXComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor purpleColor];
    
    [self prepareUI];
    
    [self keyboardNotification];
//    一进去就弹出键盘
    [self.textView becomeFirstResponder];
    
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

#pragma mark - 发送微博数据的网络请求
//发送按钮的点击
- (void)sendBtnClick{
    
    [ZXStatusBar showStatusBarWith:@"正在发送微博>>>"];
    
//    先判断是否有图片
  if(self.pictureView.hasImage)
  {
      [self sendWithImage];
  }else
  {
      [self sendWithOutImage];
  }

    

}

//发送只有文字不带图片的微博
- (void)sendWithOutImage
{
    //    发送
    NSString *url = @"https://api.weibo.com/2/statuses/update.json";
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"access_token"] = [ZXAccout shareAccout].access_token;
    parame[@"status"] = self.textView.text;
    
    //    get请求数据
    [ZXHttpTool POST:url parameters:parame success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]])
        {
            ZXStatus *status = [ZXStatus objectWithKeyValues:responseObject];
            NSString *result = status.idstr;
//            赋值
            self.result = result;
//            展示信息
            [self showResult];
        
            
        }
    } failure:^(NSError *error) {
        [self showTips:@"发送微博数据失败"];
        ZXLog(@"%@",error)
    }];
    
    
}
//发送有图片的微博（现有的借口只允许一张）
- (void)sendWithImage
{
    //    发送
    NSString *url = @"https://upload.api.weibo.com/2/statuses/upload.json";
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"access_token"] = [ZXAccout shareAccout].access_token;
    parame[@"status"] = self.textView.text;
    
    [manager POST:url parameters:parame constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image1 = self.pictureView.images[0];
        NSData *imageData = UIImageJPEGRepresentation(image1, 0.7);
        [formData appendPartWithFileData:imageData name:@"pic" fileName:@"aa.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]])
        {
//            展示结果
            [self showResult];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(error)
        {
            [self showTips:@"发送微博数据失败"];
            ZXLog(@"%@",error);
        }
    }];
    
}
#pragma mark - 设置toolBar
//设置toolBar
- (void)setupToolBar
{
    ZXToolBar *toolBar = [[ZXToolBar alloc] init];
//    设置toolBar的属性
    toolBar.bounds = CGRectMake(0, 0, self.view.w, 44);
    toolBar.y = self.view.h - toolBar.h;
    toolBar.x = 0;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;

}

#pragma mark - 设置textView
- (void)setupTextView
{
    ZXTextView * textView = [[ZXTextView alloc] init];
    textView.placeHolder = @"写点什么吧";
    textView.placeHolderColor = [UIColor lightGrayColor];
//    textView.backgroundColor = [UIColor blueColor];
    textView.font = [UIFont systemFontOfSize:18];
    
    textView.frame = self.view.bounds;
//    设置它可以上下滑动
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
//    添加composePictureView
    ZXComposePictureView * cmpPic = [[ZXComposePictureView alloc] init];
    cmpPic.backgroundColor = [UIColor grayColor];
    cmpPic.frame = textView.bounds;
    cmpPic.y = 100;
    [textView addSubview:cmpPic];
    self.pictureView = cmpPic;
    
    
}

#pragma mark - 键盘通知
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

#pragma mark - ZXToolBarDelegate代理方法的实现

- (void)toolBar:(ZXToolBar *)toolBar btnType:(toolBarBtnType)btnType
{
#warning 处理键盘的弹出需求
//    如果没有发生偏移，就说明没有不需要弹出键盘，否则，弹出
    bool keyB = CGAffineTransformEqualToTransform(self.toolBar.transform,CGAffineTransformIdentity);
    if(keyB)
    {
        self.keyBoardShowing = NO;
    }
    else
    {
        self.keyBoardShowing = YES;
    }
    
    switch (btnType) {
            case toolBarBtnTypePic:
            [self showImagePickerController];
            break;
            case toolBarBtnTypeMetion:
            ZXLog(@"@")
            break;
            case toolBarBtnTypeThred:
            ZXLog(@"#")
            break;
            case toolBarBtnTypeeMoticon:
            ZXLog(@"表情")
            break;
            case toolBarBtnTypeAdd:
            ZXLog(@"添加")
            break;
    }
}
//跳转进入选择照片的界面
- (void)showImagePickerController
{
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    pickerVC.delegate = self;
    
    [self presentViewController:pickerVC animated:YES completion:nil];
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    获取图片
    UIImage * image = info[UIImagePickerControllerOriginalImage];
//    把图片添加在textView上
    [self.pictureView addImage:image];
//    添加玩图片之后消失
    [self dismissViewControllerAnimated:YES completion:nil];
    if(self.isKeyBoardShowing)
    {
//    弹出键盘
    [self.textView becomeFirstResponder];
    }
}

#pragma mark - 微博发送成功失败的提示

- (void)showResult
{
    
//    self.result = nil;//测试发送数据失败
    if(self.result)
    {
//            发送成功
        [self showTips:@"微博发送成功"];
    }else
    {
        [self showTips:@"微博发送失败"];
    }
}

- (void)showTips:(NSString *)tips
{
    [self dismissViewControllerAnimated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ZXStatusBar showStatusBarWith:tips];
        });
        
    }];
    
}

@end

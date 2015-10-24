//
//  ZXSearchView.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/21.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXSearchView.h"

@interface ZXSearchView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFlied;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLenth;
//创建搜索的图片
@property(nonatomic,strong) UIImageView *searchImage;
//创建箭头按钮
@property(nonatomic,strong) UIButton *arrowBtn;


@end
@implementation ZXSearchView

#pragma mark - 懒加载
- (UIImageView *)searchImage
{
    if(!_searchImage)
    {
        //    创建imageView
        UIImageView *imageView = [[UIImageView alloc] init];
        //    设置imageView的图片
        UIImage *image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        imageView.image = image;
        imageView.contentMode = UIViewContentModeCenter;
        imageView.frame = CGRectMake(0, 0, image.size.width+20, image.size.height);
        _searchImage = imageView;

    }
    return _searchImage;
}

- (UIButton *)arrowBtn
{
    if(!_arrowBtn)
    {
        _arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _arrowBtn.bounds = self.searchImage.bounds;
        [_arrowBtn setImage:[UIImage imageNamed:@"popover_arrow"] forState:UIControlStateNormal];
//        调整按钮图片的箭头方向
        _arrowBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    return _arrowBtn;
}

//快速创建搜索视图的方法
+ (instancetype)searchBarInit
{
    return [NSBundle loadViewWithNibName:@"ZXSearchView"];
}



//加载左边的imageView
- (void)awakeFromNib
{
    self.textFlied.leftView = self.searchImage;
    
    
#warning 一定要设置。否则显示不了
//    设置类型，默认不显示,改为总是显示
    self.textFlied.leftViewMode = UITextFieldViewModeAlways;
    
//    设置textfield的代理
    self.textFlied.delegate = self;
}

#pragma mark - UITextFieldDelegate代理方法
//开始编辑的代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    增大textflied与右边的距离
    self.rightLenth.constant = self.cancelBtn.frame.size.width +10;
//    显示取消按钮
    self.cancelBtn.hidden = NO;
//    更换textFlied的左视图
    self.textFlied.leftView = self.arrowBtn;
    
    return YES;
    
}

- (IBAction)cancelBtnClick {
//    当点击取消按钮的时候，textFlied的frame回到原来
    self.rightLenth.constant = 0;
//    隐藏取消按钮
    self.cancelBtn.hidden = YES;
//    将textFlied的左视图设置为搜索视图
    self.textFlied.leftView = self.searchImage;
//    设置动画
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
    }];
    
//    退出键盘
    [self endEditing:YES];
    
}
//退出编辑的代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

@end

//
//  ZXComposePictureView.h
//  ZXMSinga
//
//  Created by  周学明 on 15/11/5.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXComposePictureView : UIView

//添加图片
- (void)addImage:(UIImage *)image;


@property(nonatomic,assign) BOOL hasImage;


- (NSArray *)images;

@end

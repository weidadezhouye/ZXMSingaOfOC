//
//  ZXComposePictureView.m
//  ZXMSinga
//
//  Created by  周学明 on 15/11/5.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXComposePictureView.h"
#define imageViewRowCount 4

@implementation ZXComposePictureView



- (void)addImage:(UIImage *)image
{
    UIImageView *imageView  = [[UIImageView alloc] init];
    imageView.image = image;
    
    [self addSubview:imageView];
    
    
    CGFloat padding = 5;
//    接下来就是痛苦的设置frame
    CGFloat width = (self.w - padding * (imageViewRowCount+1)) / imageViewRowCount;
    CGFloat height = width;
    NSInteger cou = self.subviews.count;
    for(NSInteger index = 0;index < cou;index++)
    {
        UIImageView *imageView = self.subviews[index];
        CGFloat imageX = 0;
        CGFloat imageY = 0;
        NSInteger rows = index % imageViewRowCount;
        NSInteger cols = index / imageViewRowCount;
        imageView.frame = CGRectMake(imageX, imageY, width, height);
        imageView.x = padding + (padding + width) * rows;
        imageView.y = padding + (padding + height) * cols;
        
    }
    
    
}

- (BOOL)hasImage
{
    
    return self.subviews.count > 0;
}


- (NSArray *)images
{
    NSMutableArray *arr = [NSMutableArray array];
    
    for(UIImageView * img in self.subviews)
    {
        [arr addObject:img.image];
    }
    return [arr copy];
}


@end

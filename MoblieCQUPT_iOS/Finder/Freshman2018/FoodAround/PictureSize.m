//
//  PictureSize.m
//  MoblieCQUPT_iOS
//
//  Created by 陈大炮 on 2018/8/25.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "PictureSize.h"

static CGRect oldframe;

@implementation PictureSize

+(void)showImage:(UIImageView *)avatarImageView
{
   
    UIImage *cImage = avatarImageView.image;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor = [UIColor blackColor];
    
//    backgroundView.alpha=0;
    UIImageView *cImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 375, 100)];
    cImageView.image = cImage;
    cImageView.tag = 1;

     [backgroundView addSubview:cImageView];
     [window addSubview:backgroundView];
 
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        cImageView.frame = CGRectMake(0, 170,  [UIScreen mainScreen].bounds.size.width, 370);
    } completion:^(BOOL finished) {
        
    }];



}


+(void)hideImage:(UITapGestureRecognizer *)tap
{
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end

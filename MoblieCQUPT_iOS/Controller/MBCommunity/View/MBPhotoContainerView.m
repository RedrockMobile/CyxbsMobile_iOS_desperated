//
//  MBPhotoContainerView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/7.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBPhotoContainerView.h"
#import "UIImage+Helper.h"
#import "MBPhotoBrowser.h"



@interface MBPhotoContainerView ()

@property (strong, nonatomic) NSArray *imageViewArray;
@property (assign, nonatomic) BOOL isBig;
@property (strong, nonatomic) NSMutableArray *imageViewOrigin;

@property (strong, nonatomic) UIImageView *currenImageView;

@property (strong, nonatomic) UIView *back;

@property (strong, nonatomic) UIView *backView;

@end

@implementation MBPhotoContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupContainerView];
        [CATransaction setDisableActions:YES];
        _isBig = NO;
    }
    return  self;
}

- (void)setupContainerView {
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewArray = [temp copy];
}

- (void)setPicNameArray:(NSArray *)picNameArray {
    _picNameArray = picNameArray;
    for (NSInteger i = self.picNameArray.count; i < 9; i++) {
        UIImageView *imageView = [self.imageViewArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    if (_picNameArray.count != 0) {
        NSInteger perRowItemCount = [self perRowItemCountForPicPathArray:self.picNameArray];
        CGSize itemSize = [self itemSizeForPicArray:self.picNameArray];
        [_picNameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger colunm = idx % perRowItemCount;
            NSUInteger row = idx / perRowItemCount;
            UIImageView *imageView = [_imageViewArray objectAtIndex:idx];
            imageView.hidden = NO;
            imageView.frame = (CGRect){{colunm * (itemSize.width + 2),row * (itemSize.height + 2)},{itemSize.width,itemSize.height}};
            imageView.image = [UIImage imageNamed:self.picNameArray[idx]];
        }];
    }else {
        NSLog(@"没有图片");
    }
}
- (void)tapImageView:(UITapGestureRecognizer *)gesture {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIImageView *imageView = (UIImageView *)gesture.view;
    NSLog(@"%ld",(long)imageView.tag);
    
    _imageViewOrigin = [NSMutableArray array];
    for (int i = 0; i < self.imageViewArray.count; i ++) {
        UIImageView *tmp = [self.imageViewArray objectAtIndex:i];
        CGRect originRect = [self convertRect:tmp.frame toView:window];
        [_imageViewOrigin addObject:NSStringFromCGRect(originRect)];
    }
    
    MBPhotoBrowser *browser = [[MBPhotoBrowser alloc]initWithSourceContainerView:self currentImageItem:imageView.tag sourceImageArray:self.picNameArray imageViewOriginArray:self.imageViewOrigin];
    [browser show];
    
}

- (CGSize)itemSizeForPicArray:(NSArray *)array {
    if (array.count == 0) {
        return (CGSize){0,0};
    }else if (array.count == 1) {
        UIImage *image = [UIImage imageNamed:array[0]];
        if (image.size.width == image.size.height) {
            return (CGSize){kPhotoImageViewW*1.2,kPhotoImageViewW*1.2};
        }else if (image.size.width > image.size.height) {
            CGFloat width = image.size.width / image.size.height * kPhotoImageViewW*1.2;
            return (CGSize){width,kPhotoImageViewW*1.2};
        }else {
            CGFloat height = image.size.height / image.size.width * kPhotoImageViewW*1.2;
            return (CGSize){kPhotoImageViewW*1.2,height};
        }
    }else {
        return (CGSize){kPhotoImageViewW,kPhotoImageViewW};
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count <= 3) {// 0 1 2 3
        return array.count;
    } else if (array.count == 4) {// 4
        return 2;
    } else {// 5 6 7 8 9
        return 3;
    }
}



- (CGRect)calculateDestinationFrameWithSize:(CGSize)size{
    CGRect rect = CGRectMake(0.0f,
                             (ScreenHeight - size.height * ScreenWidth/size.width)/2,
                             ScreenWidth,
                             size.height * ScreenWidth/size.width);
    return rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

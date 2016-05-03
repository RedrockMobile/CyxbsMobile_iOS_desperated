//
//  MBAddPhotoContainerView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/30.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBAddPhotoContainerView.h"
#import "MBAddImageView.h"

@interface MBAddPhotoContainerView ()<MBAddImageViewDelegate>

@property (strong, nonatomic) UIButton *addButton;

@property (strong, nonatomic) NSMutableArray *originPostionArray;

@property (strong, nonatomic) NSMutableArray *subViewArray;

@end

@implementation MBAddPhotoContainerView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.addButton];
    }
    return self;
}
- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(0, 0, kPhotoImageViewW, kPhotoImageViewW);
        _addButton.backgroundColor = [UIColor greenColor];
        [_addButton addTarget:self action:@selector(clickAdd:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addButton;
}

- (void)clickAdd:(UIButton *)sender {
    
    if ([self.eventDelegate respondsToSelector:@selector(clickPhotoContainerViewAdd)]) {
        [self.eventDelegate clickPhotoContainerViewAdd];
    }
}


- (void)setSourcePicArray:(NSArray *)sourcePicArray {
    _sourcePicArray = sourcePicArray;
    NSInteger perRowItemCount = [self perRowItemCountForPicPathArray:self.sourcePicArray];
    _originPostionArray = [NSMutableArray array];
    
    [_sourcePicArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger colunm = idx % perRowItemCount;
        NSUInteger row = idx / perRowItemCount;
        MBAddImageView *imageView = [[MBAddImageView alloc]initWithFrame:(CGRect){{colunm * (kPhotoImageViewW + 2),row * (kPhotoImageViewW + 2)},{kPhotoImageViewW,kPhotoImageViewW}}];
        imageView.image = [UIImage imageNamed:self.sourcePicArray[idx]];
        imageView.tag = idx;
        [_originPostionArray addObject:NSStringFromCGRect(imageView.frame)];
        
        imageView.delegate = self;
        
        [self addSubview:imageView];
    }];
}

- (void)layoutSubviews {
    NSInteger row = self.originPostionArray.count / 3.5;
    CGFloat height = (row + 1) * kPhotoImageViewW + row * 2;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (void)clickDelete:(MBAddImageView *)sender {
    [_originPostionArray removeObjectAtIndex:sender.tag];
    [sender removeFromSuperview];
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    }else {
        return 3;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

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
//        [self setupImageView];
        self.backgroundColor = [UIColor blackColor];
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
    [self setupImageView];
    NSInteger perRowItemCount = [self perRowItemCountForPicPathArray:self.sourcePicArray];
    _originPostionArray = [NSMutableArray array];
    
    [_sourcePicArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger colunm = idx % perRowItemCount;
        NSUInteger row = idx / perRowItemCount;
        MBAddImageView *imageView = self.subViewArray[idx];
        imageView.frame = (CGRect){{colunm * (kPhotoImageViewW + 2),row * (kPhotoImageViewW + 2)},{kPhotoImageViewW,kPhotoImageViewW}};
        imageView.image = [UIImage imageNamed:self.sourcePicArray[idx]];
        imageView.tag = idx;
        imageView.hidden = NO;
        [_originPostionArray addObject:NSStringFromCGRect(imageView.frame)];
        
        imageView.delegate = self;
        
        [self addSubview:imageView];
    }];
    if (_sourcePicArray.count == 9) {
        _addButton.hidden = YES;
    }
}

- (void)setupImageView {
    
    if (self.subViewArray.count != 0) {
        for (int idx = 0; idx < self.subViewArray.count; idx ++) {
            MBAddImageView *imageView = self.subViewArray[idx];
            [imageView removeFromSuperview];
        }
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0; i < 9; i++) {
        MBAddImageView *imageView = [[MBAddImageView alloc]init];
        [self addSubview:imageView];
        imageView.tag = i;
        imageView.hidden = YES;
        [temp addObject:imageView];
        
        UILabel *tag = [[UILabel alloc]init];
        tag.text = [NSString stringWithFormat:@"%ld",imageView.tag];
        tag.textColor = [UIColor whiteColor];
        tag.font = [UIFont systemFontOfSize:16];
        [tag sizeToFit];
        tag.center = CGPointMake(kPhotoImageViewW/2, kPhotoImageViewW/2);
        [imageView addSubview:tag];
    }
    
    self.subViewArray = temp;
}

- (void)layoutSubviews {
    NSInteger row;
    if (self.originPostionArray.count < 9) {
        row = (self.originPostionArray.count + 1) / 3.5;
    }else {
        row = self.originPostionArray.count / 3.5;
    }
    CGFloat height = (row + 1) * kPhotoImageViewW + row * 2;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    
    
    
}

- (void)clickDelete:(MBAddImageView *)sender {
    NSLog(@"%ld ~ %ld",sender.tag,_subViewArray.count);
    if (_originPostionArray.count == 1 || sender.tag == self.originPostionArray.count - 1) {
        _addButton.hidden = NO;
        _addButton.frame = CGRectFromString([self.originPostionArray lastObject]);
    }else {
        NSLog(@"22");
        for (NSInteger i = sender.tag; i < self.originPostionArray.count; i ++) {
            if ((i + 1) < self.originPostionArray.count) {
                MBAddImageView *nextImageView = self.subViewArray[i+1];
                nextImageView.tag = i;
                [UIView animateWithDuration:0.2 animations:^{
                    nextImageView.frame = CGRectFromString(self.originPostionArray[i]);
                    _addButton.hidden = NO;
                    _addButton.frame = CGRectFromString([self.originPostionArray lastObject]);
                } completion:^(BOOL finished) {
                    
                }];
            }
        }
    }
    [_originPostionArray removeObjectAtIndex:self.originPostionArray.count - 1];
    [_subViewArray removeObject:sender];
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

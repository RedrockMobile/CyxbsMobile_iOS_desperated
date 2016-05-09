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
@property (strong, nonatomic) NSMutableArray *currentPostionArray;

@property (strong, nonatomic) NSMutableArray *subViewArray;

@end

@implementation MBAddPhotoContainerView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.addButton];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(0, 0, kPhotoImageViewW, kPhotoImageViewW);
//        _addButton.backgroundColor = [UIColor greenColor];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"addPhoto.jpg"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(clickAdd:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addButton;
}

- (void)clickAdd:(UIButton *)sender {
    
    if ([self.eventDelegate respondsToSelector:@selector(clickPhotoContainerViewAdd)]) {
        [self.eventDelegate clickPhotoContainerViewAdd];
    }
}

- (void)setSourcePicArray:(NSMutableArray *)sourcePicArray {
    _sourcePicArray = sourcePicArray;
    [self setupImageView];
    
    _currentPostionArray = [NSMutableArray array];
    [_sourcePicArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MBAddImageView *imageView = self.subViewArray[idx];
        imageView.hidden = NO;
        [_currentPostionArray addObject:NSStringFromCGRect(imageView.frame)];
        imageView.image = obj;
        imageView.delegate = self;
        [self addSubview:imageView];
    }];
    if (_sourcePicArray.count == 9) {
        _addButton.hidden = YES;
    }else {
        _addButton.frame = CGRectFromString(self.originPostionArray[self.sourcePicArray.count]);
    }
}

- (void)setupImageView {
    _originPostionArray = [NSMutableArray array];
    if (self.subViewArray.count != 0) {
        for (int idx = 0; idx < self.subViewArray.count; idx ++) {
            MBAddImageView *imageView = self.subViewArray[idx];
            [imageView removeFromSuperview];
        }
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0; i < 9; i++) {
        NSInteger colunm = i % 3;
        NSUInteger row = i / 3;
        MBAddImageView *imageView = [[MBAddImageView alloc]init];
        imageView.frame = (CGRect){{colunm * (kPhotoImageViewW + 2),row * (kPhotoImageViewW + 2)},{kPhotoImageViewW,kPhotoImageViewW}};
        imageView.tag = i;
        imageView.hidden = YES;
        [temp addObject:imageView];
        
        [_originPostionArray addObject:NSStringFromCGRect(imageView.frame)];
    }
    
    self.subViewArray = temp;
}

- (void)layoutSubviews {
    NSInteger row;
    if (self.currentPostionArray.count < 9) {
        row = (self.currentPostionArray.count + 1) / 3.5;
    }else {
        row = self.currentPostionArray.count / 3.5;
    }
    CGFloat height = (row + 1) * kPhotoImageViewW + row * 2;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    
}

- (void)clickDelete:(MBAddImageView *)sender {
    if ([self.eventDelegate respondsToSelector:@selector(clickDeleteImageViewWithTag:)]) {
        [self.eventDelegate clickDeleteImageViewWithTag:sender.tag];
    }
    
    if (_currentPostionArray.count == 1 || sender.tag == self.currentPostionArray.count - 1) {
        _addButton.hidden = NO;
        _addButton.frame = CGRectFromString([self.currentPostionArray lastObject]);
    }else {
        for (NSInteger i = sender.tag; i < self.currentPostionArray.count; i ++) {
            if ((i + 1) < self.currentPostionArray.count) {
                MBAddImageView *nextImageView = self.subViewArray[i+1];
                nextImageView.tag = i;
                [UIView animateWithDuration:0.2 animations:^{
                    nextImageView.frame = CGRectFromString(self.currentPostionArray[i]);
                    _addButton.hidden = NO;
                    _addButton.frame = CGRectFromString([self.currentPostionArray lastObject]);
                } completion:^(BOOL finished) {
                    
                }];
            }
        }
    }
    [_currentPostionArray removeObjectAtIndex:self.currentPostionArray.count - 1];
    [_subViewArray removeObject:sender];
    [sender removeFromSuperview];
    [_sourcePicArray removeObjectAtIndex:sender.tag];
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

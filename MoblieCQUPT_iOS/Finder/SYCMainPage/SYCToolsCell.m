//
//  SYCToolsCell.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/9/25.
//  Copyright © 2018 Orange-W. All rights reserved.
//

#import "SYCToolsCell.h"
@interface SYCToolsCell()

@property (nonatomic, strong)UIImageView *cellImageView;
@property (nonatomic, strong)UILabel *cellLabel;

@end

@implementation SYCToolsCell
    
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)setIsMoving:(BOOL)isMoving{
    _isMoving = isMoving;
    if (_isMoving) {
        self.backgroundColor = [UIColor clearColor];
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setImage:(UIImage *)image title:(NSString *)title{
    self.cellImageView.image = image;
    self.cellLabel.text = title;
}

- (void)buildUI{
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat cellImageWidth = self.width * 0.6;
    CGFloat cellImageHeight = cellImageWidth;
    self.cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - cellImageWidth) / 2.0, self.height * 0.1, cellImageWidth, cellImageHeight)];
    [self addSubview:self.cellImageView];
    
    CGFloat labelWidth = self.width * 0.8;
    self.cellLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.width - labelWidth) / 2.0, cellImageHeight, labelWidth, 45)];
    self.cellLabel.textColor = [UIColor grayColor];
    self.cellLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightUltraLight];
    self.cellLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.cellLabel];
}

- (void)setImage:(UIImage *)image{
    _image = image;
    _cellImageView.image = image;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _cellLabel.text = title;
}

@end

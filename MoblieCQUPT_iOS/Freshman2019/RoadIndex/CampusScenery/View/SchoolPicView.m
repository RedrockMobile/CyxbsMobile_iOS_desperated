//
//  SchoolPicView.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/9.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "SchoolPicView.h"

@implementation SchoolPicView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    UIView *backgroundView = [[UIView alloc]initWithFrame:frame];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.schoolPicCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    self.schoolPicCollectionView.backgroundColor = [UIColor clearColor];
    self.schoolPicCollectionView.showsVerticalScrollIndicator = NO;
    self.schoolPicCollectionView.showsHorizontalScrollIndicator = NO;
    [backgroundView addSubview:self.schoolPicCollectionView];
    [self addSubview:backgroundView];
    
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(0);
    }];
    [self.schoolPicCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView).offset(0);
        make.left.equalTo(backgroundView).offset(0);
        make.right.equalTo(backgroundView).offset(0);
        make.bottom.equalTo(backgroundView).offset(0);
    }];
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

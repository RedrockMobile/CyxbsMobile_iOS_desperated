//
//  YouWenSoreView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenSoreView.h"
#import "dailyAttendanceModel.h"

@interface YouWenSoreView()<dailyAttendanceDelegate>
@property (strong, nonatomic) UILabel *soreLab;
@property (strong, nonatomic) NSMutableArray *btnArray;
@property (copy, nonatomic) NSString *sore;
@property (copy, nonatomic) NSString *restSore;
@property (strong, nonatomic) UILabel *restSoreLab;
@property (strong, nonatomic) UILabel *loadingLab;
//这里用了签到请求的积分，懒
@property (strong, nonatomic) dailyAttendanceModel *soreData;

@end
@implementation YouWenSoreView

- (void)setUpUI{
    [super setUpUI];
    _btnArray = [NSMutableArray array];
    _restSore = [NSString string];
    _restSoreLab = [[UILabel alloc] init];
    _restSoreLab.textColor = [UIColor grayColor];
    _restSoreLab.layer.opacity = 0.6;
    _restSoreLab.font = [UIFont systemFontOfSize:14];
    [self.whiteView addSubview:_restSoreLab];
    [_restSoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cancelBtn).offset(50);
        make.left.mas_equalTo(self.cancelBtn);
        make.height.mas_offset(12);
        make.width.mas_offset(200);
    }];
    
    _sore = @"0";
    _soreData = [[dailyAttendanceModel alloc] init];
    _soreData.delegate = self;
    [_soreData requestNewScore];
    
    _soreLab = [[UILabel alloc] init];
    _soreLab.font = [UIFont systemFontOfSize:18];
    _soreLab.textColor = [UIColor colorWithHexString:@"7195FA"];
    [self.whiteView addSubview:_soreLab];
    [_soreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_restSoreLab.mas_bottom).offset(40);
        make.left.mas_equalTo(self.cancelBtn);
        make.height.mas_offset(16);
        make.width.mas_offset(100);
    }];
    [_soreLab.superview layoutIfNeeded];
    
    UIView *grayLine = [[UIView alloc] init];
    grayLine.backgroundColor = [UIColor grayColor];
    grayLine.layer.opacity = 0.6;
    [self.whiteView addSubview:grayLine];
    [grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_soreLab.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.whiteView);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(0.4);
    }];
    
    self.confirBtn.hidden = YES;
    
    _loadingLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/ 2, (self.whiteView.height - 50)/ 2, 100, 50)];
    _loadingLab.font = [UIFont systemFontOfSize:15];
    _loadingLab.text = @"正在加载....";
    _loadingLab.textAlignment = NSTextAlignmentCenter;
    [self.whiteView addSubview:_loadingLab];
    
}

- (void)setBtnUp{
    NSArray *numArray = @[@"1", @"2", @"3", @"5", @"10", @"15"];
    CGFloat width = (SCREEN_WIDTH - 142) / 6;
    for (int i = 0; i < numArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"square"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"blueSquare"] forState:UIControlStateSelected];
        [btn setTitle:numArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"7195FA"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectSore:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16 + (width + 22) * i);
            make.top.mas_equalTo(self.whiteView.mas_bottom).with.offset(-100);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(width);
        }];
        if ([_restSore intValue] < [numArray[i] intValue]){
            btn.userInteractionEnabled  = NO;
        }
        [_btnArray addObject:btn];
    }
    
}

- (void)selectSore:(UIButton *)Ubtn{
    for (int i = 0; i < _btnArray.count; i ++) {
        UIButton *btn = _btnArray[i];
        btn.selected = NO;
    }
    Ubtn.selected = YES;
    _soreLab.text = [NSString stringWithFormat:@"%@积分", Ubtn.titleLabel.text];
    _sore = Ubtn.titleLabel.text;
   
    
}

- (void)getSore:(NSString *)sore{
    if ([sore isEqualToString:@"NULL"]) {
        _loadingLab.text = @"加载失败";
        double delayInSeconds = 2.0;
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
        
        
    }
    else{
        self.confirBtn.hidden = NO;
        _restSore = sore.copy;
        _restSoreLab.text = [NSString stringWithFormat:@"积分剩余：%@", _restSore];
        [_loadingLab removeFromSuperview];
        [self setBtnUp];
    }
}

- (void)confirm{
    [super confirm];
    NSNotification *notification = [[NSNotification alloc]initWithName:@"soreNotifi" object:@{@"sore":self.sore} userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    [self removeFromSuperview];
}

@end

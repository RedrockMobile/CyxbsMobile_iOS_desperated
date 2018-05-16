//
//  dailyAttendanceViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "dailyAttendanceViewController.h"
#import "MyInfoModel.h"
#import "dailyAttendanceModel.h"

@interface dailyAttendanceViewController ()<getSoreDelegate>
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *attendanceSoreLabel;
@property (nonatomic, strong) UILabel *continueDayLabel;
@property (nonatomic, strong) UIButton *detailSoreBtn;

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UISwitch *remindMeSwitch;
@end

@implementation dailyAttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self setUpMainView];
    [self.view addSubview:_mainView];
    // Do any additional setup after loading the view.
}

- (void)setUpMainView{
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(18, 22, SCREENWIDTH - 36, 382)];
    _mainView.layer.cornerRadius = 5;
    _mainView.layer.borderWidth = 1;
    _mainView.layer.borderColor = [UIColor whiteColor].CGColor;
    _mainView.layer.masksToBounds = YES;
    _mainView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 17, 60, 60)];
    headImageView.layer.cornerRadius = headImageView.width/2;
    headImageView.layer.borderWidth = 1;
    headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    headImageView.layer.masksToBounds = YES;

    MyInfoModel *model = [MyInfoModel getMyInfo];
    if (model.photo_thumbnail_src == nil){
        headImageView.image = [UIImage imageNamed:@"headImage"];
    }
    else {
        headImageView.image = model.photo_thumbnail_src;
    }
    [_mainView addSubview:headImageView];
    
    dailyAttendanceModel *dataModel = [[dailyAttendanceModel alloc] init];
    [dataModel requestNewScore];
    dataModel.delegate = self;
    _attendanceSoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(headImageView.right + 14, 32, 200, 14)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"我的积分数："];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 6)];
    _attendanceSoreLabel.attributedText = attributedString;
    [_mainView addSubview:_attendanceSoreLabel];
    
    _detailSoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_detailSoreBtn setTitle:@"积分明细" forState:UIControlStateNormal];
    [_detailSoreBtn setTitleColor:[UIColor colorWithHexString:@"6D86E8"] forState:(UIControlStateNormal|UIControlStateSelected)];
    [_mainView addSubview:_detailSoreBtn];
    [_detailSoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top
        .mas_equalTo(_attendanceSoreLabel.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(13);
        make.left.mas_equalTo(headImageView.mas_right)
        .mas_offset(15);
        make.width.mas_offset(60);
    }];
}

- (void)getSore:(NSString *)sore{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"我的积分数：%@", sore]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 6)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"6D86E8"] range:NSMakeRange(6, sore.length)];
    _attendanceSoreLabel.attributedText = attributedString;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  attendanceMoreViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/23.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "attendanceMoreViewController.h"

@interface attendanceMoreViewController ()
@property (strong, nonatomic)NSString *textStr;
@property (strong, nonatomic)UIView *mainView;
@end

@implementation attendanceMoreViewController

- (id)initWithStr:(NSString *)str{
    if (self = [super init]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        _textStr = [[NSString alloc] initWithString:str];
        self.view.backgroundColor = RGBColor(246, 246, 246, 1);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect rect = [_textStr boundingRectWithSize:CGSizeMake(0, SCREEN_WIDTH - 70) options:NSStringDrawingUsesLineFragmentOrigin
        |NSStringDrawingUsesFontLeading
        attributes:dic context:nil];
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(15, 25, SCREEN_WIDTH - 30, rect.size.height + 110)];
    _mainView.layer.cornerRadius = 5;
    _mainView.layer.borderWidth = 1;
    _mainView.layer.borderColor = [UIColor whiteColor].CGColor;
    _mainView.layer.masksToBounds = YES;
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.layer.shadowColor = [UIColor blackColor].CGColor;
    _mainView.layer.shadowOffset = CGSizeMake(5,5);
    _mainView.layer.shadowOpacity = 1;
   
    [self.view addSubview:_mainView];
    
    UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, SCREEN_WIDTH - 70, rect.size.height)];
    textLab.numberOfLines = 0;
    textLab.font = [UIFont fontWithName:@"Arial" size:14];
    textLab.text = _textStr;
    [_mainView addSubview:textLab];
    
    UILabel *signLab = [[UILabel alloc] init];
    signLab.font = [UIFont fontWithName:@"Arial" size:12];
    signLab.text = @"以上信息的最终解释权归红岩网校工作站所有";
    signLab.textColor = RGBColor(170, 170, 170,1);
    signLab.textAlignment = NSTextAlignmentCenter;
    [_mainView addSubview:signLab];
    
    [signLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_mainView).mas_offset(-20);
        make.width.mas_equalTo(300);
        make.centerX.mas_equalTo(_mainView);
    }];
    
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

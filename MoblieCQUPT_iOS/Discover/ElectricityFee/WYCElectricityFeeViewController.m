//
//  WYCElectricityFeeViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/4/2.
//  Copyright © 2019年 Orange-W. All rights reserved.
//

#import "WYCElectricityFeeViewController.h"
#import "WYCSetUpRoomViewController.h"
#import "WYCElectricityFeeView.h"
#import "WYCElectricityFeeModel.h"
@interface WYCElectricityFeeViewController ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *upViewHeight;
@property (strong, nonatomic) IBOutletCollection(WYCElectricityFeeView) NSArray *subView;
@property (nonatomic, copy) NSString *roomNum;
@property (nonatomic, copy) NSString *buildingNum;
@property (weak, nonatomic) IBOutlet UILabel *recordLable;
@property (weak, nonatomic) IBOutlet UILabel *lastmoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *elec_spend;
@property (nonatomic, strong) WYCElectricityFeeModel *model;
@end

@implementation WYCElectricityFeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查电费";
    _upViewHeight.constant = (SCREEN_HEIGHT - HEADERHEIGHT) * 0.38;
    [self.view layoutIfNeeded];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFeeDataSuccess) name:@"FeeDataLoadSuccess" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFeeDataFail) name:@"FeeDataLoadFail" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFeeData) name:@"reloadFeeDataLoad" object:nil];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"rightBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(setRoom)];
    [self.navigationItem setRightBarButtonItem:rightBtn];
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = pathArray[0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"RoomAndBuild.plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    //NSDictionary *dic = @{@"roomNum":@"412",@"buildingNum":@"23a"};
    if (dic) {
        self.roomNum = dic[@"roomNum"];
        self.buildingNum = dic[@"buildingNum"];
        [self getFeeData];
        
    }
    else{
        [self setRoom];
    }
}

- (void)setRoom{
    WYCSetUpRoomViewController *vc = [[WYCSetUpRoomViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getFeeData{
    if (!self.model) {
        self.model = [[WYCElectricityFeeModel alloc]init];
        [self.model getFeeData:self.buildingNum RoomNum:self.roomNum];
    }
}

- (void)loadFeeDataSuccess{
    for (WYCElectricityFeeView *view in self.subView) {
        view.dataLabel.text = self.model.dataArray[view.tag];
    }
    self.recordLable.text = self.model.record_time;
    self.lastmoneyLabel.text = self.model.lastmoney;
    self.elec_spend.text = self.model.elec_spend;
}
- (void)loadFeeDataFail{
   UIAlertController *controller =  [UIAlertController alertControllerWithTitle:@"数据加载错误" message:@"请检查网络" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    
    [controller addAction:ok];
    
    [self presentViewController:controller animated:YES completion:^{
        
    }];
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

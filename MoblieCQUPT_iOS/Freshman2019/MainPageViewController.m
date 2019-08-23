//
//  MainPageViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2019/8/2.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "MainPageViewController.h"
#import "WelcomeTableViewCell.h"
#import "FYHOnlineActivityMainViewController.h"
#import "AboutUsViewController.h"
#import "WelComeView.h"
#import "StartStepsController.h"
#import "MainPageViewController.h"
#import "WelcomeTableViewCell.h"
#import "RoadIndex/RoadIndex.h"
#import "SYCNecessityViewController.h"
#import "LQQwantMoreViewController.h"
#import "LQQxiaoYuanZhiYinViewController.h"
@interface MainPageViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
    NSArray *_dataArr;
}

@end

@implementation MainPageViewController

- (void)viewWillAppear:(BOOL)animated {
    CABasicAnimation *rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnim.fromValue = @(0);
    rotateAnim.toValue = @(M_PI*2);
    rotateAnim.repeatCount = 10000;
    rotateAnim.duration = 3;
    
    UIImageView *bannerImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"掌邮迎新版"]];
    bannerImageView.translatesAutoresizingMaskIntoConstraints = YES;
    bannerImageView.size = CGSizeMake(MAIN_SCREEN_W, MAIN_SCREEN_W * 0.767);
    UIImageView *pin1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"形状741"]];
    [pin1.layer addAnimation:rotateAnim forKey:nil];
    [bannerImageView addSubview:pin1];
    pin1.frame = CGRectMake(MAIN_SCREEN_W * 0.78, MAIN_SCREEN_W * 0.33, 7, 7);
    
    _tableView.tableHeaderView = bannerImageView;
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    _dataArr = @[
                 @{
                     @"title":@"入学必备",
                     @"description":@"报道必备 军训用品",
                     @"selector": NSStringFromSelector(@selector(gotoRegisterNecessary))
                     },
                 @{
                     @"title":@"指路重邮",
                     @"description":@"公交线路 重邮地图 校园风光",
                     @"selector": NSStringFromSelector(@selector(gotoRoadIndex))
                     },
                 @{
                     @"title":@"入学流程",
                     @"description":@"报到流程",
                     @"selector": NSStringFromSelector(@selector(gotoRegisterFlow))
                     },
                 @{
                     @"title":@"校园指引",
                     @"description":@"宿舍 食堂 快递 数据揭秘",
                     @"selector": NSStringFromSelector(@selector(gotoSchoolIndex))
                     },
                 @{
                     @"title":@"线上交流",
                     @"description":@"老乡群 学院群 线上活动",
                     @"selector": NSStringFromSelector(@selector(gotoOnlineActivity))
                     },
                 @{
                     @"title":@"更多功能",
                     @"description":@"迎新网 重邮小帮手 发现",
                     @"selector": NSStringFromSelector(@selector(gotoMore))
                     },
                 @{
                     @"title":@"关于我们",
                     @"description":@"红岩网校",
                     @"selector": NSStringFromSelector(@selector(gotoAboutUs))
                     },
                 
                 ];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:0.83 green:0.92 blue:1.00 alpha:1.00];
    [_tableView registerClass:[WelcomeTableViewCell class] forCellReuseIdentifier:@"WelcomeTableViewCell"];
    [self.view addSubview:_tableView];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-(0)-[_tableView]-(0)-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints: [NSLayoutConstraint
                                constraintsWithVisualFormat:@"V:|-(0)-[_tableView]-(0)-|"
                                options:0
                                metrics:nil
                                views:NSDictionaryOfVariableBindings(_tableView)]];
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *isFirstLaunch = [user objectForKey:@"isFirstLaunch"];
    
    if (isFirstLaunch.length == 0) {
        [user setObject:@"no" forKey:@"isFirstLaunch"];
        [user synchronize];
        WelComeView *welcome = [[WelComeView alloc] init];
        welcome.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            welcome.alpha = 1;
        }];
        [self.view addSubview:welcome];
        
        [welcome performSelector:@selector(spreadOutView) withObject:nil afterDelay:1];
    }
}


//跳转到入学必备
- (void)gotoRegisterNecessary {
    SYCNecessityViewController *necessityVC = [[SYCNecessityViewController alloc] init];
    [self.navigationController pushViewController:necessityVC animated:YES];
}

//跳转到指路重邮
- (void)gotoRoadIndex {
    RoadIndex *roadIndex = [[RoadIndex alloc] init];
    [self.navigationController pushViewController:roadIndex animated:YES];
}

//跳转到校园指导
- (void)gotoSchoolIndex {
    LQQXiaoYuanZhiYinViewController*xyzy = [[LQQXiaoYuanZhiYinViewController alloc]init];
    xyzy.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:xyzy animated:YES];
    
}

//跳转到线上活动
- (void)gotoOnlineActivity {
    FYHOnlineActivityMainViewController *controller = [[FYHOnlineActivityMainViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

//跳转到更多功能
- (void)gotoMore {
    LQQwantMoreViewController*gdgn = [[LQQwantMoreViewController alloc]init];
    gdgn.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gdgn animated:YES];
}

//跳转到关于我们
- (void)gotoAboutUs {
    AboutUsViewController *controller = [[AboutUsViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)gotoRegisterFlow{
    StartStepsController *controller = [[StartStepsController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"WelcomeTableViewCell";
    WelcomeTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    NSDictionary *dataDic = _dataArr[indexPath.row];
    cell.title = dataDic[@"title"];
    cell.descript = dataDic[@"description"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIImageView *bannerImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"welcome_bottom.png"]];
    return bannerImageView;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dataDic = _dataArr[indexPath.row];
    SEL sel = NSSelectorFromString(dataDic[@"selector"]);
    [self performSelector:sel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 295;
}

@end

//
//  MainPageViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2019/8/2.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "MainPageViewController.h"
#import "WelcomeTableViewCell.h"
#import "RegisterNecessaryViewController.h"
#import "LQQXiaoYuanZhiYinViewController.h"
#import "LQQwantMoreViewController.h"
@interface MainPageViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
    NSArray *_dataArr;
}

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    _dataArr = @[
                 @{
                     @"title":@"入学必备",
                     @"description":@"报道必备、宿舍用品、学习用品",
                     @"selector": NSStringFromSelector(@selector(gotoRegisterNecessary))
                     },
                 @{
                     @"title":@"指路重邮",
                     @"description":@"重邮路线、重邮地图",
                     @"selector": NSStringFromSelector(@selector(gotoRoadIndex))
                     },
                 @{
                     @"title":@"入学流程",
                     @"description":@"入学步骤、入学地点",
                     @"selector": NSStringFromSelector(@selector(gotoRegisterFlow))
                     },
                 @{
                     @"title":@"校园指导",
                     @"description":@"宿舍、快递地点指引",
                     @"selector": NSStringFromSelector(@selector(gotoSchoolIndex))
                     },
                 @{
                     @"title":@"线上活动",
                     @"description":@"老乡群、专业群",
                     @"selector": NSStringFromSelector(@selector(gotoOnlineActivity))
                     },
                 @{
                     @"title":@"更多功能",
                     @"description":@"迎新网、新生课表",
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

    

}

//跳转到入学必备
- (void)gotoRegisterNecessary {
    RegisterNecessaryViewController *vc = [[RegisterNecessaryViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//跳转到指路重邮
- (void)gotoRoadIndex {
}

//跳转到入学流程
- (void)gotoRegisterFlow {
}

//跳转到校园指引
- (void)gotoSchoolIndex {
    LQQXiaoYuanZhiYinViewController*vc = [[LQQXiaoYuanZhiYinViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//跳转到线上活动
- (void)gotoOnlineActivity {
}

//跳转到更多功能
- (void)gotoMore {
    LQQwantMoreViewController*vc =[[LQQwantMoreViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//跳转到关于我们
- (void)gotoAboutUs {
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
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CABasicAnimation *rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnim.fromValue = @(0);
    rotateAnim.toValue = @(M_PI*2);
    rotateAnim.repeatCount = 10000;
    rotateAnim.duration = 3;
    
    UIImageView *bannerImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"welcome_banner.png"]];
    bannerImageView.translatesAutoresizingMaskIntoConstraints = YES;
    UIImageView *pin1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"welcome_banner_pin1.png"]];
    pin1.translatesAutoresizingMaskIntoConstraints = NO;
    [pin1.layer addAnimation:rotateAnim forKey:nil];
    [bannerImageView addSubview:pin1];
    [bannerImageView addConstraints:[NSLayoutConstraint
                                constraintsWithVisualFormat:@"H:|-(321)-[pin1]"
                                options:0
                                metrics:nil
                                views:NSDictionaryOfVariableBindings(pin1)]];
    [bannerImageView addConstraints: [NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|-(127)-[pin1]"
                                 options:0
                                 metrics:nil
                                 views:NSDictionaryOfVariableBindings(pin1)]];
    
    UIImageView *pin2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"welcome_banner_pin2.png"]];
    pin2.translatesAutoresizingMaskIntoConstraints = NO;
    [pin2.layer addAnimation:rotateAnim forKey:nil];
    [bannerImageView addSubview:pin2];
    [bannerImageView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:@"H:|-(200)-[pin2]"
                                     options:0
                                     metrics:nil
                                     views:NSDictionaryOfVariableBindings(pin2)]];
    [bannerImageView addConstraints: [NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|-(85)-[pin2]"
                                      options:0
                                      metrics:nil
                                      views:NSDictionaryOfVariableBindings(pin2)]];
    
    return bannerImageView;
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

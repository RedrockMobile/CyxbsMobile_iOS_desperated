//
//  SettingViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/5/5.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "SettingViewController.h"
#import "SuggestionViewController.h"
#import "SuggestionViewController.h"
#import "XBSAboutViewController.h"
#import "LoginEntry.h"
#import "LoginViewController.h"

@interface SettingViewController()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *cellArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _cellArray = @[@{@"cell":@"意见与反馈", @"controller":@"SuggestionViewController"},
                   @{@"cell":@"关于", @"controller":@"XBSAboutViewController"},
                   @{@"cell":@"退出当前账号"},
                   ];
}

#pragma mark - TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 43;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UILabel *textLabel = [[UILabel alloc] init];
    [textLabel sizeToFit];
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section == 0) {
        textLabel.text = _cellArray[indexPath.row][@"cell"];
        textLabel.frame = CGRectMake(12, 12, 0, 0);
        textLabel.font = kFont;
        textLabel.textColor = kDetailTextColor;
        textLabel.textAlignment = NSTextAlignmentLeft;
        [textLabel sizeToFit];
        
        [cell.contentView addSubview:textLabel];
    } else {
        cell.accessoryType = UITableViewStylePlain;
        
        textLabel.text = _cellArray[indexPath.row+2][@"cell"];
        textLabel.font = kFont;
        textLabel.textColor = kDetailTextColor;
        textLabel.textAlignment = NSTextAlignmentCenter;
        [textLabel sizeToFit];
        textLabel.center = CGPointMake(MAIN_SCREEN_W/2, cell.center.y);
        
        [cell.contentView addSubview:textLabel];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        NSString *className =  _cellArray[indexPath.row][@"controller"];
        UIViewController *viewController =  (UIViewController *)[[NSClassFromString(className) alloc] init];
        viewController.navigationItem.title = _cellArray[indexPath.row][@"cell"];
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登出帐号"
                                                                       message:@"所有的个人信息将清除,你确定要登出此帐号吗?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [self logOut];
                                                       }];
        [alert addAction:defaultAction];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                                style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)logOut {
    LoginViewController *login = [[LoginViewController alloc]init];
    [self.navigationController presentViewController:login animated:YES completion:^{
        [LoginEntry loginoutWithParamArrayString:@[@"dataArray",@"weekDataArray",@"nowWeek",@"user_id",@"nickname",@"photo_src"]];
    }];
}

@end

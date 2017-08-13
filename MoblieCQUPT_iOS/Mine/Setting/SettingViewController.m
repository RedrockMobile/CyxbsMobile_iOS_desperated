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
#import "LessonRemindNotification.h"

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
                   @{@"cell":@"设置课前提醒"},
                   @{@"cell":@"退出当前账号"},
                   ];
}

#pragma mark - TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
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
        if (indexPath.row == 2) {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
            [switchview addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
            if ([userDefault objectForKey:@"switchState"] == nil) {
                [userDefault setObject:[NSNumber numberWithBool:switchview.on] forKey:@"switchState"];
            }
            switchview.on = [[userDefault objectForKey:@"switchState"] boolValue];
            cell.accessoryView = switchview;
        }
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
        
        textLabel.text = _cellArray[indexPath.row+3][@"cell"];
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

- (void)switchValueChanged:(UISwitch *)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:sender.on] forKey:@"switchState"];
    LessonRemindNotification *lrNotic = [[LessonRemindNotification alloc] init];
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"课前提醒" message:@"每晚十点 掌上重邮 会准时把明日课表发给你哦" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道啦" style:UIAlertActionStyleCancel handler:nil];
    [alerController addAction:okAction];
    if (sender.on) {
        [self presentViewController:alerController animated:YES completion:nil];
        [lrNotic notificationBody];
        [lrNotic addTomorrowNotification];
        [lrNotic setGcdTimer];
    }else{
        [lrNotic deleteNotification];
    }
}

- (void)logOut {
    //    NSLog(@"log out");
    //    LoginViewController *login = [[LoginViewController alloc]init];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    id view = [storyBoard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [LoginEntry loginOut];
//    [LoginEntry loginoutWithParamArrayString:@[@"lessonResponse", @"nowWeek", @"user_id", @"id", @"stuname", @"introduction", @"username", @"nickname", @"gender", @"photo_thumbnail_src", @"photo_src", @"updated_time", @"phone", @"qq",@"switchState"]];
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *remindPath = [path stringByAppendingPathComponent:@"remind.plist"];
    NSString *failurePath = [path stringByAppendingPathComponent:@"failure.plist"];
    NSError *error;
    if ([manager removeItemAtPath:remindPath error:&error]) {
        NSLog(@"%@",error);
    }
    if ([manager removeItemAtPath:failurePath error:&error]) {
        NSLog(@"%@",error);
    }
    [self.navigationController presentViewController:view animated:YES completion:nil];
    //    [self dismissViewControllerAnimated:YES completion:^{
    //
    //    }];
    //    [self.navigationController presentViewController:login animated:YES completion:^{
    //        [LoginEntry loginoutWithParamArrayString:@[@"dataArray", @"weekDataArray", @"nowWeek", @"user_id", @"id", @"stuname", @"introduction", @"username", @"nickname", @"gender", @"photo_thumbnail_src", @"photo_src", @"updated_time", @"phone", @"qq"]];
    //    }];
    
}

@end

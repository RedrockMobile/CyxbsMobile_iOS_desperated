//
//  BeforeClassViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/11.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "BeforeClassViewController.h"
#import "BeforeClassCell.h"
#import "ExamPickView.h"
#import "LessonRemindNotification.h"

@interface BeforeClassViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic)UITableView *beforClassTableView;
@property (strong, nonatomic) BeforeClassCell *cell1;
@property (strong, nonatomic) BeforeClassCell *cell2;
@property (assign, nonatomic) BOOL remindMeEveryDay;
@property (assign, nonatomic) BOOL remindMeEveryClass;
@end

@implementation BeforeClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _beforClassTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, ScreenHeight) style:UITableViewStyleGrouped];
    _beforClassTableView.delegate = self;
    _beforClassTableView.dataSource =self;
    [self.view addSubview:_beforClassTableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getState:) name:@"state" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:@"value" object:nil];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getState:(NSNotification *)notificatio{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([notificatio.object isEqualToString:@"remindMeBeforeTime"]) {
        _cell1.style = @"remindMeBeforeTime";
        _cell1.state = !_cell1.state;
 
    }
    else{
        _cell2.style = @"remindMeTime";
        _cell2.state = !_cell2.state;
        if (_cell2.state) {
            [self XIGAddRemindNotification:[userDefault getAssociatedValueForKey:@"remindMeTime"]];
        }
        else{
            [self XIGDeleteRemindNotification];
        }
    }
}

- (void)getValue:(NSNotification *)notificatio{
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([[notificatio.object substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"分钟"]) {
        _cell1.detailString = [NSString stringWithFormat:@"提前%@",notificatio.object];
        [userDefault setObject:[notificatio.object substringWithRange:NSMakeRange(0, 2)] forKey:@"remindMeBeforeTime"];
    }
    else{
        _cell2.detailString = notificatio.object;
        [userDefault setObject:notificatio.object forKey:@"remindMeTime"];
        [self XIGDeleteRemindNotification];
        [self XIGAddRemindNotification:notificatio.object];
    }
}

#pragma mark 通知更改
- (void)XIGAddRemindNotification:(NSString *)time{
    LessonRemindNotification *remindNotification = [[LessonRemindNotification alloc]init];
    NSArray *array = [time componentsSeparatedByString:@":"];
    [remindNotification addTomorrowNotificationWithMinute:[array lastObject] AndHour:[array firstObject]];
}

- (void)XIGDeleteRemindNotification{
    LessonRemindNotification *remindNotification = [[LessonRemindNotification alloc]init];
    [remindNotification deleteNotification];
}

#pragma mark tableView协议
- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    UILabel *headViewLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREENWIDTH, 20)];
    headViewLab.textColor = kDetailTextColor;
    headViewLab.font = [UIFont fontWithName:@"Arial" size:12];
    if (section == 0) {
        headViewLab.text = @"每节课之前告诉我就好";
    }
    else{
        headViewLab.text = @"每天告诉我一次就好啦";
    }
    [headView addSubview:headViewLab];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
            UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
        UILabel *footViewLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREENWIDTH - 20, 50)];
        footViewLab.textColor = kDetailTextColor;
        footViewLab.font = [UIFont fontWithName:@"Arial" size:12];
        footViewLab.numberOfLines = 0;
        footViewLab.text = @"";
        [footView addSubview:footViewLab];
        return footView;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ((indexPath.row == 1) &&(indexPath.section == 0||indexPath.section == 1)) {
        ExamPickView *views = [[ExamPickView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT + 250)];
        if (indexPath.section == 0) {
            NSArray * beforeArray = @[@"10分钟", @"20分钟", @"30分钟", @"40分钟"];
            views.nameArray = beforeArray;
        }
        else{
            NSArray *timeArray = @[@"19:00", @"20:00", @"21:00", @"22:00"];
            views.nameArray = timeArray;
        }
        [views show];
       
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BeforeClassCell *cell;
    cell.userInteractionEnabled = NO;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [BeforeClassCell cellWithTableView:tableView AndStyle:@"remindMeBeforeTime"];
            cell.nameString = @"每课推送";
            cell.detailString = @"每节课前将收到通知提醒";
            return cell;
        }
        else{
            _cell1 = [BeforeClassCell cellWithTableView:tableView AndStyle:@"extra"];
            _cell1.style = @"remindMeBeforeTime";
            _cell1.nameString = @"提前时间";
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSString *time = [NSString stringWithFormat:@"提前%@分钟",[userDefault objectForKey:@"remindMeBeforeTime"]];
            _cell1.state = [[userDefault objectForKey:@"remindMeBeforeTimeBOOL"] intValue];
            _cell1.detailString = time;
            return _cell1;
        }
    }
      else{
          if (indexPath.row == 0) {
              cell = [BeforeClassCell cellWithTableView:tableView AndStyle:@"remindMeTime"];
              cell.nameString = @"每日推送";
              cell.detailString = @"每天会在约定的时间发送明天的课表";
              return cell;
          }
          else{
              _cell2 = [BeforeClassCell cellWithTableView:tableView AndStyle:@"extra"];
              _cell2.style = @"remindMeTime";
              _cell2.nameString = @"通知时间";
              NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
              NSString *time = [NSString stringWithFormat:@"%@",[userDefault objectForKey:@"remindMeTime"]];
              _cell2.state = [[userDefault objectForKey:@"remindMeTimeBOOL"] intValue];
              _cell2.detailString = time;
              return _cell2;
          }
      }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    else{
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
    
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

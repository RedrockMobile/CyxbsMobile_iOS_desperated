//
//  BeforeClassViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/11.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "BeforeClassViewController.h"
#import "BeforeClassCell.h"

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getState:(NSNotification *)notificatio{
    if ([notificatio.object isEqualToString:@"remindMeBeforeTime"]) {
        _cell1.state = !_cell1.state;
    }
}
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
        footViewLab.text = @"注意：如果遇到不能正常提醒，请在安全软件或系统管理中添加账上重邮到白名单。使用了对齐唤醒技术，所以不要担心影响续航";
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
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BeforeClassCell *cell;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [BeforeClassCell cellWithTableView:tableView AndStyle:@"remindMeBeforeTime"];
            cell.nameString = @"每课推送";
            cell.detailString = @"每节课前将收到通知提醒";

            return cell;
        }
        else{
            _cell1 = [BeforeClassCell cellWithTableView:tableView AndStyle:@"extra"];
            _cell1.nameString = @"提前时间";
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSString *time = [NSString stringWithFormat:@"提前%@分钟",[userDefault objectForKey:@"remindMeBeforeTime"]];
            _cell1.detailString = time;
            return _cell1;
        }
    }
      else{
          if (indexPath.row == 0) {
              cell = [BeforeClassCell cellWithTableView:tableView AndStyle:@"remindMeTime"];
              cell.nameString = @"每课推送";
              cell.detailString = @"每节课前将收到通知提醒";
              return cell;
          }
          else{
              _cell2 = [BeforeClassCell cellWithTableView:tableView AndStyle:@"extra"];
              _cell2.nameString = @"提前时间";
              NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
              NSString *time = [NSString stringWithFormat:@"提前%@分钟",[userDefault objectForKey:@"remindMetime"]];
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

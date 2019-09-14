//
//  LQQchooseCollegeViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/8.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "LQQchooseCollegeViewController.h"
#import "LQQDataModel.h"
#import "LQQshuJuJieMiViewController.h"
@interface LQQchooseCollegeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)LQQDataModel*INeedData;


@end

@implementation LQQchooseCollegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self buildMyNavigationbar];
    _INeedData = [LQQDataModel sharedSingleton];
    UITableView*tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height - 49 - TOTAL_TOP_HEIGHT) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:245/255.0 blue:255/255.0 alpha:1];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setSeparatorColor:[UIColor colorWithRed:235/255.0 green:245/255.0 blue:255/255.0 alpha:1]];
    [self.view addSubview:tableView];
    self.view.backgroundColor = tableView.backgroundColor;
    self.navigationController.navigationBar.topItem.title = @"";
//    self.view.backgroundColor = [UIColor clearColor];
}
- (void)buildMyNavigationbar{
    

    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"数据揭秘";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:19];
    [titleView addSubview:titleLabel];
    
    
    self.navigationItem.titleView = titleView;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.centerX.equalTo(titleView);
        make.centerY.equalTo(titleView);
    }];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _INeedData.xueYuanName.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
UITableViewCell *cell/* = [tableView dequeueReusableCellWithIdentifier:@"LQcell"]*/;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LQcell"];
        cell.contentView.backgroundColor = [UIColor colorWithRed:235/255.0 green:245/255.0 blue:255/255.0 alpha:1];
    }
//    cell.backgroundColor = [UIColor redColor];
    UIImageView*backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 53)];
    UILabel*xueYuan = [[UILabel alloc]init];
    xueYuan.text = _INeedData.xueYuanName[indexPath.section];
    [backImageView addSubview:xueYuan];
    
    [xueYuan setFont:[UIFont systemFontOfSize:15]];
    [xueYuan setTextColor:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f]];
    [xueYuan mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(backImageView);
        make.centerY.equalTo(backImageView);
        make.left.equalTo(backImageView).offset(30);
    }];

    [backImageView setImage:[UIImage imageNamed:@"LQQcellImage"]];
//    cell.imageView =backImageView;
//    [backImageView setContentMode:UIViewContentModeScaleAspectFit];
    [cell.contentView addSubview:backImageView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return /*self.view.height*(1227.0-1090-107)/(1440-145-97)*/0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, self.view.height*(1227.0-1090-107)/(1440-145-97))];
    view.backgroundColor = [UIColor colorWithRed:233/255.0 green:245/255.0 blue:255/255.0 alpha:1];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.usersXueYuan =_INeedData.xueYuanName[indexPath.section];
    NSLog(@"用户选择的是%@",_usersXueYuan);
    LQQshuJuJieMiViewController* sjjm = [[LQQshuJuJieMiViewController alloc] init];
    sjjm.userXueYuan = _usersXueYuan;
    sjjm.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:245/255.0 blue:255/255.0 alpha:1];
    [self.navigationController pushViewController:sjjm animated:YES];
    
    //发一个通知给dataMode;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LQQuserCollege" object:nil userInfo:@{@"用户选择的学院":_usersXueYuan}];


    
    
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    [view setBackgroundColor:[UIColor colorWithRed:235/255.0 green:245/255.0 blue:255/255.0 alpha:1]];
}


@end

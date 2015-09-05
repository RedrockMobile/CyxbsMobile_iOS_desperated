//
//  ViewController.m
//  重邮小帮手
//
//  Created by 1808 on 15/8/19.
//  Copyright (c) 2015年 1808. All rights reserved.
//

#import "NewsViewController.h"
#import "MeCell.h"
#import "FirstViewController.h"
#import "NetWork.h"
#import "MJRefresh.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UIRefreshControl *refresh;
@property (strong,nonatomic) NSMutableDictionary *data;
@property (strong,nonatomic) UITableView  *tableView;
@property (strong, nonatomic) NSMutableArray *BothData;
@property (assign, nonatomic) NSInteger flag;

@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation NewsViewController

- (void)viewDidLoad {
  
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"教务信息";
    [super viewDidLoad];
    _flag = 1;
    [self setupRefresh];
    self.data = [[NSMutableDictionary alloc] init];
    _BothData = [[NSMutableArray alloc] init];
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/jwNewsList" WithParameter:@{@"page":@"1"} WithReturnValeuBlock:^(id returnValue) {
            self.data = returnValue;
            for (int i = 0; i<[self.data[@"data"] count]; i++) {
                [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/jwNewsContent" WithParameter:@{@"id":self.data[@"data"][i][@"id"]} WithReturnValeuBlock:^(id returnValue) {
                    NSMutableDictionary *dic = [self.data[@"data"][i] mutableCopy];
                    [dic setValue:returnValue[@"data"][@"content"] forKey:@"newsContent"];
                    [_BothData addObject:dic];
                    [_tableView reloadData];
                } WithFailureBlock:nil];
            }
    } WithFailureBlock:nil];
    [self.view addSubview:self.tableview];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];

    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉即可刷新";
    self.tableView.headerReleaseToRefreshText = @"松开即可刷新";
    self.tableView.headerRefreshingText = @"正在刷新中";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多";
    self.tableView.footerRefreshingText = @"正在刷新中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing{
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/jwNewsList" WithParameter:@{@"page":@"1"} WithReturnValeuBlock:^(id returnValue) {
        self.data = returnValue;
        for (int i = 0; i<[self.data[@"data"] count]; i++) {
            [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/jwNewsContent" WithParameter:@{@"id":self.data[@"data"][i][@"id"]} WithReturnValeuBlock:^(id returnValue) {
                NSMutableDictionary *dic = [self.data[@"data"][i] mutableCopy];
                [dic setValue:returnValue[@"data"][@"content"] forKey:@"newsContent"];
                [_BothData addObject:dic];
                [_tableView reloadData];
            } WithFailureBlock:nil];
        }
    } WithFailureBlock:nil];
}

//初始化tableview

- (UITableView *)tableview
{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,64, MAIN_SCREEN_W, MAIN_SCREEN_H) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        UINib *nib = [UINib nibWithNibName:@"MeCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
        _tableView.separatorStyle = NO;
    }
    return _tableView;
    
}
//一组多少个
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//分成多少个组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_BothData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = @"cell";
    MeCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[MeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
        cell.backview.layer.cornerRadius = 10;

    cell.toplable.text = _BothData[indexPath.section][@"title"];
    cell.daylable.text = _BothData[indexPath.section][@"date"];
     cell.timelabel.text = _BothData[indexPath.section][@"read"];
    cell.specificlable.text = _BothData[indexPath.section][@"newsContent"];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//实现 tableView点动
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FirstViewController *fvc = [[FirstViewController alloc]init];
    //NSLog(@"%@",self.data);
    fvc.data1 = [[NSMutableDictionary alloc] init];
    fvc.data1 = _BothData[indexPath.section];
   // DDLog(@"dTA1：%@",_data[@"data"]);
    [self.navigationController pushViewController:fvc animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 1;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 5.0;
//}

@end

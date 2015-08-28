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
@property (strong,nonatomic)UITableView  *tableview;
@property (strong,nonatomic)NSMutableArray *infos;
@property (strong, nonatomic)NSMutableArray *BothData;
@end

@implementation NewsViewController

- (void)viewDidLoad {
  
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"教务信息";
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0 green:90 blue:50 alpha:1];
    [super viewDidLoad];
    self.data = [[NSMutableDictionary alloc] init];
    _BothData = [[NSMutableArray alloc] init];
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/jwNewsList" WithParameter:@{@"page":@"1"} WithReturnValeuBlock:^(id returnValue) {
            self.data = returnValue;
            for (int i = 0; i<[self.data[@"data"] count]; i++) {
                [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/jwNewsContent" WithParameter:@{@"id":self.data[@"data"][i][@"id"]} WithReturnValeuBlock:^(id returnValue) {
                    NSMutableDictionary *dic = [self.data[@"data"][i] mutableCopy];
                    [dic setValue:returnValue[@"data"][@"content"] forKey:@"newsContent"];
                    [_BothData addObject:dic];
                    [_tableview reloadData];
                } WithFailureBlock:nil];
            }
    } WithFailureBlock:nil];
    
    
//self.specificlable.text = self.data2[@"data"][@"content"];
  
    
//
//  MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
   
       // 马上进入刷新状态
    [self.tableview.header beginRefreshing];
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
      
  
} 
//
- (NSString *)loadNewData
{
    self.data = [[NSMutableDictionary alloc] init];
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/jwNewsList" WithParameter:@{@"page":@"1"} WithReturnValeuBlock:^(id returnValue) {
        _data = [returnValue objectForKey:@"data"];

        self.data = returnValue;

        [_tableview reloadData];
        
    } WithFailureBlock:^{
        
    }];
    return @"200";
}
- (NSString *)loadMoreData
{
    self.data = [[NSMutableDictionary alloc] init];
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/jwNewsList" WithParameter:@{@"page":@"2"} WithReturnValeuBlock:^(id returnValue) {
        _data = [returnValue objectForKey:@"data"];
        self.data = returnValue;
        [_tableview reloadData];
    } WithFailureBlock:^{
        
    }];
    return @"222";
}

//初始化tableview

- (UITableView *)tableview
{
    int x = [[UIScreen mainScreen]bounds].size.width;
    int y = [[UIScreen mainScreen]bounds].size.height ;
    if (!_tableview) {
        _tableview =[[UITableView alloc]initWithFrame:CGRectMake(0,5, x, y) style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        UINib *nib = [UINib nibWithNibName:@"MeCell" bundle:nil];
        [_tableview registerNib:nib forCellReuseIdentifier:@"cell"];
        _tableview.separatorStyle = NO;
    }
    return _tableview;
    
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
//    cell.backview.layer.shadowColor = [[UIColor blueColor]CGColor];
//    cell.backview.layer.shadowRadius = 4.0;
//    cell.backview.layer.shadowOffset = CGSizeMake(4, 4);
    cell.toplable.text = _BothData[indexPath.section][@"title"];
    cell.daylable.text = _BothData[indexPath.section][@"date"];
     cell.timelabel.text = _BothData[indexPath.section][@"read"];
    cell.specificlable.text = _BothData[indexPath.section][@"newsContent"];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSLog(@"%@",_BothData[indexPath.section]);
//     cell.specificlable.text = self.data[@"data"][indexPath.section][@"id"];
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
    fvc.data1 = self.data[@"data"][indexPath.section];
    [self.navigationController pushViewController:fvc animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 1;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 5.0;
//}



- (void)viewDidAppear:(BOOL)animated{
    
    

    [self.view addSubview:self.tableview];
}

@end

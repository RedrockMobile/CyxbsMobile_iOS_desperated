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

@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation NewsViewController

static int nowPage= 1;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"教育信息";
    self.navigationController.navigationBar.barTintColor = MAIN_COLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    _flag = 1;
    _data = [[NSMutableDictionary alloc] init];
    _BothData = [[NSMutableArray alloc] init];
    
    [self.view addSubview:self.tableview];
    [self setupRefresh];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(dataFresh)];
//     2.上拉加载更多(进入刷新状态就会调用self的footerRefreshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉即可刷新";
    self.tableView.headerReleaseToRefreshText = @"松开即可刷新";
    self.tableView.headerRefreshingText = @"正在刷新中";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多";
    self.tableView.footerRefreshingText = @"玩命加载中";
}

#pragma mark 开始进入刷新状态
- (void)footerRefreshing{
    
    [self dataFresh:EnumDataAdd];

}

//初始化tableview

- (UITableView *)tableview
{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,64, MAIN_SCREEN_W, MAIN_SCREEN_H-64-44) style:UITableViewStylePlain];
        [self dataFresh];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        UINib *nib = [UINib nibWithNibName:@"MeCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
       _tableView.separatorStyle = YES;
        
    }
    return _tableView;
}

- (void)dataFresh{
    [self dataFresh:EnumDataRefresh];
}

- (void)dataFresh:(EnumFreshType)type{
    
    //判断是否刷新了页数page
    void (^typeFunction)(id objet);
    switch (type) {
        case EnumDataRefresh:
            nowPage=1;
         typeFunction = ^(NSMutableArray *object){
             [object removeAllObjects];
         };
            break;
        case EnumDataAdd:
            nowPage++;
            typeFunction = ^(NSMutableArray *object){};
            break;
        default:
            typeFunction = ^(NSMutableArray *object){
                [object removeAllObjects];
                
            };
            break;
    }
    
    //开始网络请求
    
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/jwNewsList"
                            WithParameter:@{@"page":[NSNumber numberWithInt:nowPage]}
                     WithReturnValeuBlock:^(id returnValue) {
        //开始转菊花
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.frame = CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H);
        [_indicatorView setCenter:CGPointMake(MAIN_SCREEN_W/2, MAIN_SCREEN_H/2)];
        [self.view addSubview:_indicatorView];
        [_indicatorView startAnimating];
        
        typeFunction(_BothData);
                         
        self.data = returnValue;
        for (int i = 0; i<[self.data[@"data"] count]; i++) {
            [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/jwNewsContent" WithParameter:@{@"id":self.data[@"data"][i][@"id"]} WithReturnValeuBlock:^(id returnValue) {
                NSMutableDictionary *dic = [self.data[@"data"][i] mutableCopy];
                NSString *contentDetail = returnValue[@"data"][@"content"];
                
                contentDetail = [contentDetail stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                [dic setValue:contentDetail forKey:@"newsContent"];
                [_BothData addObject:dic];
                [_tableView reloadData];

                [_indicatorView stopAnimating];
            } WithFailureBlock:nil];
        }
                         
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    } WithFailureBlock:nil];
}

#pragma mark - tableViewDeleget

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
    cell.backview.layer.cornerRadius = 0;
    
    tableView.separatorInset = UIEdgeInsetsMake(0, 1, 0, 8);//修改分隔线长度
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    cell.toplable.text = _BothData[indexPath.section][@"title"];
    cell.daylable.text = _BothData[indexPath.section][@"date"];
    cell.specificlable.text = _BothData[indexPath.section][@"newsContent"];

    cell.backview.layer.cornerRadius = 1;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 109;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FirstViewController *fvc = [[FirstViewController alloc]init];

    fvc.data1 = [[NSMutableDictionary alloc] init];
    fvc.data1 = _BothData[indexPath.section];
    fvc.info = _data;

    [self.navigationController pushViewController:fvc animated:YES];
}

@end

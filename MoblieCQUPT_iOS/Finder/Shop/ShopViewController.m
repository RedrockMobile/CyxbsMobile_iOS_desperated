//
//  ShopViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/19.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopTableViewCell.h"
#import "ShopDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+AFNetworking.h"
#import "MJRefresh.h"
#import "WebViewController.h"

#define SHOPLIST_ENDPAGE 4

#define __kScreenWidth [UIScreen mainScreen].bounds.size.width
#define __kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ShopViewController ()<UITableViewDelegate, UITableViewDataSource,UIViewControllerPreviewingDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;
@property (assign, nonatomic) NSInteger flag;//标记页数

@end

@implementation ShopViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"周边美食";
    _flag = 1;
    
    [self setupRefresh];
    [self.view addSubview:self.tableView];
    //注册Peek和Pop方法
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
}


#pragma mark 开始进入刷新状态
- (void)headerRereshing{
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/shopList" WithParameter:@{@"pid":@1} WithReturnValeuBlock:^(id returnValue) {
        [_data removeAllObjects];
        
        [_data addObjectsFromArray:[returnValue objectForKey:@"data"]];
        // 刷新表格
        [self.tableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        UILabel *faileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        faileLable.text = @"哎呀！网络开小差了 T^T";
        faileLable.textColor = [UIColor blackColor];
        faileLable.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        faileLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:faileLable];
        [_tableView removeFromSuperview];
    }];
}

- (void)footerRereshing{
    _flag ++;
    if (_flag <= 3) {
        [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/shopList" WithParameter:@{@"pid":[NSNumber numberWithInteger:_flag]} WithReturnValeuBlock:^(id returnValue) {
            [_data addObjectsFromArray:[returnValue objectForKey:@"data"]];
            // 刷新表格
            [self.tableView reloadData];
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        } WithFailureBlock:^{
            UILabel *faileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
            faileLable.text = @"哎呀！网络开小差了 T^T";
            faileLable.textColor = [UIColor blackColor];
            faileLable.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
            faileLable.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:faileLable];
            [_tableView removeFromSuperview];
        }];
    }else if (_flag >= 4){
        [self.tableView.mj_footer endRefreshing];
    }
}

//覆盖初始化方法
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
       [self dataFlash];
        _tableView.delegate = self;
        _tableView.dataSource = self;

        UINib *nib = [UINib nibWithNibName:@"ShopTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    }
    
    return _tableView;
}

- (void)dataFlash{
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/shopList" WithParameter:@{@"pid":@1} WithReturnValeuBlock:^(id returnValue) {

        _data = [[NSMutableArray alloc] init];
        [_data addObjectsFromArray:[returnValue objectForKey:@"data"]];
        [_tableView reloadData];

    } WithFailureBlock:^{
        UILabel *failLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        failLabel.text = @"哎呀！网络开小差了 T^T";
        failLabel.textColor = [UIColor blackColor];
        failLabel.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        failLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:failLabel];
        [_tableView removeFromSuperview];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[ShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }

    [cell.picture setImageWithURL:[NSURL URLWithString:_data[indexPath.row][@"shopimg_src"]]];
    cell.nameLabel.text = _data[indexPath.row][@"name"];
    cell.addressLabel.text = _data[indexPath.row][@"shop_address"];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//取消cell选中状态
    ShopDetailViewController *detailViewController = [[ShopDetailViewController alloc] init];
    detailViewController.detailData = _data[indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end

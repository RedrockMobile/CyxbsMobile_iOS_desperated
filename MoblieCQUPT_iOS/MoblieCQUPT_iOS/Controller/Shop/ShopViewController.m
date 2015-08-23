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


@interface ShopViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NSArray *data;

@end

@implementation ShopViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.navigationItem.title = @"周边小店";
    
    /*********************下拉刷新功能**************************/
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置文字
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    
//    [self dataFlash];
//    CGRect screenSize = [UIScreen mainScreen].bounds;
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenSize.size.width, screenSize.size.height)];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    
//    UINib *nib = [UINib nibWithNibName:@"ShopTableViewCell" bundle:nil];//从当前工程中识别xib文件
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
}

- (NSString *)loadNewData
{
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/shopList" WithParameter:@{@"pid":@1} WithReturnValeuBlock:^(id returnValue) {
        _data = [[NSArray alloc] init];
        _data = [returnValue objectForKey:@"data"];
        NSLog(@"data is %@", returnValue);
        [_tableView reloadData];
    } WithFailureBlock:nil];
    return @"222";
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
       [self dataFlash];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//
        UINib *nib = [UINib nibWithNibName:@"ShopTableViewCell" bundle:nil];//从当前工程中识别xib文件
        [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    }
    
    return _tableView;
}

- (void)dataFlash{
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/shopList" WithParameter:@{@"pid":@1} WithReturnValeuBlock:^(id returnValue) {
        _data = [[NSArray alloc] init];
        _data = [returnValue objectForKey:@"data"];
        NSLog(@"data is %@", returnValue);
        [_tableView reloadData];
    } WithFailureBlock:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

//分成多少个组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";//cell重用标识
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[ShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];//构造一个cell
    }

    [cell.picture setImageWithURL:[NSURL URLWithString:_data[indexPath.row][@"shopimg_src"]]];
//    DDLog(@"%@",_data[indexPath.row][@"shopimg_src"]);
    cell.nameLabel.text = _data[indexPath.row][@"name"];
    cell.addressLabel.text = _data[indexPath.row][@"shop_address"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopDetailViewController *detailViewController = [[ShopDetailViewController alloc] init];
    [detailViewController.picture setImageWithURL:[NSURL URLWithString:_data[indexPath.row][@"shopimg_src"]]];
    detailViewController.nameLabel.text = _data[indexPath.row][@"name"];
    detailViewController.addressLabel.text = _data[indexPath.row][@"shop_address"];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

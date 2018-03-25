//
//  ZJShopViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 周杰 on 2017/11/20.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "ZJShopViewController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "ZJshopTableViewCell.h"
#import "ZJShopDeatilViewController.h"

@interface ZJShopViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (retain, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayData;//存储店铺数据
@property (assign, nonatomic) NSInteger page;//标记页数
@end

@implementation ZJShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"周边美食";
//    _arrayData = [[NSMutableArray alloc]init];
    _page = 1;
    [self getInformation];
    [self setupRefresh];

}

//设置刷新控件+
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}

//懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT-HEADERHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UINib *nib = [UINib nibWithNibName:@"ZJshopTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"shopPidOne"];
        [self getInformation];
    }
    return _tableView;
}

- (void) getInformation{
    [HttpClient requestWithPath:@"https://wx.idsbllp.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/shopList" method:HttpRequestPost parameters:@{@"pid":@1} prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        _arrayData = [[NSMutableArray alloc]init];
        [self.view addSubview:self.tableView];
        [_arrayData addObjectsFromArray:[responseObject objectForKey:@"data"]];
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UILabel *failLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        failLabel.text = @"哎呀！网络开小差了 T^T";
        failLabel.textColor = [UIColor blackColor];
        failLabel.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        failLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:failLabel];
        [_tableView removeFromSuperview];
    }];
}


#pragma mark 开始进入刷新状态
//头部刷新
- (void)headerRefresh{
    _page = 1;
    [HttpClient requestWithPath:@"https://wx.idsbllp.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/shopList" method:HttpRequestPost parameters:@{@"pid":@1} prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [_arrayData removeAllObjects];
        [_arrayData addObjectsFromArray:[responseObject objectForKey:@"data"]];
        //刷新表格
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UILabel *faileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        faileLable.text = @"哎呀！网络开小差了 T^T";
        faileLable.textColor = [UIColor blackColor];
        faileLable.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        faileLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:faileLable];
        [_tableView removeFromSuperview];
    }];
}

//尾部刷新
- (void)footerRefresh{
    _page++ ;
    if (_page <= 3) {
        [HttpClient requestWithPath:@"https://wx.idsbllp.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/shopList" method:HttpRequestPost parameters:@{@"pid":[NSNumber numberWithInteger:_page]} prepareExecute:^{
            
        } progress:^(NSProgress *progress) {
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            [_arrayData addObjectsFromArray:[responseObject objectForKey:@"data"]];
            //刷新表格
            [self.tableView reloadData];
            
            [self.tableView.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            UILabel *faileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
            faileLable.text = @"哎呀！网络开小差了 T^T";
            faileLable.textColor = [UIColor blackColor];
            faileLable.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
            faileLable.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:faileLable];
            [_tableView removeFromSuperview];
        }];
    }else if (_page >= 4 ){
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - table view datasource
//返回个数为数组的长度
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayData.count;
}
//一个section存储一家店铺信息
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"shopCellOne";
    ZJshopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
//        cell = [[ZJshopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJshopTableViewCell" owner:self options:nil]firstObject];
    }
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:_arrayData[indexPath.row][@"shopimg_src"]]];
    cell.shopNameLabel.text = _arrayData[indexPath.row][@"name"];
    cell.shopAddressLabel.text = _arrayData[indexPath.row][@"shop_address"];
    cell.shopAddressLabel.font = [UIFont systemFontOfSize:12];
    cell.shopAddressLabel.numberOfLines = 2;
    //cell图片约束 上左正 下右负
    //cell店铺图片约束
    [cell.picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.mas_left).offset(17);
        make.top.mas_equalTo(cell.mas_top).offset(17);
        make.bottom.mas_equalTo(cell.mas_bottom).offset(-17);
        make.right.equalTo(cell.shopNameLabel.mas_left).offset(-11);
        make.right.equalTo(cell.shopAddressLabel.mas_left).offset(-11);
    }];
    //cell店铺名约束
    [cell.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cell.mas_top).offset(17);
        make.bottom.equalTo(cell.shopAddressLabel.mas_top).offset(-17);
        make.right.mas_equalTo(cell.mas_right).offset(-10);
        make.left.mas_equalTo(cell.mas_left).offset(154);
    }];
     
    //cell店铺地址约束
    [cell.shopAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(cell.mas_bottom).offset(-43);
        make.right.mas_equalTo(cell.mas_right).offset(-10);
        make.height.mas_equalTo(30);
    }];
    return cell;
}
//设置每一个section的高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

//点击cell跳转到下一个界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//取消cell选中状态
    ZJShopDeatilViewController *detailViewController = [[ZJShopDeatilViewController alloc]init];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    detailViewController.detailData = _arrayData[indexPath.row];
}


@end

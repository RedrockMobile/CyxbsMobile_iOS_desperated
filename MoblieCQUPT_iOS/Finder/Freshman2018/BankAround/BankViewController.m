//
//  BankViewController.m
//
//
//  Created by 陈大炮 on 2018/8/17.
//  Copyright © 2018年 陈大炮. All rights reserved.
//

#import "BankViewController.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import <AFNetworking.h>
#import "BankTableViewCell.h"
#define  SCREEN_Width [UIScreen mainScreen].bounds.size.width / 375
@interface BankViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrData;

@end

@implementation BankViewController
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT-HEADERHEIGHT) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self getInformation];
    }
    return _tableView;
}

- (void)getInformation{
    NSDictionary *parameter = @{
                                @"index":@"附近银行",
                                @"pagenum":@"1",
                                @"pagesize":@"10"
                                };
    
    NSString *URL = @"http://wx.yyeke.com/welcome2018/data/get/byindex";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_arrData addObjectsFromArray:[responseObject objectForKey:@"array"]];
        NSLog(@"%@",_arrData);
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UILabel *failLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        failLabel.text = @"哎呀！网络开小差了 T^T";
        failLabel.textColor = [UIColor blackColor];
        failLabel.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        failLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:failLabel];
        [_tableView removeFromSuperview];
    }];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"cellOne";
    static  NSString *pictireString = @"http://47.106.33.112:8080/welcome2018";
    BankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    
//    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BankTableViewCell" owner:self options:nil]firstObject];
    }
    cell.bankName.text = _arrData[indexPath.section][@"name"];
    cell.bankAddress.text = _arrData[indexPath.section][@"content"];
    NSString *picURL = [NSString stringWithFormat:@"%@%@",pictireString,_arrData[indexPath.section][@"picture"][0]];
    NSLog(@"%@",picURL);
    cell.bankAddress.numberOfLines = 0;
    [cell.bankImage sd_setImageWithURL:[NSURL URLWithString:picURL]];
 
    cell.bankImage.layer.cornerRadius = 6;
    cell.bankImage.layer.masksToBounds = YES;
    
    [cell.bankImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.mas_left).offset(15);
        make.top.mas_equalTo(cell.mas_top).offset(15);
        make.bottom.mas_equalTo(cell.mas_bottom).offset(-15);
        make.right.equalTo(cell.bankName.mas_left).offset(-15);
        make.right.equalTo(cell.bankAddress.mas_left).offset(-15);
    }];
    [cell.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cell.mas_top).offset(10);
        make.bottom.equalTo(cell.bankAddress.mas_top).offset(-12);
        make.right.mas_equalTo(cell.mas_right).offset(-10);
        make.left.mas_equalTo(cell.mas_left).offset(132);
    }];
    [cell.bankAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(cell.mas_bottom).offset(-25);
        make.right.mas_equalTo(cell.mas_right).offset(-25);
//        make.height.mas_equalTo(40);
    }];
    
    cell.layer.cornerRadius = 6;
    cell.layer.masksToBounds = YES;
  
    
    return cell;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrData.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//取消选中状态
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arrData = [NSMutableArray array];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

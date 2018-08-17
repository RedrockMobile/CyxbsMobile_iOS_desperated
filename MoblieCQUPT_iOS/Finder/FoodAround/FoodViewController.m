//
//  FoodViewController.m
//  迎新
//
//  Created by 陈大炮 on 2018/8/15.
//  Copyright © 2018年 陈大炮. All rights reserved.
//

#import "FoodViewController.h"
#import "FoodModel.h"
#import "FoodTableViewCell.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#define  SCREEN_Width [UIScreen mainScreen].bounds.size.width / 375

@interface FoodViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrData;
@end

@implementation FoodViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT-HEADERHEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self getInformation];
    }
    return _tableView;
}

- (void)getInformation{
    NSDictionary *paramter = @{
                               @"index":@"周边美食",
                               @"pagesize":@11,
                               @"pagenum":@1
                               };
    NSString *url = @"http://47.106.33.112:8080/welcome2018/data/get/byindex";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [_arrData addObjectsFromArray:[responseObject objectForKey:@"array"]];

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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
//    [self tableView];
    _arrData = [NSMutableArray array];
    UILabel * label = [[UILabel alloc]init];
     label.frame = CGRectMake(0, HEADERHEIGHT, SCREEN_Width, 48 *SCREEN_Width);
    label.textColor = [UIColor blackColor];
    NSString *str = @"最受好评的top5家美食";
    label.backgroundColor = [UIColor blueColor];
    label.text = str;
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:label];
      [self.view addSubview:label];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 2){
        return 400 * SCREEN_Width;
    }
    return 370 * SCREEN_Width;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *cellIdentity = @"cellOne";
    static  NSString *pictireString = @"http://47.106.33.112:8080/welcome2018";

    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FoodTableViewCell" owner:self options:nil]firstObject];
    }
    cell.nameLabel.text = _arrData[indexPath.section][@"name"];
    cell.illstrateLabel.text = _arrData[indexPath.section][@"content"];
    NSString *picURL = [NSString stringWithFormat:@"%@%@",pictireString,_arrData[indexPath.section][@"picture"][0]];

    cell.rankButton.userInteractionEnabled= NO;
    
    NSLog(@"%@",_arrData[indexPath.section][@"id"]);
    NSString *rankStrng = [NSString stringWithFormat:@"%@",_arrData[indexPath.section][@"id"]];
    [cell.rankButton setTitle:rankStrng forState:UIControlStateNormal];
    cell.rankButton.titleLabel.text = rankStrng;
    NSString *priceString = [NSString stringWithFormat:@"￥ %@ （人）",_arrData[indexPath.section][@"property"]];
    cell.priceLabel.text = priceString;
    [cell.contentView bringSubviewToFront:cell.rankButton];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:picURL]];

    [cell.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.mas_left).offset(0 * SCREEN_Width);
        make.top.mas_equalTo(cell.mas_top).offset(10 * SCREEN_Width);
        make.right.mas_equalTo(cell.mas_right).offset(-15 * SCREEN_Width);
        make.bottom.mas_equalTo(cell.nameLabel.mas_top).offset(-10 * SCREEN_Width);
        make.bottom.mas_equalTo(cell.priceLabel.mas_top).offset(-10 * SCREEN_Width);
   
    }];
    [cell.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(cell.mas_left).offset(15 * SCREEN_Width);
        make.right.mas_equalTo(cell.mas_right).offset(-200 * SCREEN_Width);
        make.bottom.mas_equalTo(cell.illstrateLabel.mas_top).offset(-4 * SCREEN_Width);
        
    }];
    [cell.illstrateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cell.mas_right).offset(-30 * SCREEN_Width);
        make.left.mas_equalTo(cell.mas_left).offset(15 * SCREEN_Width);
        make.bottom.mas_equalTo(cell.mas_bottom).offset(-5 * SCREEN_Width);
    }];
    [cell.rankButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.mas_left).offset(290* SCREEN_Width);
        make.right.mas_equalTo(cell.mas_right).offset(-30* SCREEN_Width);
        make.height.mas_equalTo(35* SCREEN_Width);
    }];
    [cell.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.mas_left).offset(240 * SCREEN_Width);
        make.right.mas_equalTo(cell.mas_right).offset(-20 * SCREEN_Width);
        make.bottom.mas_equalTo(cell.illstrateLabel.mas_top).offset(-4 * SCREEN_Width);
    }];
    
    
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//取消选中状态
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

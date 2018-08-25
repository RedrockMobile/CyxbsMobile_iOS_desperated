//
//  SchoolViewController.m
//  迎新
//
//  Created by 陈大炮 on 2018/8/15.
//  Copyright © 2018年 陈大炮. All rights reserved.
//

#import "SchoolViewController.h"
#import <AFNetworking.h>
#import "FoodTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "PictureSize.h"
#define  SCREEN_Width [UIScreen mainScreen].bounds.size.width / 375

@interface SchoolViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) UIImageView *cellImage;

@end

@implementation SchoolViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT-HEADERHEIGHT)  style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self getInformation];
    }
    return _tableView;
}
- (void)getInformation{
    NSDictionary *parameter = @{
                                @"index":@"校园环境",
                                @"pagenum":@"1",
                                @"pagesize":@"7"
                             
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
        return 300 *SCREEN_Width;
    }
    else if(indexPath.section == 3){
        return 330 *SCREEN_Width;
    }else if (indexPath.section ==
              5){
        return 330 *SCREEN_Width;
    }
        else{
        return  350 * SCREEN_Width;}
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"cellOne";
      static  NSString *pictireString = @"http://47.106.33.112:8080/welcome2018";
  
    
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FoodTableViewCell" owner:self options:nil]firstObject];
    }
    cell.nameLabel.text = _arrData[indexPath.section][@"name"];
    cell.illstrateLabel.text = _arrData[indexPath.section][@"content"];
    cell.illstrateLabel.textColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
    NSString *picURL = [NSString stringWithFormat:@"%@%@",pictireString,_arrData[indexPath.section][@"picture"][0]];
    NSLog(@"%@",picURL);
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:picURL]];
    
    cell.imgView.layer.cornerRadius = 6;
     cell.imgView.layer.masksToBounds = YES;
    
//    cell.imgView.contentMode = UIViewContentModeScaleAspectFill;
    [cell.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(cell.mas_left).offset(15  * SCREEN_Width);
        make.top.mas_equalTo(cell.mas_top).offset(15 * SCREEN_Width);
        make.right.mas_equalTo(cell.mas_right).offset(-15 * SCREEN_Width);
        make.bottom.mas_equalTo(cell.nameLabel.mas_top).offset(-21 * SCREEN_Width);
        make.bottom.mas_equalTo(cell.illstrateLabel.mas_top).offset(-43 * SCREEN_Width);
        make.bottom.mas_equalTo(cell.mas_bottom).offset(-142 * SCREEN_Width);
    }];
    
    [cell.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.mas_left).offset(15 * SCREEN_Width);
        make.right.mas_equalTo(cell.mas_right).offset(-200 * SCREEN_Width);
        make.bottom.mas_equalTo(cell.illstrateLabel.mas_top).offset(-8 * SCREEN_Width);
    }];
    
    [cell.illstrateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cell.mas_right).offset(-15 * SCREEN_Width);
        make.left.mas_equalTo(cell.mas_left).offset(15 * SCREEN_Width);
        make.bottom.mas_equalTo(cell.mas_bottom).offset(-19 * SCREEN_Width);
    }];
    
    cell.priceLabel.hidden = YES;
    cell.rankButton.hidden = YES;
    
    
    cell.layer.cornerRadius = 6;
    cell.layer.masksToBounds = YES;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    _cellImage = cell.imgView;
    
    cell.imgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(magnifyImag)];
    
    [cell.imgView addGestureRecognizer:tap];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//取消选中状态
}

-(void)magnifyImag
{
    [PictureSize showImage:self.cellImage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arrData = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

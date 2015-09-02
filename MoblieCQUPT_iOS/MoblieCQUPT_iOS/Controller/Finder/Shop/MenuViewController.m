//
//  MenuViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/28.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "MenuViewController.h"
#import "UIImage+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "NetWork.h"
#import "ShopTableViewCell.h"
#import "ProgressHUD.h"

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *returnButton;

@property (strong, nonatomic) UITableView *tabelView;
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) UITableView *tableView;


@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [[NSMutableArray alloc] init];
    [_returnButton addTarget:self
                      action:@selector(returnView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.tableView];
}

//覆盖初始化方法
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 100, MAIN_SCREEN_W-20*2, MAIN_SCREEN_H/2)];
        NSLog(@"%@",_shopId);
        [self dataFlash];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        UINib *nib = [UINib nibWithNibName:@"ShopTableViewCell" bundle:nil];//从当前工程中识别xib文件
        [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    }
    
    return _tableView;
}

- (void)dataFlash{
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/menuList" WithParameter:@{@"shop_id":_shopId} WithReturnValeuBlock:^(id returnValue) {
        [ProgressHUD show:@"加载中..."];
        
        [_data addObjectsFromArray:[returnValue objectForKey:@"data"]];
        [_tableView reloadData];
        [ProgressHUD showSuccess:@"加载完成~"];
    } WithFailureBlock:^{
        UILabel *failLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        failLabel.text = @"哎呀！网络开小差了 T^T";
        failLabel.textColor = [UIColor whiteColor];
        failLabel.backgroundColor = [UIColor grayColor];
        failLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:failLabel];
        [_tableView removeFromSuperview];
    }];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";//cell重用标识
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[ShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];//构造一个cell
    }
    
    [cell.picture setImageWithURL:[NSURL URLWithString:_data[indexPath.section][@"dish_image"]]];
    cell.nameLabel.text = @"菜品名：";
    cell.addressLabel.text = _data[indexPath.section][@"dish_name"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)returnView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

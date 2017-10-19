//
//  ShopDetailViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/19.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+AFNetworking.h"
#import "WebViewController.h"
#import "NetWork.h"
#import "ProgressHUD.h"
#import "MenuViewController.h"

@interface ShopDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *detailDishButton;
@property (strong, nonatomic) NSMutableArray *menu;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *picture;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *addressLabel;

@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNetData];
    [self.view addSubview:self.scrollView];
    _picture = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, 190)];
    [self.scrollView addSubview:_picture];
    _menu = [[NSMutableArray alloc] init];
    
    if (_detailData) {
        [_detailDishButton addTarget:self
                              action:@selector(displayDetailDish) forControlEvents:UIControlEventTouchUpInside];
    }
}

//显示详细菜单
- (void)displayDetailDish{
    if (_detailData) {
        MenuViewController *mvc = [[MenuViewController alloc] init];
            mvc.shopId = _detailData[@"id"];
            [self presentViewController:mvc
                               animated:YES
                             completion:nil];
    }
}

- (void)loadNetData {
    [NetWork NetRequestPOSTWithRequestURL:@"https://wx.idsbllp.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/shopInfo" WithParameter:@{@"id":_detailData[@"id"]} WithReturnValeuBlock:^(id returnValue) {
        _shopInfoData = [NSMutableDictionary dictionaryWithCapacity:10];
        [_shopInfoData setObject:returnValue[@"data"] forKey:@"infoData"];
        [self.scrollView addSubview:self.tableView];
        [_picture setImageWithURL:[NSURL URLWithString:_detailData[@"shopimg_src"]]];
    } WithFailureBlock:^{
        NSLog(@"失败啦");
    }];
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(MAIN_SCREEN_W, 604);
        _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.picture.frame.origin.y+self.picture.frame.size.height, MAIN_SCREEN_W, MAIN_SCREEN_H - self.picture.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        [_tableView setSeparatorColor:[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:0.5]];
//        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 1;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 || indexPath.section == 2) {
        return 40;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 40;
        }else {
            return 65;
        }
    }else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            return 40;
        }else {
            return 120;
        }
    }
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
   
   
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 15)];
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.text = _shopInfoData[@"infoData"][@"shop_name"];
            titleLabel.textColor = [UIColor colorWithRed:57/255.0 green:57/255.0 blue:57/255.0 alpha:1];
            [titleLabel sizeToFit];
            titleLabel.center = CGPointMake(MAIN_SCREEN_W/2, 20);
            [cell addSubview:titleLabel];
            [cell setUserInteractionEnabled:NO];
        }else {
            UILabel *shopInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
            shopInfoLabel.text = @"暂无本店介绍";
//            shopInfoLabel.text = _shopInfoData[@"infoData"][@"shop_content"];
            shopInfoLabel.font = [UIFont systemFontOfSize:13];
            shopInfoLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
            [shopInfoLabel sizeToFit];
            shopInfoLabel.center = CGPointMake(15+shopInfoLabel.frame.size.width/2, 20);
            [cell addSubview:shopInfoLabel];
            [cell setUserInteractionEnabled:NO];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UILabel *shopInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
            shopInfoLabel.text = @"店铺信息";
            shopInfoLabel.font = [UIFont systemFontOfSize:13];
            shopInfoLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
            [shopInfoLabel sizeToFit];
            shopInfoLabel.center = CGPointMake(15+shopInfoLabel.frame.size.width/2, 20);
            [cell addSubview:shopInfoLabel];
            [cell setUserInteractionEnabled:NO];
        }else {
            NSArray *shopInfoArray = @[_shopInfoData[@"infoData"][@"shop_address"],[NSString stringWithFormat:@"电话:%@",_shopInfoData[@"infoData"][@"shop_tel"]]];
            for (int i = 0; i < 2; i ++) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(15, 65/2*i, MAIN_SCREEN_W-20, 65/2)];
                UIImageView *ima = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
                ima.image = [UIImage imageNamed:[NSString stringWithFormat:@"iconfont-shop%d.png",i+1]];
                ima.contentMode = UIViewContentModeScaleAspectFit;
                ima.center = CGPointMake(ima.frame.size.width/2, view.frame.size.height/2);
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ima.frame.size.width+10, 0, 0, 15)];
                label.text = shopInfoArray[i];
                label.font = [UIFont systemFontOfSize:13];
                label.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
                [label sizeToFit];
                label.center = CGPointMake(label.frame.origin.x+label.frame.size.width/2, view.frame.size.height/2);
                
                [view addSubview:label];
                [view addSubview:ima];
                [cell addSubview:view];
                [cell setUserInteractionEnabled:NO];
            }
        }
    }else if (indexPath.section == 2) {
        UILabel *menu = [[UILabel alloc]initWithFrame:CGRectZero];
        menu.text = @"查看菜单";
        menu.font = [UIFont systemFontOfSize:13];
        menu.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [menu sizeToFit];
        menu.center = CGPointMake(MAIN_SCREEN_W/2, 20);
        [cell addSubview:menu];
    }else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            UILabel *shopInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
            shopInfoLabel.text = @"推荐介绍";
            shopInfoLabel.font = [UIFont systemFontOfSize:13];
            shopInfoLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
            [shopInfoLabel sizeToFit];
            shopInfoLabel.center = CGPointMake(15+shopInfoLabel.frame.size.width/2, 20);
            [cell addSubview:shopInfoLabel];
            [cell setUserInteractionEnabled:NO];
        }else {
            UILabel *shopInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
            shopInfoLabel.text = @"暂无";
            shopInfoLabel.font = [UIFont systemFontOfSize:13];
            shopInfoLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
            [shopInfoLabel sizeToFit];
            shopInfoLabel.center = CGPointMake(15+shopInfoLabel.frame.size.width/2, 20);
            [cell addSubview:shopInfoLabel];
            [cell setUserInteractionEnabled:NO];
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        [self displayDetailDish];
    }
}
@end

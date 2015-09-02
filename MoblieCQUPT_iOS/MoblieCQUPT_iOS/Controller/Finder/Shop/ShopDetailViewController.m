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

@interface ShopDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *detailDishButton;
@property (strong, nonatomic) NSMutableArray *menu;

@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_picture setImageWithURL:[NSURL URLWithString:_detailData[@"shopimg_src"]]];
    _nameLabel.text = _detailData[@"name"];
    _addressLabel.text = _detailData[@"shop_address"];
    _menu = [[NSMutableArray alloc] init];
    [_detailDishButton addTarget:self
                          action:@selector(displayDetailDish) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

//显示详细菜单
- (void)displayDetailDish{
//    NSNumber *shopId = [NSNumber numberWithFloat:[_detailData[@"id"] floatValue]];
//    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/menuList" WithParameter:@{@"shop_id":shopId} WithReturnValeuBlock:^(id returnValue) {
//        [ProgressHUD show:@"菜品加载中..."];
//        
//        
//        NSArray *arrTmp = returnValue[@"data"];
//        DDLog(@"\n%@\n",arrTmp);
//        [_menu addObjectsFromArray:arrTmp];
//       
//        
//        MenuViewController *mvc = [[MenuViewController alloc] init];
//        mvc.shopId = [NSNumber numberWithFloat:[_detailData[@"id"] floatValue]];
//        [self.navigationController pushViewController:mvc animated:YES];
////        [ProgressHUD showSuccess:@"加载完成~"];
//    } WithFailureBlock:^{
//        UILabel *faileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
//        faileLable.text = @"哎呀！网络开小差了 T^T";
//        faileLable.textColor = [UIColor whiteColor];
//        faileLable.backgroundColor = [UIColor grayColor];
//        faileLable.textAlignment = NSTextAlignmentCenter;
//        [self.view addSubview:faileLable];
//    }];
    
        MenuViewController *mvc = [[MenuViewController alloc] init];
        mvc.shopId = _detailData[@"id"] ;
        [self presentViewController:mvc
                           animated:YES
                         completion:nil];

}

- (void)viewDidAppear:(BOOL)animated{
    self.scrollView.frame = [UIScreen mainScreen].bounds;
//    [self.scrollView setContentSize:CGSizeMake(MAIN_SCREEN_W, MAIN_SCREEN_H * 1.3)];
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

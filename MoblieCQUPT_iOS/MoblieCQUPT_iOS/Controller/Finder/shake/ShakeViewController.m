//
//  ShakeViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/28.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "ShakeViewController.h"
#import "ShopDetailViewController.h"
#import "UIImage+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "NetWork.h"
#import "ShopDetailViewController.h"

@interface ShakeViewController ()

@property (strong, nonatomic)NSMutableArray *data;
@property (strong, nonatomic)ShopDetailViewController *detailViewController;

@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"摇一摇";
    
    NSLog(@"%@", _data);
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"began");
    
}
-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"cancel");
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"end");
    
    if (!_detailViewController) {
         _detailViewController = [[ShopDetailViewController alloc] init];
    }
    NSInteger randomNum = arc4random() % [_data count];
    _detailViewController.detailData = _data[randomNum];
    [self.navigationController pushViewController:_detailViewController animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    for (int i = 1; i<= 3; i++) {
        [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/shopList" WithParameter:@{@"pid":[NSNumber numberWithInt:i]} WithReturnValeuBlock:^(id returnValue) {
            _data = [[NSMutableArray alloc] init];
            [_data addObjectsFromArray:[returnValue objectForKey:@"data"]];
        } WithFailureBlock:^{
            UILabel *failLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
            failLabel.text = @"哎呀！网络开小差了 T^T";
            failLabel.textColor = [UIColor whiteColor];
            failLabel.backgroundColor = [UIColor grayColor];
            failLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:failLabel];
        }];
    }
}


@end

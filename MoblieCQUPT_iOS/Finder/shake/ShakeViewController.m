//
//  ShakeViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/28.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ShakeViewController.h"
#import "ShopDetailViewController.h"
#import "UIImage+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "NetWork.h"
#import "ShopDetailViewController.h"
/*
 *
 *          ┌─┐       ┌─┐
 *       ┌──┘ ┴───────┘ ┴──┐
 *       │                 │
 *       │       ───       │
 *       │  ─┬┘       └┬─  │
 *       │                 │
 *       │       ─┴─       │
 *       │                 │
 *       └───┐         ┌───┘
 *           │         │
 *           │         │
 *           │         │
 *           │         └──────────────┐
 *           │                        │
 *           │                        ├─┐
 *           │                        ┌─┘
 *           │                        │
 *           └─┐  ┐  ┌───────┬──┐  ┌──┘
 *             │ ─┤ ─┤       │ ─┤ ─┤
 *             └──┴──┘       └──┴──┘
 *                 神兽保佑
 *                 代码无BUG!
 */
@interface ShakeViewController ()

@property (strong, nonatomic)NSMutableArray *data;
@property (strong, nonatomic)ShopDetailViewController *detailViewController;

@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"摇一摇";
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    [self request];
}


-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    // 要播放的音频文件地址
    NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"shake_match" ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:urlPath];
    
    // 声明需要播放的音频文件ID[unsigned long]
    SystemSoundID ID;
    
    // 创建系统声音，同时返回一个ID
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &ID);

    // 根据ID播放自定义系统声音
    AudioServicesPlaySystemSound(ID);
    
    _detailViewController = [[ShopDetailViewController alloc] init];
    if (_data) {
        NSInteger randomNum = arc4random() % [_data count];
        _detailViewController.detailData = _data[randomNum];
        
        [self.navigationController pushViewController:_detailViewController animated:YES];
    }
}


- (void)request{
    for (int i = 1; i<= 3; i++) {
        [NetWork NetRequestPOSTWithRequestURL:@"https://wx.idsbllp.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/shopList" WithParameter:@{@"pid":[NSNumber numberWithInt:i]} WithReturnValeuBlock:^(id returnValue) {
            _data = [[NSMutableArray alloc] init];
            [_data addObjectsFromArray:[returnValue objectForKey:@"data"]];
        } WithFailureBlock:^{
            UILabel *failLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
            failLabel.text = @"哎呀！网络开小差了 T^T";
            failLabel.textColor = [UIColor blackColor];
            failLabel.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
            failLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:failLabel];
        }];
    }
}


@end

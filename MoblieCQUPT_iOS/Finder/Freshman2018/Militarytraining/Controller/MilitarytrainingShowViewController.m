//
//  MilitarytrainingShowViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "MilitarytrainingShowViewController.h"
#import "ShowPicRootView.h"
#import "ShowVideoRootView.h"


@interface MilitarytrainingShowViewController ()

@end

@implementation MilitarytrainingShowViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"军训风采";
    self.hidesBottomBarWhenPushed = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showDataLoadFailure)
                                                 name:@"showDataLoadFailure" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showDataLoadSuccessful)
                                                 name:@"showDataLoadSuccess" object:nil];
   
    _showModel = [[FreshmanModel alloc]init];
    [self.showModel networkLoadData:@"http://wx.yyeke.com/welcome2018/data/get/junxun" title:@"show" ];
    
    self.picview.frame = CGRectMake(0, 15*(SCREENHEIGHT/667), SCREENWIDTH, 240*(SCREENHEIGHT/667));
    self.picview.backgroundColor = [UIColor whiteColor];



    self.videoview.frame = CGRectMake(0, 280*(SCREENHEIGHT/667),SCREENWIDTH, 240*(SCREENHEIGHT/667));
    self.videoview.backgroundColor = [UIColor whiteColor];
    
    

    [self.view addSubview:_picview];
    [self.view addSubview:_videoview];
    
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载数据中...";
    hud.detailsLabelText = @"不如先去看看其他的？";
    hud.color = [UIColor colorWithWhite:0.f alpha:0.4f];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDataLoadSuccessful {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //NSLog(@"yyyyy,%@",_showModel.urlDic);
    NSArray *pictureArray = [_showModel.dic objectForKey:@"picture"];
    NSArray *videoArray = [_showModel.dic objectForKey:@"video"];
    
    ShowPicRootView *picView = [ShowPicRootView instancePicView];
    [picView addScrollView:pictureArray];
    [_picview addSubview:picView];
    
    //NSLog(@"%@",videoArray);
    ShowVideoRootView *videoView = [ShowVideoRootView instanceVideoView];
    [videoView addScrollViewWithArray:videoArray];
    [_videoview addSubview:videoView];
    
    
}

- (void)showDataLoadFailure{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"您的网络不给力!";
    [hud hide:YES afterDelay:1];
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

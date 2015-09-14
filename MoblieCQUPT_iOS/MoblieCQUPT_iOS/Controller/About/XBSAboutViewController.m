//
//  XBSAboutViewController.m
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 9/3/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import "XBSAboutViewController.h"
#import "UIColor+BFPaperColors.h"
#import "We.h"

@interface XBSAboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *appVersion;
@property (weak, nonatomic) IBOutlet UIButton *buttonToUpdate;
@property (weak, nonatomic) IBOutlet UIButton *buttonToWebsite;
@property (weak, nonatomic) IBOutlet UIButton *buttonToCopyRight;


@end

@implementation XBSAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.appName setTextColor:[UIColor paperColorGray500]];
    [self.appVersion setTextColor:[UIColor paperColorGray500]];
    
    [self.buttonToUpdate addTarget:self action:@selector(clickToUpdate) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonToWebsite addTarget:self action:@selector(clickToWebsite) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonToCopyRight addTarget:self action:@selector(clickToCopyRight) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"关于";
    self.navigationController.navigationBar.barTintColor = MAIN_COLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)clickToCopyRight {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"使用条款"
                                                    message:@"版权归红岩网校工作站所有，感谢您的使用"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil,nil];
    [alert show];
}

- (void)clickToWebsite {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://hongyan.cqupt.edu.cn/"]];
}

- (void)clickToUpdate {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"检查更新"
                                                    message:@"哎哟，这个功能好像还没做好哦，敬请期待"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil,nil];
    [alert show];
}

@end

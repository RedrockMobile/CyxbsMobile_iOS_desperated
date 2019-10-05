//
//  XBSAboutViewController.m
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 9/3/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import "XBSAboutViewController.h"

@interface XBSAboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *appVersion;
@property (weak, nonatomic) IBOutlet UIImageView *imageToTop;

@end

@implementation XBSAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于";
    [self.appName setTextColor:[UIColor colorWithHexString:@"0x9E9E9E"]];
    [self.appVersion setTextColor:[UIColor colorWithHexString:@"0x9E9E9E"]];
    NSString*appVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.appVersion.text = [NSString stringWithFormat:@"version v%@",appVersion];
    
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


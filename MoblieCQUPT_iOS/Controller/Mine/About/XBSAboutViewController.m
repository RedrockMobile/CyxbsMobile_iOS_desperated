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
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (nonatomic, assign) NSInteger tapNum;
@property (weak, nonatomic) IBOutlet UIImageView *imageToTop;

@end

@implementation XBSAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tapNum = 0;
    [self.appName setTextColor:[UIColor paperColorGray500]];
    [self.appVersion setTextColor:[UIColor paperColorGray500]];
//    [self.buttonToUpdate addTarget:self action:@selector(clickToUpdate) forControlEvents:UIControlEventTouchUpInside];
//    [self.buttonToWebsite addTarget:self action:@selector(clickToWebsite) forControlEvents:UIControlEventTouchUpInside];
//    [self.buttonToCopyRight addTarget:self action:@selector(clickToCopyRight) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    self.imageToTop.userInteractionEnabled = YES;
    [self.imageToTop addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view from its nib.
}

//- (void)loadView {
////    [super loadView];
////    self.view.backgroundColor = [UIColor whiteColor];
//    NSLog(@"loadView");
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//    tap.numberOfTapsRequired = 1;
//    [self.authorLabel addGestureRecognizer:tap];
//}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    self.tapNum++;
    NSLog(@"点击了%ld次",(long)self.tapNum);
    if (self.tapNum >= 1) {
        self.tapNum = 0;
        NSLog(@"开始游戏吧！");
        [self playGame];
    }
}

- (void)playGame {
    //[self presentViewController:c animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"关于";
}

//- (void)clickToCopyRight {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"使用条款"
//                                                    message:@"版权归红岩网校工作站所有，感谢您的使用"
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil,nil];
//    [alert show];
//}
//
//- (void)clickToWebsite {
//	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://hongyan.cqupt.edu.cn/"]];
//}
//
//- (void)clickToUpdate {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"检查更新"
//                                                    message:@"哎哟，这个功能好像还没做好哦，敬请期待"
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil,nil];
//    [alert show];
//}



@end


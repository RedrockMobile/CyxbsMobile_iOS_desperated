//
//  GradeViewController.m
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 8/25/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import "GradeViewController.h"
#import "We.h"

@interface GradeViewController ()

@end

@implementation GradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *backButton = [We getButtonWithTitle:@"返回" Color:Blue];
    [backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    backButton.center = CGPointMake(50, 50);
    [self.view addSubview:backButton];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, [We getScreenWidth], [We getScreenHeight] - 100)];
    [scrollView setContentSize:CGSizeMake([We getScreenWidth] + 300, [We getScreenHeight] - 100)];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [We getScreenWidth] + 300, [We getScreenHeight] - 100)];
    [webView loadHTMLString:self.delegate.htmlString baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle] resourcePath] isDirectory: YES]];
    [scrollView addSubview:webView];
    [self.view addSubview:scrollView];
    
//    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 100, [We getScreenWidth], [We getScreenHeight] - 100)];
//    [webView loadHTMLString:self.delegate.htmlString baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle] resourcePath] isDirectory: YES]];
//    [self.view addSubview:webView];
    // Do any additional setup after loading the view.
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

- (void)clickBack {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end

//
//  MTVideo1.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2017/8/14.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "MTVideo1.h"

@interface MTVideo1 ()

@end

@implementation MTVideo1

- (instancetype)initWithVideoUrlStr:(NSString *)urlStr {
    self = [super init];
    
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
        
        [self.view addSubview:webView];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

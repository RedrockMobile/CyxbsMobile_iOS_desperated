//
//  NewsViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/9/27.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModel.h"
@interface NewsViewController ()
@property (nonatomic, strong)NewsModel *model;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"教务新闻";
    
    self.model = [[NewsModel alloc]init];
    [self.model getNewsList:@"1"];
    [self.model getNewsDetail:@"6202"];
    // Do any additional setup after loading the view.
}


@end

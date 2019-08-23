//
//  ChildViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/2.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "ChildViewController.h"
#import "InfiniteRollScrollView.h"
#import <Masonry.h>
@interface ChildViewController ()
@property (nonatomic, strong)UIScrollView*scrollView;
@end

@implementation ChildViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"---%@",self.title);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:234/255.0 green:246/255.0 blue:255/255.0 alpha:1];
    [self buildBackgroundView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMyContentSize) name:@"changeContentSize" object:nil];

}
- (void)loadView{
    _scrollView = [UIScrollView new];
    _scrollView.alwaysBounceVertical = YES;
    self.view = _scrollView;
    
}
- (void)buildBackgroundView{
    _backgroundView = [[UIImageView alloc]init];
//    _backgroundView.frame = CGRectMake(100, 100, 100, 100);
    
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [_backgroundView setImage:[UIImage imageNamed:@"itemBackGroundImageV2.0"]];
    [self.view addSubview:_backgroundView];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view)/*.offset(-20)*/;
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view)/*.offset(20)*/;
//        make.height.equalTo(self.view).multipliedBy(0.65);
//        make.height.equalTo(self.view).multipliedBy(747.0/(1334-60-97-129));
        make.height.equalTo(self.view.mas_width).multipliedBy((656.0+185)/750);
    }];

}
//轮播图片
-(void)changeMyContentSize{
    _scrollView.contentSize = CGSizeMake(0, 920);
}


@end

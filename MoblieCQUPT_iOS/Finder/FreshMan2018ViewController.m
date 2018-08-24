//
//  FreshMan2018ViewController.m
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/12.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "FreshMan2018ViewController.h"
#import "ChatViewControl.h"
#import "ReportWaterfallController.h"
#import "WantToSayController.h"

#define width [UIScreen mainScreen].bounds.size.width//宽
#define height [UIScreen mainScreen].bounds.size.height//高
@interface FreshMan2018ViewController ()

@end

@implementation FreshMan2018ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"2018迎新网";
    
    //创建滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, width, height - 60)];
    
    //是否弹动效果
    _scrollView.bounces = YES;
    
    //是否允许通过点击屏幕让滚动视图响应事件
    //YES:滚动视图可以接受触碰事件
    //NO:滚动视图可以不接受触碰事件
    _scrollView.userInteractionEnabled = YES;
    
    //设置画布的大小（纵向效果）
    _scrollView.contentSize = CGSizeMake(width, height * 2);
    
    //添加按钮
    //入学必备
    UIButton *image01 = [UIButton buttonWithType:UIButtonTypeCustom];

    [image01 setImage:[UIImage imageNamed:@"入学必备.png"] forState:UIControlStateNormal];

    image01.frame = CGRectMake(8, 70, 137, 126);

    [_scrollView addSubview:image01];

    //军训特辑
    UIButton *image02 = [UIButton buttonWithType:UIButtonTypeCustom];

    [image02 setImage:[UIImage imageNamed:@"军训特辑.png"] forState:UIControlStateNormal];

    image02.frame = CGRectMake(217, 117, 137, 126);

    [_scrollView addSubview:image02];


    //校园攻略
    UIButton *image03 = [UIButton buttonWithType:UIButtonTypeCustom];

    [image03 setImage:[UIImage imageNamed:@"校园攻略.png"] forState:UIControlStateNormal];

    image03.frame = CGRectMake(232, 309, 137, 126);

    [_scrollView addSubview:image03];


    //重邮风采
    UIButton *image04 = [UIButton buttonWithType:UIButtonTypeCustom];

    [image04 setImage:[UIImage imageNamed:@"重邮风采.png"] forState:UIControlStateNormal];

    image04.frame = CGRectMake(32, 495, 137, 126);

    [_scrollView addSubview:image04];


    //线上交流
    UIButton *image05 = [UIButton buttonWithType:UIButtonTypeCustom];

    [image05 setImage:[UIImage imageNamed:@"线上交流.png"] forState:UIControlStateNormal];

    image05.frame = CGRectMake(230, 570, 137, 126);

    [image05 addTarget:self action:@selector(pressBtn05) forControlEvents:UIControlEventTouchUpInside];

    [_scrollView addSubview:image05];


    //报道流程
    UIButton *image06 = [UIButton buttonWithType:UIButtonTypeCustom];

    [image06 setImage:[UIImage imageNamed:@"报道流程.png"] forState:UIControlStateNormal];

    image06.frame = CGRectMake(30, 650, 137, 126);

    [image06 addTarget:self action:@selector(pressBtn06) forControlEvents:UIControlEventTouchUpInside];

    [_scrollView addSubview:image06];


    //我想对你说
    UIButton *image07 = [UIButton buttonWithType:UIButtonTypeCustom];

    [image07 setImage:[UIImage imageNamed:@"我想对你说.png"] forState:UIControlStateNormal];

    image07.frame = CGRectMake(230, 750, 137, 126);

    [image07 addTarget:self action:@selector(pressBtn07) forControlEvents:UIControlEventTouchUpInside];

    [_scrollView addSubview:image07];
    
//    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"主页背景"]];
//    _imageView.frame = CGRectMake(0, 0, width, height * 2);
//    _imageView.contentMode = UIViewContentModeScaleAspectFit;
//
//    [_scrollView addSubview:_imageView];
    
    //是否按页滚动
    _scrollView.pagingEnabled = NO;
    
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];

}

//线上交流
- (void)pressBtn05
{
    ChatViewControl *chat = [[ChatViewControl alloc] init];
    
    [self.navigationController pushViewController:chat animated:YES];
}

//报道流程
- (void)pressBtn06
{
    ReportWaterfallController *report = [[ReportWaterfallController alloc] init];
    
    [self.navigationController pushViewController:report animated:YES];
}

//我想对你说
- (void)pressBtn07
{
    WantToSayController *say = [[WantToSayController alloc] init];
    [self.navigationController pushViewController:say animated:YES];
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

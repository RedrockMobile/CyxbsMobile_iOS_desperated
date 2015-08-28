//
//  FirstViewController.m
//  重邮小帮手
//
//  Created by 1808 on 15/8/20.
//  Copyright (c) 2015年 1808. All rights reserved.
//

#import "FirstViewController.h"
#import "NetWork.h"
@interface FirstViewController ()
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableDictionary *backData;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.data1 = [[NSMutableDictionary alloc] init];
    self.backData = [[NSMutableDictionary alloc] init];
    
    // 1.创建UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 170 , 375, 600); // frame中的size指UIScrollView的可视范围
    [self.view addSubview:scrollView];
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 375, 600)];
    textView.text = @"查询中。。。";
//    textView.userInteractionEnabled = NO;
    [scrollView addSubview:textView];
         // 隐藏水平滚动条
         scrollView.showsHorizontalScrollIndicator = NO;
         scrollView.showsVerticalScrollIndicator = YES;
            // 用来记录scrollview滚动的位置
   //    scrollView.contentOffset = ;
    
       // 去掉弹簧效果
//       scrollView.bounces = NO;
    
         // 增加额外的滚动区域（逆时针，上、左、下、右）
        // top  left  bottom  right
    
        _scrollView = scrollView;
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/jwNewsContent" WithParameter:@{@"id":self.data1[@"id"]} WithReturnValeuBlock:^(id returnValue) {
        
        self.backData = returnValue;
        NSLog(@"%@",self.backData);
        self.day1label.text =self.data1[@"date"];
        self.time1lable.text =self.data1[@"read"];
        textView.text = self.backData[@"data"][@"content"];
        self.top1label.text =self.backData[@"data"][@"title"];
        //[_scrollView reloadData];
    } WithFailureBlock:nil];
}

   


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 2000, [UIScreen mainScreen].bounds.size.width);
    _scrollView.backgroundColor = [UIColor blueColor];
    
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

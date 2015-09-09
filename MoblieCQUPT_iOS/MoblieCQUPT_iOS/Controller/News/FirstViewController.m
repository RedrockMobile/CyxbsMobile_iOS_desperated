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
@property (strong, nonatomic)UITextView *textView;
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
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 375, 600)];
    _textView.text = @"查询中。。。";
    _textView.userInteractionEnabled = NO;
    [scrollView addSubview:_textView];
         // 隐藏水平滚动条
         scrollView.showsHorizontalScrollIndicator = NO;
         scrollView.showsVerticalScrollIndicator = YES;
            // 用来记录scrollview滚动的位置
    
        _scrollView = scrollView;

        self.day1label.text =self.data1[@"date"];
        self.time1lable.text =self.data1[@"read"];
        _textView.text = self.data1[@"newsContent"];
    
        self.top1label.text =self.data1[@"title"];

         UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        self.textView.font = font;
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize]
                         constrainedToSize:CGSizeMake(width -16.0, CGFLOAT_MAX)
                             lineBreakMode:NSLineBreakByWordWrapping];
    //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height + 16;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
   float H = [self heightForString:self.data1[@"newsContent"] fontSize:14 andWidth:MAIN_SCREEN_W];
    _scrollView.contentSize = CGSizeMake(MAIN_SCREEN_W,H);
    _scrollView.backgroundColor = [UIColor clearColor];
    [_scrollView sizeToFit];
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

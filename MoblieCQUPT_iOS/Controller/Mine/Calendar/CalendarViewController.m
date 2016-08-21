//
//  CalendarViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/5.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *calendarView1;
@property (strong, nonatomic) UIImageView *calendarView2;
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
}

- (UIImageView *)calendarView1 {
    if (!_calendarView1) {
        _calendarView1 = [[UIImageView alloc] init];
        _calendarView1.image = [UIImage imageNamed:@"calendar1"];
        [_calendarView1 sizeToFit];
        _calendarView1.frame = CGRectMake(8, 0, MAIN_SCREEN_W-16, (MAIN_SCREEN_W-16) * 2.13);
    }
    return _calendarView1;
}

- (UIImageView *)calendarView2 {
    if (!_calendarView2) {
        _calendarView2 = [[UIImageView alloc] init];
        _calendarView2.image = [UIImage imageNamed:@"calendar2"];
        [_calendarView2 sizeToFit];
        _calendarView2.frame = CGRectMake(8, _calendarView1.frame.size.height, MAIN_SCREEN_W-16, (MAIN_SCREEN_W-16) * 2.13);
    }
    return _calendarView2;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        [_scrollView addSubview:self.calendarView1];
        [_scrollView addSubview:self.calendarView2];
        _scrollView.contentSize = CGSizeMake(MAIN_SCREEN_W, self.calendarView1.frame.size.height * 2 +16);
    }
    return _scrollView;
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = MAIN_COLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

@end

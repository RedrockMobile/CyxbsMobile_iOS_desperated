//
//  ViewController.m
//  ConsultingTest
//
//  Created by RainyTunes on 8/19/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import "ConsultViewController.h"
#import "DataBundle.h"
#import "TableViewController.h"
#import "ShowRoomViewController.h"
//2013211854
#define TEST_STU_NUM @"2014211889"
#define TEST_ID_NUM @"220913"

#define TEST_WEEKDAY_NUM @"1"
#define TEST_SECTION_NUM @"0"
#define TEST_BUILD_NUM @"2"
#define TEST_WEEK @"1"

@implementation ConsultViewController

- (void)initButtons {
    NSArray *tempStrArr = @[@"考试查询",@"补考查询",@"成绩查询",@"空教室查询"];
    SEL s[4] = {@selector(clickForExamSchedule),@selector(clickForReexamSchedule),
                @selector(clickForExamGrade),@selector(clickForEmptyRooms)};
    for (int i = 0; i < 4; i++) {
        UIButton *button = [We getButtonWithTitle:tempStrArr[i] Color:BlueLight];
        button.center = CGPointMake([We getScreenWidth] / 2, [We getScreenHeight] / 10 * (i + 3));
        [button setBackgroundImage:[We getImageColored:[We getColorByRGBHex:@"#0288d1"] Size:CGSizeMake(120, 40)] forState:UIControlStateHighlighted];
        [button addTarget:self action:s[i] forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)showAlert:(NSString *)errStr
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"哎呀"
                                                    message:errStr
                                                   delegate:self
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil,nil];
    [alert show];
}

- (void)clickForExamSchedule
{
    DataBundle *dataBundle = [[DataBundle alloc]initWithDic:[DataBundle paramWithStuNum:TEST_STU_NUM IdNum:TEST_ID_NUM]];
    dataBundle.delegate = self;
    [dataBundle httpPost:API_EXAM_SCHEDULE];
}

- (void)clickForReexamSchedule
{
    DataBundle *dataBundle = [[DataBundle alloc]initWithDic:[DataBundle paramWithStuNum:TEST_STU_NUM IdNum:TEST_ID_NUM]];
    dataBundle.delegate = self;
    [dataBundle httpPost:API_REEXAM_SCHEDULE];
}

- (void)clickForExamGrade
{
    DataBundle *dataBundle = [[DataBundle alloc]initWithDic:[DataBundle paramWithStuNum:TEST_STU_NUM IdNum:TEST_ID_NUM]];
    dataBundle.delegate = self;
    [dataBundle httpPost:API_EXAM_GRADE];
}

- (void)clickForEmptyRooms
{
    ShowRoomViewController *viewController = [[ShowRoomViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

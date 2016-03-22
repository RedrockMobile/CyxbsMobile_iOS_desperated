//
//  QGERestDetailViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/12/8.
//  Copyright © 2015年 Orange-W. All rights reserved.
//

#import "QGERestDetailViewController.h"
#import "Course.h"
#import "CourseButton.h"
#import "QGERestTimeDetailView.h"

#define Course_API @"http://hongyan.cqupt.edu.cn/redapi2/api/kebiao"

@interface QGERestDetailViewController ()
@property (strong, nonatomic) NSArray *weekArray;
@property (assign, nonatomic) BOOL weekViewShow;
@property (strong, nonatomic) UIButton *titleButton;
@property (strong, nonatomic) UIImageView *tagView;
@property (strong, nonatomic) UIScrollView *weekScrollView;
@property (strong, nonatomic) UIView *shadeView;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIButton *clickBtn;
@property (strong, nonatomic) UIView *titleView;

@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *alertView;

@property (strong, nonatomic) NSMutableArray *weekBtnArray;
@property (assign, nonatomic) CGPoint startPoint;
@property (assign, nonatomic) CGPoint startPoint1;

@property (strong, nonatomic) NSMutableArray *allStuCourseArray;
@property (strong, nonatomic) NSMutableArray *allStuWeelCourseArray;
@property (strong, nonatomic) NSMutableArray *preWeekCourseArray;
@property (strong, nonatomic) NSMutableArray *showDataArray;
@property (strong, nonatomic) NSMutableArray *buttonTag;
@property (strong, nonatomic) NSMutableArray *colorArray;
@end

@implementation QGERestDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCourseTable];
    [self initWeekSelectedList];
    self.navigationItem.titleView = _titleView;
    [self loadAllStuCourse];
    // Do any additional setup after loading the view from its nib.
}
- (void)initWeekSelectedList {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    _weekViewShow = NO;
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, -ScreenHeight/2+64, ScreenWidth, ScreenHeight/2)];
    [self.view addSubview:_backView];
    
    _weekScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/2)];
    _weekScrollView.contentSize = CGSizeMake(ScreenWidth, 35*19);
    _weekScrollView.backgroundColor = [UIColor whiteColor];
    _weekScrollView.bounces = NO;
    [_backView addSubview:_weekScrollView];
    
    _weekArray = @[@"本学期",@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周",@"第九周",@"第十周",@"第十一周",@"第十二周",@"第十三周",@"第十四周",@"第十五周",@"第十六周",@"第十七周",@"第十八周"];
    NSString *nowWeek = [user objectForKey:@"nowWeek"];
    _weekBtnArray = [NSMutableArray array];
    for (int i = 0; i < 19; i ++) {
        UIButton *weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        weekBtn.frame = CGRectMake(0, 35*i, ScreenWidth, 35);
        [weekBtn setTitle:_weekArray[i] forState:UIControlStateNormal];
        if (nowWeek != nil && i == [nowWeek integerValue]) {
            weekBtn.selected = YES;
            [weekBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            weekBtn.backgroundColor = [UIColor colorWithRed:250/255.0 green:165/255.0 blue:69/255.0 alpha:1];
            _clickBtn = weekBtn;
            if ([nowWeek integerValue] > 6 && [nowWeek integerValue] < 13) {
                _weekScrollView.contentOffset = CGPointMake(0, _weekScrollView.frame.size.height/2);
            }
        }else {
            [weekBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [weekBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        weekBtn.tag = i;
        [_weekBtnArray addObject:weekBtn];
        [_weekScrollView addSubview:weekBtn];
    }
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, _backView.frame.size.height-30, ScreenWidth, 30);
    backBtn.backgroundColor = [UIColor whiteColor];
    [backBtn addTarget:self action:@selector(hiddenWeekView) forControlEvents:UIControlEventTouchUpInside];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(backViewChange:)];
    [backBtn addGestureRecognizer:pan];
    [_backView addSubview:backBtn];
    
    UIImageView *backBtnImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    backBtnImage.center = CGPointMake(backBtn.frame.size.width/2, backBtn.frame.size.height/2);
    backBtnImage.image = [UIImage imageNamed:@"iconfont-backTag.png"];
    [backBtn addSubview:backBtnImage];
    
    UIView *underLine = [[UIView alloc]initWithFrame:CGRectMake(0, _backView.frame.size.height-30, ScreenWidth, 1)];
    underLine.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [_backView addSubview:underLine];
    
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleButton.frame = CGRectMake(0, 0, 100, 44);
    if (nowWeek) {
        for (int i = 1; i < _weekArray.count; i++) {
            if (i == [nowWeek integerValue]) {
                UIButton *weekBtn1 = _weekBtnArray[i];
                [weekBtn1 setTitle:@"本周" forState:UIControlStateNormal];
                [_titleButton setTitle:[NSString stringWithFormat:@"%@",weekBtn1.titleLabel.text] forState:UIControlStateNormal];
            }
        }
    }else {
        [_titleButton setTitle:[NSString stringWithFormat:@"%@",_weekArray[[nowWeek integerValue]]] forState:UIControlStateNormal];
    }
//    [_titleButton setTitle:@"本学期" forState:UIControlStateNormal];
    [_titleButton sizeToFit];
    _titleButton.center = CGPointMake(_titleView.frame.size.width/2, _titleView.frame.size.height/2);
    [_titleButton addTarget:self action:@selector(showWeekList) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:_titleButton];
    
    _tagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 6)];
    _tagView.image = [UIImage imageNamed:@"iconfont-titleTag.png"];
    _tagView.center = CGPointMake(_titleView.frame.size.width/2+_titleButton.frame.size.width/2+_tagView.frame.size.width/2, _titleView.frame.size.height/2);
    [_titleView addSubview:_tagView];
    
    _shadeView = [[UIView alloc]initWithFrame:CGRectMake(0, 64+_backView.frame.size.height, ScreenWidth, ScreenHeight)];
    _shadeView.backgroundColor = [UIColor blackColor];
    _shadeView.alpha = 0.7;
    
    UIButton *shadeViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shadeViewBtn.frame = CGRectMake(0, 0, _shadeView.frame.size.width, _shadeView.frame.size.height);
    [shadeViewBtn addTarget:self action:@selector(clickShadeView) forControlEvents:UIControlEventTouchUpInside];
    [_shadeView  addSubview:shadeViewBtn];
}

- (void)initCourseTable {
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [self.view addSubview:_mainView];
    
    UIView *dayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    dayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [_mainView addSubview:dayView];
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, ScreenWidth, _mainView.frame.size.height - 30)];
    
    NSArray *array = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    for (int i = 0; i < 7; i ++) {
        UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake((i+0.5)*kWidthGrid, 1, kWidthGrid, 29)];
        dayLabel.text = [NSString stringWithFormat:@"%@",array[i]];
        dayLabel.font = [UIFont systemFontOfSize:14];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
        [dayView addSubview:dayLabel];
    }
    
    _mainScrollView.contentSize = CGSizeMake(ScreenWidth, kWidthGrid * 12);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [_mainView addSubview:_mainScrollView];
    
    for (int i = 0; i < 12; i ++) {
        UILabel *classNum = [[UILabel alloc]initWithFrame:CGRectMake(0, i*kWidthGrid, kWidthGrid*0.5, kWidthGrid)];
        classNum.text = [NSString stringWithFormat:@"%d",i+1];
        classNum.textAlignment = NSTextAlignmentCenter;
        classNum.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
        [_mainScrollView addSubview:classNum];
    }
}

- (void)clickBtn:(UIButton *)sender {
    if (_clickBtn == nil) {
        sender.selected = YES;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor colorWithRed:250/255.0 green:165/255.0 blue:69/255.0 alpha:1];
        [_titleButton setTitle:[NSString stringWithFormat:@"%@",sender.titleLabel.text] forState:UIControlStateNormal];
        [_titleButton sizeToFit];
        _titleButton.center = CGPointMake(_titleView.frame.size.width/2, _titleView.frame.size.height/2);
        _tagView.center = CGPointMake(_titleView.frame.size.width/2+_titleButton.frame.size.width/2+_tagView.frame.size.width/2, _titleView.frame.size.height/2);
        _clickBtn = sender;
    }else if (_clickBtn == sender) {
        sender.selected = YES;
    }else if (_clickBtn != sender) {
        _clickBtn.selected = NO;
        [_clickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _clickBtn.backgroundColor = [UIColor whiteColor];
        sender.selected = YES;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor colorWithRed:250/255.0 green:165/255.0 blue:69/255.0 alpha:1];
        [_titleButton setTitle:[NSString stringWithFormat:@"%@",sender.titleLabel.text] forState:UIControlStateNormal];
        [_titleButton sizeToFit];
        _titleButton.center = CGPointMake(_titleView.frame.size.width/2, _titleView.frame.size.height/2);
        _tagView.center = CGPointMake(_titleView.frame.size.width/2+_titleButton.frame.size.width/2+_tagView.frame.size.width/2, _titleView.frame.size.height/2);
        _clickBtn = sender;
    }
    if (sender.tag == 0) {
        [self handleShowData:_allStuCourseArray];
    }else {
        [self handleWeekShowDataWithWeek:sender.tag];
    }
    [self showWeekList];
}

- (void)showWeekList {
    if (_weekViewShow) {
        _tagView.transform = CGAffineTransformMakeRotation(0);
        [UIView animateWithDuration:0 animations:^{
            [_shadeView removeFromSuperview];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _backView.frame = CGRectMake(0, -ScreenHeight/2, _backView.frame.size.width, _backView.frame.size.height);
                _weekViewShow = NO;
            } completion:nil];
        }];
    }else {
        _tagView.transform = CGAffineTransformMakeRotation(M_PI);
        [UIView animateWithDuration:0.3 animations:^{
            _backView.frame = CGRectMake(0, 64, _backView.frame.size.width, _backView.frame.size.height);
        } completion:^(BOOL finished) {
            _shadeView.frame = CGRectMake(0, 64+_backView.frame.size.height, ScreenWidth, ScreenHeight);
//            [[[UIApplication sharedApplication]keyWindow]addSubview:_shadeView];
            [self.view addSubview:_shadeView];
            _weekViewShow = YES;
        }];
    }
}

- (void)hiddenWeekView {
    [_shadeView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _backView.frame = CGRectMake(0, -ScreenHeight/2, _backView.frame.size.width, _backView.frame.size.height);
    } completion:nil];
    _tagView.transform = CGAffineTransformMakeRotation(0);
    _weekViewShow = NO;
}
- (void)clickShadeView {
    [_shadeView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _backView.frame = CGRectMake(0, -ScreenHeight/2, _backView.frame.size.width, _backView.frame.size.height);
    } completion:nil];
    _tagView.transform = CGAffineTransformMakeRotation(0);
    _weekViewShow = NO;
}

- (void)backViewChange:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _startPoint = _backView.center;
        _startPoint1 = _shadeView.center;
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [gesture translationInView:_backView];//求出手指在屏幕上的位移
        if (point.y < 0) {
            _backView.center = CGPointMake(_backView.center.x,_startPoint.y + point.y);
            _shadeView.center = CGPointMake(_shadeView.center.x, _startPoint1.y + point.y);
        }
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [gesture translationInView:_backView];
        CGPoint point1 = [gesture velocityInView:_backView];
        if (point1.y < 0) {
            if (point.y > -60) {
                [UIView animateWithDuration:0.2 animations:^{
                    _backView.frame = CGRectMake(0, 64, _backView.frame.size.width, _backView.frame.size.height);
                    _shadeView.frame = CGRectMake(0, 64+_backView.frame.size.height, ScreenWidth, ScreenHeight);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.05 animations:^{
                        _backView.frame = CGRectMake(0, 61, _backView.frame.size.width, _backView.frame.size.height);
                        _shadeView.frame = CGRectMake(0, 61+_backView.frame.size.height-3, ScreenWidth, ScreenHeight);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.05 animations:^{
                            _backView.frame = CGRectMake(0, 63, _backView.frame.size.width, _backView.frame.size.height);
                            _shadeView.frame = CGRectMake(0, 63+_backView.frame.size.height-1, ScreenWidth, ScreenHeight);
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.05 animations:^{
                                _backView.frame = CGRectMake(0, 64, _backView.frame.size.width, _backView.frame.size.height);
                                _shadeView.frame = CGRectMake(0, 64+_backView.frame.size.height, ScreenWidth, ScreenHeight);
                            } completion:nil];
                        }];
                    }];
                }];
            }else {
                [self hiddenWeekView];
            }
        }else if (point1.y > 0) {
            [UIView animateWithDuration:0.2 animations:^{
                _backView.frame = CGRectMake(0, 64, _backView.frame.size.width, _backView.frame.size.height);
                _shadeView.frame = CGRectMake(0, 64+_backView.frame.size.height, ScreenWidth, ScreenHeight);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    _backView.frame = CGRectMake(0, 61, _backView.frame.size.width, _backView.frame.size.height);
                    _shadeView.frame = CGRectMake(0, 61+_backView.frame.size.height-3, ScreenWidth, ScreenHeight);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.05 animations:^{
                        _backView.frame = CGRectMake(0, 63, _backView.frame.size.width, _backView.frame.size.height);
                        _shadeView.frame = CGRectMake(0, 63+_backView.frame.size.height-1, ScreenWidth, ScreenHeight);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.05 animations:^{
                            _backView.frame = CGRectMake(0, 64, _backView.frame.size.width, _backView.frame.size.height);
                            _shadeView.frame = CGRectMake(0, 64+_backView.frame.size.height, ScreenWidth, ScreenHeight);
                        } completion:nil];
                    }];
                }];
            }];
        }
    }
}
#pragma mark - 请求课表
- (void)loadAllStuCourse {
    _allStuCourseArray = [NSMutableArray array];
    _preWeekCourseArray = [NSMutableArray array];//全部学生的每周课表
    for (int i = 0; i < _allStuNumArray.count; i++) {
        NSMutableArray *preStuWeekCourseArray = [NSMutableArray array];//每个学生每周的课表
        NSString *stuNum = [NSString stringWithFormat:@"%@",_allStuNumArray[i]];
        [NetWork NetRequestPOSTWithRequestURL:Course_API WithParameter:@{@"stuNum":stuNum} WithReturnValeuBlock:^(id returnValue) {
            NSMutableDictionary *courseDic = [[NSMutableDictionary alloc]initWithDictionary:returnValue];
            for (NSInteger j = 0; j < _allStuNameArray.count; j ++) {
                NSInteger stuNum1 = [_allStuNameArray[j][@"stunum"] integerValue];
                NSInteger stuNum2 = [courseDic[@"stuNum"] integerValue];
                if (stuNum1 == stuNum2) {
                    [courseDic setObject:_allStuNameArray[j][@"name"] forKey:@"name"];
                    [_allStuCourseArray addObject:courseDic];
                }
            }
            for (NSInteger i = 0; i<18; i++) {
                [preStuWeekCourseArray addObject:[self getWeekCourseDic:courseDic withWeek:i+1]];
            }
            [_preWeekCourseArray addObject:preStuWeekCourseArray];
            if (_allStuCourseArray.count == _allStuNameArray.count) {
                NSLog(@"全部课表请求完毕 加载数据");
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString *nowWeek = [user objectForKey:@"nowWeek"];
                [self handleWeekShowDataWithWeek:[nowWeek integerValue]];
            }
        } WithFailureBlock:^{
            NSLog(@"请求失败");
        }];
    }
}
#pragma mark - -

#pragma mark - 处理学期
- (void)handleShowData:(NSMutableArray *)allStuCourseArray {
    for (int i = 0; i < _buttonTag.count; i ++) {
        [_buttonTag[i] removeFromSuperview];
    }
    _showDataArray = [NSMutableArray array];
    NSArray *week = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18];
    NSArray *dayArray = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    NSArray *lessonArray = @[@"1-2节",@"3-4节",@"5-6节",@"7-8节",@"9-10节",@"11-12节"];
    for (int day = 0; day < 7; day ++) {
        for (int begin = 1,lesson = 0; begin < 12; begin += 2,lesson ++) {
            NSMutableDictionary *showDic = [NSMutableDictionary dictionary];
            NSMutableArray *names = [NSMutableArray array];
            for (int i = 0; i < allStuCourseArray.count; i ++) {
                BOOL isHaveCourse = NO;
//                BOOL isHaveThree = NO;
                NSArray *course = allStuCourseArray[i][@"data"];
                NSMutableArray *preCourse = [NSMutableArray array];
                //遍历课表内容 筛选出同一时段的 所有课程
                for (int j = 0; j < course.count; j ++) {
                    if ([course[j][@"hash_day"] intValue] == day && [course[j][@"begin_lesson"] intValue] == begin) {
                        [preCourse addObject:course[j]];
                        isHaveCourse = YES;
                    }
                }
                if(preCourse.count == 1) {
                    if ([preCourse[0][@"weekModel"] isEqualToString:@"all"] && ((NSArray *)preCourse[0][@"week"]).count > 3) {
                        NSArray *courseWeek = preCourse[0][@"week"];
                        NSMutableArray *restOfWeek = [NSMutableArray arrayWithArray:week];
                        for (int k = 0; k < courseWeek.count; k ++) {
                            if ([week containsObject:courseWeek[k]]) {
                                [restOfWeek removeObject:courseWeek[k]];
                            }
                        }
                        if (restOfWeek.count > 2) {
                            BOOL isOne = NO;
                            for (NSInteger tmp = 0; tmp < restOfWeek.count-1; tmp ++) {
                                NSInteger pre = [restOfWeek[tmp] integerValue];
                                NSInteger back = [restOfWeek[tmp+1] integerValue];
                                if (pre != back-1) {
                                    isOne = YES;
                                    break;
                                }
                            }
                            if (isOne) {
                                NSString *name = [NSString stringWithFormat:@"%@ (除%@-%@周)",_allStuCourseArray[i][@"name"],courseWeek[0],courseWeek[courseWeek.count-1]];
                                [names addObject:name];
                            }else {
                                NSString *name = [NSString stringWithFormat:@"%@ (%@-%@周)",_allStuCourseArray[i][@"name"],restOfWeek[0],restOfWeek[restOfWeek.count-1]];
                                [names addObject:name];
                            }
                        }else if (restOfWeek.count == 1) {
                            NSString *name = [NSString stringWithFormat:@"%@ (第%@周)",_allStuCourseArray[i][@"name"],restOfWeek[0]];
                            [names addObject:name];
                        }else if (restOfWeek.count == 2) {
                            NSString *name = [NSString stringWithFormat:@"%@ (%@,%@周)",_allStuCourseArray[i][@"name"],restOfWeek[0],restOfWeek[1]];
                            [names addObject:name];
                        }else if (restOfWeek.count == 0) {
                            NSString *name = [NSString stringWithFormat:@"%@",_allStuCourseArray[i][@"name"]];
                            [names addObject:name];
                        }
                    }else if ([preCourse[0][@"weekModel"] isEqualToString:@"all"] && ((NSArray *)preCourse[0][@"week"]).count <= 3) {
                        NSInteger count = ((NSArray *)preCourse[0][@"week"]).count;
                        if (count == 1) {
                            NSString *name = [NSString stringWithFormat:@"%@ (除第%@周)",_allStuCourseArray[i][@"name"],preCourse[0][@"week"][0]];
                            [names addObject:name];
                        }else if (count == 2) {
                            NSString *name = [NSString stringWithFormat:@"%@ (除%@,%@周)",_allStuCourseArray[i][@"name"],preCourse[0][@"week"][0],preCourse[0][@"week"][1]];
                            [names addObject:name];
                        }else if (count == 3) {
                            NSString *name = [NSString stringWithFormat:@"%@ (除%@-%@周)",_allStuCourseArray[i][@"name"],preCourse[0][@"week"][0],preCourse[0][@"week"][2]];
                            [names addObject:name];
                        }
                    }else if ([preCourse[0][@"weekModel"] isEqualToString:@"single"]) {
                        NSString *name = [NSString stringWithFormat:@"%@ (双周)",_allStuCourseArray[i][@"name"]];
                        [names addObject:name];
                    }else if ([preCourse[0][@"weekModel"] isEqualToString:@"double"]) {
                        NSString *name = [NSString stringWithFormat:@"%@ (单周)",_allStuCourseArray[i][@"name"]];
                        [names addObject:name];
                    }
                }else if (preCourse.count == 2) {
                    if ([preCourse[0][@"weekModel"] isEqualToString:@"single"] && [preCourse[1][@"weekModel"] isEqualToString:@"double"]) {
                        
                    }else if ([preCourse[0][@"weekModel"] isEqualToString:@"all"]) {
                        if ([preCourse[0][@"course"] isEqualToString:preCourse[1][@"course"]]) {
                            NSString *name = [NSString stringWithFormat:@"%@ (除%@,%@)",_allStuCourseArray[i][@"name"],preCourse[0][@"rawWeek"],preCourse[1][@"rawWeek"]];
                            [names addObject:name];
                        }else {
                            if (((NSArray *)preCourse[0][@"week"]).count > ((NSArray *)preCourse[1][@"week"]).count) {
                                NSMutableArray *week4 = [NSMutableArray arrayWithArray:preCourse[1][@"week"]];
                                NSInteger count = week4.count;
                                for (int i = 0; i < count; i ++) {
                                    if ([preCourse[0][@"week"] containsObject:week4[i]]) {
                                        [week4 removeObject:week4[i]];
                                    }
                                }
                                if (week4.count == 0) {
                                    NSString *name = [NSString stringWithFormat:@"%@ (除%@)",_allStuCourseArray[i][@"name"],preCourse[0][@"rawWeek"]];
                                    [names addObject:name];
                                }
                            }else if (((NSArray *)preCourse[0][@"week"]).count < ((NSArray *)preCourse[1][@"week"]).count) {
                                NSMutableArray *week4 = [NSMutableArray arrayWithArray:preCourse[0][@"week"]];
                                for (int i = 0; i < week4.count; i ++) {
                                    if ([preCourse[1][@"week"] containsObject:week4[i]]) {
                                        [week4 removeObject:week4[i]];
                                    }
                                }
                                if (week4.count == 0) {
                                    NSString *name = [NSString stringWithFormat:@"%@ (除%@)",_allStuCourseArray[i][@"name"],preCourse[1][@"rawWeek"]];
                                    [names addObject:name];
                                }
                            }else {
                                NSString *name = [NSString stringWithFormat:@"%@ (除%@)",_allStuCourseArray[i][@"name"],preCourse[0][@"rawWeek"]];
                                [names addObject:name];
                            }
                        }
                    }
                }else if (preCourse.count > 2) {
                    NSMutableArray *weeks = [NSMutableArray array];
                    for (int i = 0; i < preCourse.count; i ++) {
                        NSArray *week2 = preCourse[i][@"week"];
                        for (int j = 0; j < week2.count; j ++) {
                            [weeks addObject:week2[j]];
                        }
                    }
                    if (weeks.count > 2) {
                        NSString *name = [NSString stringWithFormat:@"%@ (除%@-%@周)",_allStuCourseArray[i][@"name"],weeks[0],weeks[weeks.count-1]];
                        [names addObject:name];
                    }
                }
                if (!isHaveCourse) {
                    NSString *name = [NSString stringWithFormat:@"%@",_allStuCourseArray[i][@"name"]];
                    [names addObject:name];
                }
            }
            [showDic setObject:dayArray[day] forKey:@"day"];
            [showDic setObject:lessonArray[lesson] forKey:@"lesson"];
            [showDic setObject:[NSNumber numberWithInt:day] forKey:@"hash_day"];
            [showDic setObject:[NSNumber numberWithInt:begin] forKey:@"begin_lesson"];
            [showDic setObject:names forKey:@"names"];
            [_showDataArray addObject:showDic];
        }
    }
    [self handleColor:_showDataArray];
    [self showUIWithDictionary:_showDataArray];
}
#pragma mark - -

#pragma mark - 处理周

- (void)handleWeekShowDataWithWeek:(NSInteger)week{
    for (int i = 0; i < _buttonTag.count; i ++) {
        [_buttonTag[i] removeFromSuperview];
    }
    NSLog(@"加载本周数据");
    _showDataArray = [NSMutableArray array];
    NSArray *dayArray = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    NSArray *lessonArray = @[@"1-2节",@"3-4节",@"5-6节",@"7-8节",@"9-10节",@"11-12节"];
    for (int day = 0; day < 7; day ++) {
        for (int begin = 1,lesson = 0; begin < 12; begin += 2,lesson ++) {
            NSMutableDictionary *showDic = [NSMutableDictionary dictionary];
            NSMutableArray *names = [NSMutableArray array];
            for (int i = 0; i < _preWeekCourseArray.count; i ++) {
                BOOL isHaveCourse = NO;
                NSArray *weekCourse = _preWeekCourseArray[i][week-1][@"data"];
                //遍历课表内容 筛选出同一时段的 所有课程
                for (int j = 0; j < weekCourse.count; j ++) {
                    if ([weekCourse[j][@"hash_day"] intValue] == day && [weekCourse[j][@"begin_lesson"] intValue] == begin) {
                        isHaveCourse = YES;
                    }
                }
                if (!isHaveCourse) {
                    NSString *name = [NSString stringWithFormat:@"%@",_preWeekCourseArray[i][week][@"name"]];
                    [names addObject:name];
                }
            }
            [showDic setObject:dayArray[day] forKey:@"day"];
            [showDic setObject:lessonArray[lesson] forKey:@"lesson"];
            [showDic setObject:[NSNumber numberWithInt:day] forKey:@"hash_day"];
            [showDic setObject:[NSNumber numberWithInt:begin] forKey:@"begin_lesson"];
            [showDic setObject:names forKey:@"names"];
            [_showDataArray addObject:showDic];
        }
    }
    [self handleColor:_showDataArray];
    [self showUIWithDictionary:_showDataArray];
}

#pragma mark - -

#pragma mark - 显示UI

- (void)showUIWithDictionary:(NSMutableArray *)array {
    _buttonTag = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dic = array[i];
        NSArray *names = dic[@"names"];
        if (names.count>0) {
            int rowNum = [[dic objectForKey:@"begin_lesson"] intValue]-1;
            int colNum = [[dic objectForKey:@"hash_day"] intValue]+1;
            
            CourseButton *courseButton = [[CourseButton alloc] initWithFrame:CGRectMake((colNum-0.5)*kWidthGrid+1, kWidthGrid*rowNum+1, kWidthGrid-2, kWidthGrid*2-2)];
            courseButton.buttonInfoDic = dic;
            if (names.count > 2) {
                [courseButton setTitle:[NSString stringWithFormat:@"%@ %@ %@",names[0],names[1],names[2]] forState:UIControlStateNormal];
            }else if (names.count == 2) {
                [courseButton setTitle:[NSString stringWithFormat:@"%@ %@",names[0],names[1]] forState:UIControlStateNormal];
            }else if (names.count == 1) {
                [courseButton setTitle:[NSString stringWithFormat:@"%@",names[0]] forState:UIControlStateNormal];
            }
            courseButton.tag = i;
            [_buttonTag addObject:courseButton];
            courseButton.backgroundColor = [self handleRandomColorStr:dic[@"color"]];
            [courseButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_mainScrollView addSubview:courseButton];
            if(names.count > 2) {
                UIImageView *tagView = [[UIImageView alloc]initWithFrame:CGRectMake((colNum+0.5)*kWidthGrid-8, kWidthGrid*rowNum+kWidthGrid*2-8, 6, 6)];
                tagView.image = [UIImage imageNamed:@"iconfont-tag.png"];
                [_buttonTag addObject:tagView];
                [_mainScrollView addSubview:tagView];
            }
        }
    }
}

#pragma mark - -

#pragma mark 处理课表颜色
- (void)handleColor:(NSMutableArray *)courses {
    _colorArray = ColorArray;
    for (int i = 0; i < courses.count; i ++) {
        NSString *day = courses[i][@"hash_day"];
        NSString *lesson = courses[i][@"hash_lesson"];
        if (day.integerValue >= 0 && day.integerValue < 5) {
            if (lesson.integerValue >= 0 && lesson.integerValue < 2) {
                [courses[i] setObject:_colorArray[0] forKey:@"color"];
            }else if (lesson.integerValue >= 2 && lesson.integerValue < 4) {
                [courses[i] setObject:_colorArray[1] forKey:@"color"];
            }else {
                [courses[i] setObject:_colorArray[2] forKey:@"color"];
            }
        }else {
            [courses[i] setObject:_colorArray[3] forKey:@"color"];
        }
    }
}
#pragma mark - -

#pragma mark - 颜色私有方法
//处理随机颜色字符串
- (UIColor *)handleRandomColorStr:(NSString *)randomColorStr
{
    NSArray *array = [randomColorStr componentsSeparatedByString:@","];
    if (array.count >2) {
        NSString *red = array[0];
        NSString *green = array[1];
        NSString *blue = array[2];
        return RGBColor(red.floatValue, green.floatValue, blue.floatValue, 1);
    }
    return [UIColor lightGrayColor];
}
#pragma mark - -

#pragma mark 获取周课表
- (NSMutableDictionary *)getWeekCourseDic:(NSMutableDictionary *)courseDic withWeek:(NSInteger)week {
    NSMutableArray *data = [NSMutableArray array];
    NSMutableDictionary *course = [[NSMutableDictionary alloc]initWithDictionary:courseDic];
    NSArray *courseData = course[@"data"];
    for (int i = 0; i < courseData.count; i ++) {
        if ([courseData[i][@"week"] containsObject:[NSNumber numberWithInteger:week]]) {
            [data addObject:courseData[i]];
        }
    }
    [course setObject:data forKey:@"data"];
//    NSLog(@"%@",course[@"name"]);
    return course;
}
#pragma mark - -

- (void)btnClick:(CourseButton *)sender {
    NSLog(@"%@",sender.buttonInfoDic[@"names"]);
    _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.7;
    UIButton *backgroundViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backgroundViewBtn.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [backgroundViewBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:backgroundViewBtn];
    [[[UIApplication sharedApplication]keyWindow]addSubview:_backgroundView];
    
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/9, ScreenHeight/7, ScreenWidth/9*7, ScreenHeight/9*5)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 1.0;
    _alertView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    [[[UIApplication sharedApplication]keyWindow]addSubview:_alertView];
    
    UIView *infotitleView = [[UIView alloc]initWithFrame:CGRectMake(15, 5, _alertView.frame.size.width-30, 40)];
    [_alertView addSubview:infotitleView];
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 0, _alertView.frame.size.width, 40)];
    infoLabel.text = @"没课约详情";
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.font = [UIFont systemFontOfSize:20];
    infoLabel.textColor = MAIN_COLOR;
    [infotitleView addSubview:infoLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, _alertView.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:0.5];
    [_alertView addSubview:lineView];
    
    QGERestTimeDetailView *detailView = [[QGERestTimeDetailView alloc]initWithFrame:CGRectMake(0, 50, _alertView.frame.size.width, _alertView.frame.size.height-120) withDictionary:sender.buttonInfoDic];
    [_alertView addSubview:detailView];
    
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(10, _alertView.frame.size.height-52, _alertView.frame.size.width-20, 40)];
    done.layer.cornerRadius = 5.0;
    [done setTitle:@"确定" forState:UIControlStateNormal];
    done.titleLabel.font = [UIFont systemFontOfSize:17];
    done.backgroundColor = MAIN_COLOR;
    done.titleLabel.textAlignment = NSTextAlignmentCenter;
    [done addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:done];
}

- (void)doneClick {
    [self.backgroundView removeFromSuperview];
    [self.alertView removeFromSuperview];
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

//
//  CourseViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/8/21.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#define kWidthGrid  (ScreenWidth/7.5)

#define Course_API @"http://hongyan.cqupt.edu.cn/redapi2/api/kebiao"

#import "CourseViewController.h"
#import "Course.h"
#import "CourseButton.h"
#import "CourseView.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "UIImage+ImageEffects.h"


@interface CourseViewController ()<UIScrollViewDelegate>

@property (assign, nonatomic) BOOL weekViewShow;
@property (strong, nonatomic) UIButton *titleButton;
@property (strong, nonatomic) UIImageView *tagView;
@property (strong, nonatomic) UIScrollView *weekScrollView;
@property (strong, nonatomic) UIView *shadeView;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIImageView *blurImageView;
@property (strong, nonatomic) UIImage *screenshot;
@property (strong, nonatomic) UIButton *clickBtn;
@property (strong, nonatomic) UIView *nav;
@property (strong, nonatomic) NSMutableArray *weekBtnArray;

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) NSMutableArray *colorArray;
@property (strong, nonatomic) NSMutableSet *registRepeatClassSet;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSArray *weekDataArray;
@property (strong, nonatomic) NSArray *weekArray;
@property (strong, nonatomic) NSMutableArray *buttonTag;
@property (strong, nonatomic) NSMutableArray *courseBackViewTag;

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIPageControl *page;
@property (strong, nonatomic) UIView *alertView;

@property (strong, nonatomic) NSMutableDictionary *parameter;
@property (assign, nonatomic) CGPoint startPoint;
@property (assign, nonatomic) CGPoint startPoint1;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _weekViewShow = NO;
    [self initView];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, -ScreenHeight/2, ScreenWidth, ScreenHeight/2)];
    [self.view addSubview:_backView];
    
    _weekScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/2-30)];
    _weekScrollView.contentSize = CGSizeMake(ScreenWidth, 35*19);
    _weekScrollView.backgroundColor = [UIColor whiteColor];
    _weekScrollView.bounces = NO;
    [_backView addSubview:_weekScrollView];
    
    _weekArray = @[@"本学期",@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周",@"第九周",@"第十周",@"第十一周",@"第十二周",@"第十三周",@"第十四周",@"第十五周",@"第十六周",@"第十七周",@"第十八周"];
    NSString *nowWeek = [userDefault objectForKey:@"nowWeek"];
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
    backBtn.frame = CGRectMake(0, ScreenHeight/2-30, ScreenWidth, 30);
    backBtn.backgroundColor = [UIColor whiteColor];
    [backBtn addTarget:self action:@selector(hiddenWeekView) forControlEvents:UIControlEventTouchUpInside];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(backViewChange:)];
    [backBtn addGestureRecognizer:pan];
    [_backView addSubview:backBtn];
    
    UIImageView *backBtnImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    backBtnImage.center = CGPointMake(backBtn.frame.size.width/2, backBtn.frame.size.height/2);
    backBtnImage.image = [UIImage imageNamed:@"iconfont-backTag.png"];
    [backBtn addSubview:backBtnImage];
    
    UIView *underLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight/2-30, ScreenWidth, 1)];
    underLine.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [_backView addSubview:underLine];
    
    _nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _nav.backgroundColor = MAIN_COLOR;
    [self.view addSubview:_nav];
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
    [_titleButton sizeToFit];
    _titleButton.center = CGPointMake(ScreenWidth/2, _nav.frame.size.height/2+10);
    [_titleButton addTarget:self action:@selector(showWeekList) forControlEvents:UIControlEventTouchUpInside];
    [_nav addSubview:_titleButton];
    
    _tagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 6)];
    _tagView.center = CGPointMake(_titleButton.center.x+_titleButton.frame.size.width/2+8, _nav.frame.size.height/2+10);
    _tagView.image = [UIImage imageNamed:@"iconfont-titleTag.png"];
    [_nav addSubview:_tagView];
    
    _shadeView = [[UIView alloc]initWithFrame:CGRectMake(0, _backView.frame.size.height+64, ScreenWidth, ScreenHeight)];
    _shadeView.backgroundColor = [UIColor blackColor];
    _shadeView.alpha = 0.7;
    
    UIButton *shadeViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shadeViewBtn.frame = CGRectMake(0, 0, _shadeView.frame.size.width, _shadeView.frame.size.height);
    [shadeViewBtn addTarget:self action:@selector(clickShadeView) forControlEvents:UIControlEventTouchUpInside];
    [_shadeView  addSubview:shadeViewBtn];
    
    _weekDataArray = [userDefault objectForKey:@"weekDataArray"];
    _weekDataArray = [self getWeekCourseArray:[nowWeek integerValue]];
    _dataArray = _weekDataArray;
    [self handleData:_weekDataArray];
    [self loadNetData];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 加载主要页面
- (void)initView {
    _registRepeatClassSet = [[NSMutableSet alloc] init];
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 49)];
    [self.view addSubview:_mainView];
    
    UIView *dayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    dayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [_mainView addSubview:dayView];
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, ScreenWidth, _mainView.frame.size.height - 30)];
    
    _courseBackViewTag = [NSMutableArray array];
    for (int i = 0; i < 7; i ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((i+0.5)*kWidthGrid+1, 0, kWidthGrid-2, kWidthGrid*12-2)];
        NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
        NSInteger weekDay = [componets weekday];
        if (weekDay == 1) {
            weekDay = 8;
        }
        if (i == weekDay - 2) {
            view.backgroundColor = [UIColor colorWithRed:253/255.0 green:246/255.0 blue:235/255.0 alpha:1];
        }
        [_mainScrollView addSubview:view];
        [_courseBackViewTag addObject:view];
    }
    
    NSArray *array = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    for (int i = 0; i < 7; i ++) {
        UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake((i+0.5)*kWidthGrid, 1, kWidthGrid, 29)];
        dayLabel.text = [NSString stringWithFormat:@"%@",array[i]];
        dayLabel.font = [UIFont systemFontOfSize:14];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
        UIView *dayLabelUnderLine = [[UIView alloc]initWithFrame:CGRectMake((i+0.5)*kWidthGrid+1, 29, kWidthGrid-2, 1)];
        NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
        NSInteger weekDay = [componets weekday];
        if (weekDay == 1) {
            weekDay = 8;
        }
        if (i == weekDay - 2) {
            dayLabel.textColor = MAIN_COLOR;
            dayLabelUnderLine.backgroundColor = MAIN_COLOR;
        }
        [dayView addSubview:dayLabelUnderLine];
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
#pragma mark 请求课表数据
- (void)loadNetData {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *stuNum = [userDefault objectForKey:@"stuNum"];
    _parameter = [NSMutableDictionary dictionary];
    [_parameter setObject:stuNum forKey:@"stuNum"];
    
    [NetWork NetRequestPOSTWithRequestURL:Course_API WithParameter:_parameter WithReturnValeuBlock:^(id returnValue) {
        NSMutableArray *dataArray = [returnValue objectForKey:@"data"];
        NSMutableArray *data = [NSMutableArray array];
        for (int i = 0; i < dataArray.count; i ++) {
            NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]initWithDictionary:dataArray[i]];
            NSString *period = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"period"]];
            if ([period isEqualToString:@"3"]) {
                [dataDic setObject:@"2" forKey:@"period"];
                [dataDic setObject:@"(3节连上)" forKey:@"courseTitle"];
            }
            [data addObject:dataDic];
        }
        [self handleWeek:data];
        [self handleColor:data];
        _dataArray = data;
        _weekDataArray = data;
        NSString *nowWeek = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"nowWeek"]];
        self.tabBarItem.title = [NSString stringWithFormat:@"第%@周",[returnValue objectForKey:@"nowWeek"]];
        
        /**共享数据 by Orange-W**/
        NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:kAPPGroupID];
        [shared setObject:[self getWeekCourseArray:[nowWeek integerValue]] forKey:kAppGroupShareThisWeekArray];
        [shared synchronize];
        /***/
        
        [userDefault setObject:nowWeek forKey:@"nowWeek"];
        [userDefault setObject:_weekDataArray forKey:@"weekDataArray"];
        [userDefault setObject:_dataArray forKey:@"dataArray"];
        [userDefault synchronize];
        for (int i = 0; i < _buttonTag.count; i ++) {
            [_buttonTag[i] removeFromSuperview];
        }
        _dataArray = [self getWeekCourseArray:[nowWeek integerValue]];
        [self handleData:_dataArray];
        for (int i = 0; i < _weekBtnArray.count; i ++) {
            if (i == [nowWeek integerValue]) {
                UIButton *weekBtn1 = _weekBtnArray[i];
                [weekBtn1 setTitle:@"本周" forState:UIControlStateNormal];
                if (_clickBtn != weekBtn1 || _clickBtn == nil) {
                    _clickBtn.selected = NO;
                    [_clickBtn setTitle:[NSString stringWithFormat:@"%@",_weekArray[i-1]] forState:UIControlStateNormal];
                    [_clickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    _clickBtn.backgroundColor = [UIColor whiteColor];
                    weekBtn1.selected = YES;
                    [weekBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    weekBtn1.backgroundColor = [UIColor colorWithRed:250/255.0 green:165/255.0 blue:69/255.0 alpha:1];
                    [_titleButton setTitle:[NSString stringWithFormat:@"%@",weekBtn1.titleLabel.text] forState:UIControlStateNormal];
                    _clickBtn = weekBtn1;
                }
                [_titleButton setTitle:[NSString stringWithFormat:@"%@",weekBtn1.titleLabel.text] forState:UIControlStateNormal];
                [_titleButton sizeToFit];
                _titleButton.center = CGPointMake(ScreenWidth/2, _nav.frame.size.height/2+10);
                _tagView.center = CGPointMake(_titleButton.center.x+_titleButton.frame.size.width/2+8, _nav.frame.size.height/2+10);
                if ([nowWeek integerValue] > 6 && [nowWeek integerValue] < 13) {
                    _weekScrollView.contentOffset = CGPointMake(0, _weekScrollView.frame.size.height/2);
                }
            }
        }
    } WithFailureBlock:^{
        NSLog(@"课表数据请求失败");
    }];
}
#pragma mark 处理课表数据的周数
- (void)handleWeek:(NSMutableArray *)array {
    if (array != nil && array.count > 0) {
        for (int i = 0; i < array.count; i++) {
            NSString *day = [array[i] objectForKey:@"day"];
            NSString *weekNum;
            if ([@"星期一" isEqualToString:day]) {
                weekNum = @"1";
            }else if ([@"星期二" isEqualToString:day]){
                weekNum = @"2";
            }else if ([@"星期三" isEqualToString:day]){
                weekNum = @"3";
            }else if ([@"星期四" isEqualToString:day]){
                weekNum = @"4";
            }else if ([@"星期五" isEqualToString:day]){
                weekNum = @"5";
            }else if ([@"星期六" isEqualToString:day]){
                weekNum = @"6";
            }else if([@"星期日" isEqualToString:day]){
                weekNum = @"7";
            }else {
                weekNum = day;
            }
            [array[i] setObject:weekNum forKey:@"day"];
        }
    }
}
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

- (void)handleData:(NSArray *)courses {
    NSInteger currentTag = -1;
    _buttonTag = [NSMutableArray array];
    if (courses.count > 0) {
        int currentBegin = 0;
        int currentDay = 0;
        for (int i = 0; i<courses.count; i++) {
            Course *course = [[Course alloc]initWithPropertiesDictionary:courses[i]];
            int rowNum = course.begin_lesson.intValue - 1;
            int colNum = course.day.intValue;
            int period = course.period.intValue;
            
            if (rowNum == currentBegin && colNum == currentDay) {
                UIImageView *tagView = [[UIImageView alloc]initWithFrame:CGRectMake((colNum+0.5)*kWidthGrid-8, kWidthGrid*rowNum+kWidthGrid*period-8, 6, 6)];
                tagView.image = [UIImage imageNamed:@"iconfont-tag.png"];
                [_buttonTag addObject:tagView];
                [_mainScrollView addSubview:tagView];
                if (currentTag!=-1) {
                    [self.registRepeatClassSet addObject:[NSNumber numberWithInteger:currentTag]];
                    [self.registRepeatClassSet addObject:[NSNumber numberWithInteger:currentTag+1]];
                }
            }else {
                CourseButton *courseButton = [[CourseButton alloc] initWithFrame:CGRectMake((colNum-0.5)*kWidthGrid+1, kWidthGrid*rowNum+1, kWidthGrid-2, kWidthGrid*period-2)];
                if (course.courseTitle == nil) {
                    [courseButton setTitle:[NSString stringWithFormat:@"%@ @%@ %@",course.course,course.classroom,course.rawWeek]forState:UIControlStateNormal];
                }else {
                    [courseButton setTitle:[NSString stringWithFormat:@"%@ @%@ %@ %@",course.course,course.classroom,course.rawWeek,course.courseTitle]forState:UIControlStateNormal];
                }
                courseButton.tag = i;
                [_buttonTag addObject:courseButton];
                [courseButton setBackgroundImage:[self imageWithColor:[self handleRandomColorStr:course.color withLightModel:0]] forState:UIControlStateNormal];
                [courseButton setBackgroundImage:[self imageWithColor:[self handleRandomColorStr:course.color withLightModel:1]] forState:UIControlStateHighlighted];
                [courseButton addTarget:self action:@selector(courseClick:) forControlEvents:UIControlEventTouchUpInside];
                [_mainScrollView addSubview:courseButton];
                currentTag = courseButton.tag;
            }
            currentBegin = rowNum;
            currentDay = colNum;
        }
    }
}

#pragma mark - 颜色私有方法
//处理随机颜色字符串
- (UIColor *)handleRandomColorStr:(NSString *)randomColorStr withLightModel:(NSInteger)model
{
    NSArray *array = [randomColorStr componentsSeparatedByString:@","];
    if (array.count > 2) {
        NSString *red = array[0];
        NSString *green = array[1];
        NSString *blue = array[2];
        if (model == 0) {
            return RGBColor(red.floatValue, green.floatValue, blue.floatValue, 1);
        }else if (model == 1) {
            return RGBColor(red.floatValue, green.floatValue, blue.floatValue, 0.7);
        }
    }
    
    return [UIColor lightGrayColor];
}

//颜色转image
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark 课表button点击方法
- (void)courseClick:(UIButton *)sender {
    NSInteger tagNum = sender.tag;
    NSInteger endNum = tagNum;
    NSSet *tagSet = [[NSSet alloc]initWithObjects:[NSNumber numberWithInteger:tagNum], nil];
    if ([tagSet isSubsetOfSet:self.registRepeatClassSet]) {
        NSDictionary *dic = _dataArray[tagNum];
        NSInteger compareTag = tagNum+1;
        tagSet = [[NSSet alloc]initWithObjects:[NSNumber numberWithInteger:compareTag], nil];
        while ([tagSet isSubsetOfSet:self.registRepeatClassSet]
               && compareTag < _dataArray.count
               && _dataArray[compareTag][@"day"] == dic[@"day"]
               && _dataArray[compareTag][@"begin_lesson"] == dic[@"begin_lesson"]
               ) {
            endNum++;
            compareTag++;
        }
    }
    [self viewCourseWithTag:tagNum endTag:endNum];
}

#pragma mark 课表详情页面
- (void)viewCourseWithTag:(NSInteger )starTag endTag:(NSInteger)endTag {
    _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0;
    UIButton *backgroundViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backgroundViewBtn.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [backgroundViewBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:backgroundViewBtn];
    
    self.screenshot = [self _screenshotFromView:[UIApplication sharedApplication].keyWindow];
    [_backgroundView addSubview:self.blurImageView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage* blurImage = [self.screenshot applyBlurWithRadius:20
                                                        tintColor:RGBColor(0, 0, 0, 0.6)
                                            saturationDeltaFactor:1.4
                                                        maskImage:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            _blurImageView.image = blurImage;
            [UIView animateWithDuration:0.1f animations:^{
                _blurImageView.alpha = 1.0f;
            }];
        });
    });
    if(ScreenWidth == 320) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/9, ScreenHeight/7, 240, 380+10)];
    }else {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/9, ScreenHeight/7, 292, 380+10)];
    }
    
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 1.0;
    _alertView.alpha = 0;
    _alertView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    
    
    UIView *infotitleView = [[UIView alloc]initWithFrame:CGRectMake(15, 5, _alertView.frame.size.width-30, 40)];
    [_alertView addSubview:infotitleView];
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 0, _alertView.frame.size.width, 40)];
    infoLabel.text = @"课程详细信息";
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.font = [UIFont systemFontOfSize:20];
    infoLabel.textColor = MAIN_COLOR;
    [infotitleView addSubview:infoLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, _alertView.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:0.5];
    [_alertView addSubview:lineView];
                                                                                                                                                                                                                                
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(10, _alertView.frame.size.height-52, _alertView.frame.size.width-20, 40)];
    done.layer.cornerRadius = 5.0;
    [done setTitle:@"确定" forState:UIControlStateNormal];
    done.titleLabel.font = [UIFont systemFontOfSize:17];
    done.backgroundColor = MAIN_COLOR;
    done.titleLabel.textAlignment = NSTextAlignmentCenter;
    [done addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:done];
    
    
    UIScrollView *courseScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, _alertView.frame.size.width, _alertView.frame.size.height-62-50)];
    courseScroll.pagingEnabled = true;
    courseScroll.showsHorizontalScrollIndicator = NO;
    courseScroll.contentSize = CGSizeMake((_alertView.frame.size.width)*(endTag-starTag+1), _alertView.frame.size.height-62-50);
    courseScroll.delegate = self;
    [_alertView addSubview:courseScroll];
    
    _page = [[UIPageControl alloc]initWithFrame:CGRectZero];
    _page.center = CGPointMake(_alertView.frame.size.width/2, courseScroll.frame.origin.y+courseScroll.frame.size.height);
    _page.numberOfPages = endTag-starTag+1;
    _page.currentPage = 0;
    _page.backgroundColor = [UIColor blueColor];
    [_page setCurrentPageIndicatorTintColor:MAIN_COLOR];
    [_page setPageIndicatorTintColor:[UIColor grayColor]];
    [_alertView addSubview:_page];

    CGFloat indexX = 0;
    for (NSInteger i=starTag; i<=endTag; i++) {
        NSDictionary *dataDic = _dataArray[i];
        CourseView *courseView = [[CourseView alloc]initWithFrame:CGRectMake(indexX, 0, _alertView.frame.size.width, _alertView.frame.size.height-52-50) withDictionary:dataDic];
        [courseScroll addSubview:courseView];
        indexX += courseScroll.contentSize.width/(endTag-starTag+1);
    }
    
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:_backgroundView];
    [[[UIApplication sharedApplication]keyWindow]addSubview:_alertView];
    
    [UIView animateWithDuration:0.1 animations:^{
        _backgroundView.alpha = 1;
        _alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

//获取屏幕截图
- (UIImage *)_screenshotFromView:(UIView *)aView {
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size,NO,[UIScreen mainScreen].scale);
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshotImage;
}

- (UIImageView *)blurImageView {
    if (!_blurImageView) {
        _blurImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _blurImageView.alpha = 0.0f;
    }
    return _blurImageView;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat distance = scrollView.contentOffset.x;
    CGFloat pageWith = scrollView.frame.size.width;
    int pageNum = floor((distance + pageWith/2)/pageWith);
    _page.currentPage = pageNum;
}

- (void)doneClick {
    [UIView animateWithDuration:0.2 animations:^{
        _backgroundView.alpha = 0;
        _alertView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self.alertView removeFromSuperview];
        [self.page removeFromSuperview];
    }];
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
            _shadeView.frame = CGRectMake(0, _backView.frame.size.height+64, ScreenWidth, ScreenHeight);
            [[[UIApplication sharedApplication]keyWindow]addSubview:_shadeView];
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

- (void)clickBtn:(UIButton *)sender {
    for (int i = 0; i < _buttonTag.count; i ++) {
        [_buttonTag[i] removeFromSuperview];
    }
    if (_clickBtn == nil) {
        sender.selected = YES;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor colorWithRed:250/255.0 green:165/255.0 blue:69/255.0 alpha:1];
        [_titleButton setTitle:[NSString stringWithFormat:@"%@",sender.titleLabel.text] forState:UIControlStateNormal];
        [_titleButton sizeToFit];
        _titleButton.center = CGPointMake(ScreenWidth/2, _nav.frame.size.height/2+10);
        _tagView.center = CGPointMake(_titleButton.center.x+_titleButton.frame.size.width/2+8, _nav.frame.size.height/2+10);
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
        _titleButton.center = CGPointMake(ScreenWidth/2, _nav.frame.size.height/2+10);
        _tagView.center = CGPointMake(_titleButton.center.x+_titleButton.frame.size.width/2+8, _nav.frame.size.height/2+10);
        _clickBtn = sender;
    }
    _dataArray = [self getWeekCourseArray:sender.tag];
    [self handleData:_dataArray];
    [self showWeekList];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *nowWeek = [user objectForKey:@"nowWeek"];
    if (sender.tag != [nowWeek integerValue]) {
        for (int i = 0; i < _courseBackViewTag.count; i ++) {
            UIView *view = _courseBackViewTag[i];
            view.backgroundColor = [UIColor clearColor];
            _courseBackViewTag[i] = view;
        }
    }else if (sender.tag == [nowWeek integerValue]) {
        NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
        NSInteger weekDay = [componets weekday];
        if (weekDay == 1) {
            weekDay = 8;
        }
        UIView *view = _courseBackViewTag[weekDay - 2];
        view.backgroundColor = [UIColor colorWithRed:253/255.0 green:246/255.0 blue:235/255.0 alpha:1];
        _courseBackViewTag[weekDay - 2] = view;
    }
}

- (void)clickShadeView {
    [_shadeView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _backView.frame = CGRectMake(0, -ScreenHeight/2, _backView.frame.size.width, _backView.frame.size.height);
    } completion:nil];
    _tagView.transform = CGAffineTransformMakeRotation(0);
    _weekViewShow = NO;
}
#pragma mark 获取周课表
- (NSMutableArray *)getWeekCourseArray:(NSInteger)week {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *dataArray = [userDefault objectForKey:@"dataArray"];
    NSArray *weekDataArray = [userDefault objectForKey:@"weekDataArray"];
    NSMutableArray *weekCourseArray = [NSMutableArray array];
    if (week == 0) {
        weekCourseArray = [NSMutableArray arrayWithArray:dataArray];
    }else {
        for (int i = 0; i < weekDataArray.count; i ++) {
            if ([weekDataArray[i][@"week"] containsObject:[NSNumber numberWithInteger:week]]) {
                NSMutableDictionary *weekDataDic = [[NSMutableDictionary alloc]initWithDictionary:weekDataArray[i]];
                [weekCourseArray addObject:weekDataDic];
            }
        }
        [self handleColor:weekCourseArray];
    }
    
    
    return weekCourseArray;
}
#pragma mark -
#pragma mark 手势
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
                    _shadeView.frame = CGRectMake(0, _backView.frame.size.height+64, ScreenWidth, ScreenHeight);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.05 animations:^{
                        _backView.frame = CGRectMake(0, 61, _backView.frame.size.width, _backView.frame.size.height);
                        _shadeView.frame = CGRectMake(0, _backView.frame.size.height+61, ScreenWidth, ScreenHeight);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.05 animations:^{
                            _backView.frame = CGRectMake(0, 63, _backView.frame.size.width, _backView.frame.size.height);
                            _shadeView.frame = CGRectMake(0, _backView.frame.size.height+63, ScreenWidth, ScreenHeight);
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.05 animations:^{
                                _backView.frame = CGRectMake(0, 64, _backView.frame.size.width, _backView.frame.size.height);
                                _shadeView.frame = CGRectMake(0, _backView.frame.size.height+64, ScreenWidth, ScreenHeight);
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
                _shadeView.frame = CGRectMake(0, _backView.frame.size.height+64, ScreenWidth, ScreenHeight);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    _backView.frame = CGRectMake(0, 61, _backView.frame.size.width, _backView.frame.size.height);
                    _shadeView.frame = CGRectMake(0, _backView.frame.size.height+61, ScreenWidth, ScreenHeight);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.05 animations:^{
                        _backView.frame = CGRectMake(0, 63, _backView.frame.size.width, _backView.frame.size.height);
                        _shadeView.frame = CGRectMake(0, _backView.frame.size.height+63, ScreenWidth, ScreenHeight);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.05 animations:^{
                            _backView.frame = CGRectMake(0, 64, _backView.frame.size.width, _backView.frame.size.height);
                            _shadeView.frame = CGRectMake(0, _backView.frame.size.height+64, ScreenWidth, ScreenHeight);
                        } completion:nil];
                    }];
                }];
            }];
        }
    }
}

@end

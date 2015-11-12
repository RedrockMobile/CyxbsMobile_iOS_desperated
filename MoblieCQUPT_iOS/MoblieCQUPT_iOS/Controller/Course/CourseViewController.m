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


@interface CourseViewController ()<UIScrollViewDelegate,UPStackMenuItemDelegate,UPStackMenuDelegate>

@property (assign, nonatomic) BOOL weekViewShow;
@property (strong, nonatomic) UIButton *titleButton;
@property (strong, nonatomic) UIImageView *tagView;
@property (strong, nonatomic) UIScrollView *weekScrollView;
@property (strong, nonatomic) UIView *shadeView;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIButton *clickBtn;
@property (strong, nonatomic) UIView *nav;
@property (strong, nonatomic) NSMutableArray *weekBtnArray;

@property (strong, nonatomic)UIView *mainView;
@property (strong, nonatomic)UIScrollView *mainScrollView;
@property (strong, nonatomic)NSMutableArray *colorArray;
@property (strong, nonatomic)NSMutableSet *registRepeatClassSet;
@property (strong, nonatomic)NSArray *dataArray;
@property (strong, nonatomic)NSArray *weekDataArray;
@property (strong, nonatomic)NSMutableArray *buttonTag;

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIPageControl *page;
@property (strong, nonatomic) UIView *alertView;

@property (strong, nonatomic)NSMutableDictionary *parameter;
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
    
    NSArray *weekArray = @[@"本学期",@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周",@"第九周",@"第十周",@"第十一周",@"第十二周",@"第十三周",@"第十四周",@"第十五周",@"第十六周",@"第十七周",@"第十八周"];
    NSString *nowWeek = [userDefault objectForKey:@"nowWeek"];
    _weekBtnArray = [NSMutableArray array];
    for (int i = 0; i < 19; i ++) {
        UIButton *weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        weekBtn.frame = CGRectMake(0, 35*i, ScreenWidth, 35);
        [weekBtn setTitle:weekArray[i] forState:UIControlStateNormal];
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
    _titleButton.center = CGPointMake(ScreenWidth/2, _nav.frame.size.height/2+10);
    [_titleButton setTitle:[NSString stringWithFormat:@"%@",weekArray[[nowWeek integerValue]]] forState:UIControlStateNormal];
    [_titleButton addTarget:self action:@selector(showWeekList) forControlEvents:UIControlEventTouchUpInside];
    [_nav addSubview:_titleButton];
    
    _tagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 6)];
    _tagView.center = CGPointMake(ScreenWidth/2+37, _nav.frame.size.height/2+10);
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
    [self handleData:_weekDataArray];
    [self loadNetData];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initView {
    _registRepeatClassSet = [[NSMutableSet alloc] init];
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 49)];
    [self.view addSubview:_mainView];
    
    UIView *dayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    dayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [_mainView addSubview:dayView];
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, ScreenWidth, _mainView.frame.size.height - 30)];
    
    for (int i = 0; i < 7; i ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((i+0.5)*kWidthGrid, 0, kWidthGrid-2, kWidthGrid*12-2)];
        NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
        NSInteger weekDay = [componets weekday];
        if (weekDay == 1) {
            weekDay = 8;
        }
        if (i == weekDay - 2) {
            view.backgroundColor = [UIColor colorWithRed:253/255.0 green:246/255.0 blue:235/255.0 alpha:1];
        }
        [_mainScrollView addSubview:view];
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
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
}

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
                if (_clickBtn != weekBtn1 || _clickBtn == nil) {
                    _clickBtn.selected = NO;
                    [_clickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    _clickBtn.backgroundColor = [UIColor whiteColor];
                    weekBtn1.selected = YES;
                    [weekBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    weekBtn1.backgroundColor = [UIColor colorWithRed:250/255.0 green:165/255.0 blue:69/255.0 alpha:1];
                    [_titleButton setTitle:[NSString stringWithFormat:@"%@",weekBtn1.titleLabel.text] forState:UIControlStateNormal];
                    _clickBtn = weekBtn1;
                }
                [_titleButton setTitle:[NSString stringWithFormat:@"%@",weekBtn1.titleLabel.text] forState:UIControlStateNormal];
                if ([nowWeek integerValue] > 6 && [nowWeek integerValue] < 13) {
                    _weekScrollView.contentOffset = CGPointMake(0, _weekScrollView.frame.size.height/2);
                }
            }
        }
    } WithFailureBlock:^{
    }];
}

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

- (void)handleColor:(NSMutableArray *)courses {
    _colorArray = [[NSMutableArray alloc]initWithObjects:@"156,171,246",@"255,161,16",@"249,141,156",@"149,213,27",@"56,188,242",nil];
    NSMutableArray *courseArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < courses.count; i ++) {
        [courseArray addObject:[courses[i] objectForKey:@"course"]];
    }
    NSSet *courseSet = [NSSet setWithArray:courseArray];
    for (NSString *string in courseSet) {
        if (_colorArray.count == 0) {
            _colorArray = [[NSMutableArray alloc]initWithObjects:@"156,171,246",@"255,161,16",@"249,141,156",@"149,213,27",@"56,188,242",nil];
        }
        int j = arc4random()%_colorArray.count;
        for (int i = 0; i < courses.count; i ++) {
            if ([string isEqualToString:[NSString stringWithFormat:@"%@",[courses[i] objectForKey:@"course"]]]) {
                [courses[i] setObject:_colorArray[j] forKey:@"color"];
            }
        }
        [_colorArray removeObject:_colorArray[j]];
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
                courseButton.backgroundColor = [self handleRandomColorStr:course.color];
                [courseButton addTarget:self action:@selector(courseClick:) forControlEvents:UIControlEventTouchUpInside];
                [_mainScrollView addSubview:courseButton];
                currentTag = courseButton.tag;
            }
            currentBegin = rowNum;
            currentDay = colNum;
        }
    }
}

#pragma mark - 私有方法
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
- (void)viewCourseWithTag:(NSInteger )starTag endTag:(NSInteger)endTag {
    _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.7;
    UIButton *backgroundViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backgroundViewBtn.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [backgroundViewBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:backgroundViewBtn];
    [[[UIApplication sharedApplication]keyWindow]addSubview:_backgroundView];
    
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/9, ScreenHeight/7, ScreenWidth/9*7, ScreenHeight/7*5)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 1.0;
    [[[UIApplication sharedApplication]keyWindow]addSubview:_alertView];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth/9*7-20, 40)];
    infoLabel.text = @"课程详细信息";
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.font = [UIFont systemFontOfSize:24];
    infoLabel.textColor = MAIN_COLOR;
    [_alertView addSubview:infoLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth/9*7, 2)];
    lineView.backgroundColor = MAIN_COLOR;
    [_alertView addSubview:lineView];
    
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(10, ScreenHeight-ScreenHeight/7*2-50, ScreenWidth/9*7-20, 45)];
    done.layer.cornerRadius = 2.0;
    [done setTitle:@"确认" forState:UIControlStateNormal];
    done.backgroundColor = MAIN_COLOR;
    done.titleLabel.textAlignment = NSTextAlignmentCenter;
    [done addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:done];
    
    UIScrollView *courseScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 65, ScreenWidth/9*7-30, ScreenHeight/7*5-75-65)];
    courseScroll.pagingEnabled = true;
    courseScroll.showsHorizontalScrollIndicator = NO;
    courseScroll.contentSize = CGSizeMake((ScreenWidth/9*7-30)*(endTag-starTag+1), ScreenHeight/7*5-75-65);
    courseScroll.delegate = self;
    [_alertView addSubview:courseScroll];
    
    _page = [[UIPageControl alloc]initWithFrame:CGRectZero];
    _page.center = CGPointMake(_alertView.frame.size.width/2, ScreenHeight-ScreenHeight/7*2-60);
    _page.numberOfPages = endTag-starTag+1;
    _page.currentPage = 0;
    _page.backgroundColor = [UIColor blueColor];
    [_page setCurrentPageIndicatorTintColor:MAIN_COLOR];
    [_page setPageIndicatorTintColor:[UIColor grayColor]];
    [_alertView addSubview:_page];
    
    CGFloat indexX = 0;
    for (NSInteger i=starTag; i<=endTag; i++) {
        NSDictionary *dataDic = _dataArray[i];
        CourseView *courseView = [[CourseView alloc]initWithFrame:CGRectMake(indexX, 0, ScreenWidth/9*7-30, ScreenHeight/7*5-75-65) withDictionary:dataDic];
        [courseScroll addSubview:courseView];
        indexX += courseScroll.contentSize.width/(endTag-starTag+1);
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat distance = scrollView.contentOffset.x;
    CGFloat pageWith = scrollView.frame.size.width;
    int pageNum = floor((distance + pageWith/2)/pageWith);
    _page.currentPage = pageNum;
}

- (void)doneClick {
    [self.backgroundView removeFromSuperview];
    [self.alertView removeFromSuperview];
    [self.page removeFromSuperview];
}

- (void)showWeekList {
    if (_weekViewShow) {
        [_shadeView removeFromSuperview];
        [UIView animateWithDuration:0.3 animations:^{
            _backView.frame = CGRectMake(0, -ScreenHeight/2, _backView.frame.size.width, _backView.frame.size.height);
        } completion:nil];
        _tagView.transform = CGAffineTransformMakeRotation(0);
        _weekViewShow = NO;
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            _backView.frame = CGRectMake(0, 64, _backView.frame.size.width, _backView.frame.size.height);
        } completion:^(BOOL finished) {
            _shadeView.frame = CGRectMake(0, _backView.frame.size.height+64, ScreenWidth, ScreenHeight);
            [[[UIApplication sharedApplication]keyWindow]addSubview:_shadeView];
        }];
        _tagView.transform = CGAffineTransformMakeRotation(M_PI);
        _weekViewShow = YES;
        
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
    if (sender.tag >= 0 && sender.tag <= 10) {
        _tagView.center = CGPointMake(ScreenWidth/2+37, _nav.frame.size.height/2+10);
    }else if (sender.tag > 10 && sender.tag < 19) {
        _tagView.center = CGPointMake(ScreenWidth/2+45, _nav.frame.size.height/2+10);
    }
    
    if (_clickBtn == nil) {
        sender.selected = YES;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor colorWithRed:250/255.0 green:165/255.0 blue:69/255.0 alpha:1];
        [_titleButton setTitle:[NSString stringWithFormat:@"%@",sender.titleLabel.text] forState:UIControlStateNormal];
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
        _clickBtn = sender;
    }
    _dataArray = [self getWeekCourseArray:sender.tag];
    [self handleData:_dataArray];
    [self showWeekList];
}

- (void)clickShadeView {
    [_shadeView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _backView.frame = CGRectMake(0, -ScreenHeight/2, _backView.frame.size.width, _backView.frame.size.height);
    } completion:nil];
    _tagView.transform = CGAffineTransformMakeRotation(0);
    _weekViewShow = NO;
}

- (NSMutableArray *)getWeekCourseArray:(NSInteger)week {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    _dataArray = [userDefault objectForKey:@"dataArray"];
    _weekDataArray = [userDefault objectForKey:@"weekDataArray"];
    NSMutableArray *weekCourseArray = [NSMutableArray array];
    if (week == 0) {
        weekCourseArray = [NSMutableArray arrayWithArray:_dataArray];
    }else {
        for (int i = 0; i < _weekDataArray.count; i ++) {
            if ([_weekDataArray[i][@"week"] containsObject:[NSNumber numberWithInteger:week]]) {
                NSMutableDictionary *weekDataDic = [[NSMutableDictionary alloc]initWithDictionary:_weekDataArray[i]];
                [weekCourseArray addObject:weekDataDic];
            }
        }
        [self handleColor:weekCourseArray];
    }
    
    
    return weekCourseArray;
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
        }else if(point1.y > 0){
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

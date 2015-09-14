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
#import "UPStackMenu.h"
//#import "UPStackMenuItem.h"
#import "LoginViewController.h"
#import "ProgressHUD.h"

@interface CourseViewController ()<UIScrollViewDelegate,UPStackMenuItemDelegate,UPStackMenuDelegate>
@end

@implementation CourseViewController

static const CGFloat AniTime = 0.4;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    _dataArray = [userDefault objectForKey:@"dataArray"];
    [self handleWeek:_dataArray];
    [self loadNetData];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initView {
    self.navigationController.navigationBar.barTintColor = MAIN_COLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    _registRepeatClassSet = [[NSMutableSet alloc] init];
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 49)];
    [self.view addSubview:_mainView];
    
    UIView *dayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    dayView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [_mainView addSubview:dayView];
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, ScreenWidth, _mainView.frame.size.height - 30)];
    
    for (int i = 0; i < 7; i ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((i+0.5)*kWidthGrid, 0, kWidthGrid-2, kWidthGrid*12-2)];
        NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
        NSInteger weekDay = [componets weekday];
        if (i == weekDay - 2) {
            view.backgroundColor = [UIColor colorWithRed:253/255.0 green:251/255.0 blue:234/255.0 alpha:1];
        }

        [_mainScrollView addSubview:view];
    }
    
    NSArray *array = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    for (int i = 0; i < 7; i ++) {
        UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake((i+0.5)*kWidthGrid, 1, kWidthGrid, 29)];
        dayLabel.text = [NSString stringWithFormat:@"%@",array[i]];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.textColor = MAIN_COLOR;
        NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
        NSInteger weekDay = [componets weekday];
        if (i == weekDay - 2) {
            dayLabel.textColor = [UIColor colorWithRed:255/255.0 green:152/255.0 blue:0/255.0 alpha:1];
            dayLabel.backgroundColor = [UIColor colorWithRed:253/255.0 green:251/255.0 blue:234/255.0 alpha:1];
        }
        [dayView addSubview:dayLabel];
    }
    
    _mainScrollView.contentSize = CGSizeMake(ScreenWidth, kWidthGrid * 12);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [_mainView addSubview:_mainScrollView];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    _weekLabel.center = CGPointMake(ScreenWidth/2, -25);
    NSString *week = [userDefaults objectForKey:@"nowWeek"];
    _weekLabel.text = [NSString stringWithFormat:@"第%@周",week];
    _weekLabel.textColor = [UIColor colorWithRed:3/255.0 green:169/255.0 blue:244/255.0 alpha:1];
    _weekLabel.textAlignment = NSTextAlignmentCenter;
    [_mainScrollView addSubview:_weekLabel];
    
    for (int i = 0; i < 12; i ++) {
        UILabel *classNum = [[UILabel alloc]initWithFrame:CGRectMake(0, i*kWidthGrid, kWidthGrid*0.5, kWidthGrid)];
        classNum.text = [NSString stringWithFormat:@"%d",i+1];
        classNum.textAlignment = NSTextAlignmentCenter;
        classNum.textColor = MAIN_COLOR;
        [_mainScrollView addSubview:classNum];
    }
    
    _moreMenu = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 60, ScreenHeight - 109, 45, 45)];
    _moreMenu.layer.cornerRadius = _moreMenu.frame.size.width/2;
    _moreMenu.layer.borderColor = [UIColor whiteColor].CGColor;
    _moreMenu.layer.borderWidth = 2;
    _moreMenu.image = [UIImage imageNamed:@"iconfont-more.png"];
    
    UPStackMenu *stack = [[UPStackMenu alloc] initWithContentView:_moreMenu];
    stack.clipsToBounds = YES;
    stack.delegate = self;
    
    [stack setAnimationType:UPStackMenuAnimationType_progressiveInverse];
    
    UPStackMenuItem *item = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-meixueqi.png"] highlightedImage:[UIImage imageNamed:@"iconfont-meixueqi.png"]  title:@""];
    [item setTitleColor:[UIColor redColor]];
    item.tag = 1;
    [stack addItem:item];
    
    UPStackMenuItem *item1 = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"iconfont_meizhou"] highlightedImage:[UIImage imageNamed:@"iconfont_meizhou"] title:@""];
    [stack addItem:item1];
    item1.tag = 2;
    [self.view addSubview:stack];
    item.delegate = self;
    item1.delegate = self;
    
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
}

- (void)didTouchStackMenuItem:(UPStackMenuItem *)item {
    for (int i = 0; i < _buttonTag.count; i ++) {
        [_buttonTag[i] removeFromSuperview];
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (item.tag == 1) {
        //查询学期课程
        NSArray *dataArray = [userDefault objectForKey:@"dataArray"];
        _dataArray = dataArray;
        [self handleWeek:dataArray];
    }else if (item.tag == 2) {
        //查询本周课程
        NSArray *weekDataArray = [userDefault objectForKey:@"weekDataArray"];
        _dataArray = weekDataArray;
        [self handleWeek:weekDataArray];
    }
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
        _dataArray = data;
        NSString *nowWeek = [returnValue objectForKey:@"nowWeek"];
        [_parameter setObject:nowWeek forKey:@"week"];
        [NetWork NetRequestPOSTWithRequestURL:Course_API WithParameter:_parameter WithReturnValeuBlock:^(id returnValue) {
            NSMutableArray *weekDataArray = [NSMutableArray arrayWithArray:[returnValue objectForKey:@"data"]];
            NSMutableArray *data = [NSMutableArray array];
            for (int i = 0;i < weekDataArray.count; i ++) {
                NSMutableDictionary *weekDataDic = [[NSMutableDictionary alloc]initWithDictionary:weekDataArray[i]];
                [weekDataDic setObject:@"" forKey:@"rawWeek"];
                [data addObject:weekDataDic];
            }
            _weekDataArray = data;
            [userDefault setObject:_weekDataArray forKey:@"weekDataArray"];
            [userDefault synchronize];
        } WithFailureBlock:nil];
        _weekLabel.text = [NSString stringWithFormat:@"第%@周",nowWeek];
        [userDefault setObject:nowWeek forKey:@"nowWeek"];
        [userDefault setObject:_dataArray forKey:@"dataArray"];
        [userDefault synchronize];
        for (int i = 0; i < _buttonTag.count; i ++) {
            [_buttonTag[i] removeFromSuperview];
        }
        [self handleWeek:_dataArray];
    } WithFailureBlock:^{
        NSLog(@"数据错误");
    }];
}

- (void)handleWeek:(NSArray *)array {
    NSMutableArray *allCourses = [NSMutableArray array];
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
            NSMutableDictionary *courseDic = [NSMutableDictionary dictionaryWithDictionary:array[i]];
            [courseDic setObject:weekNum forKey:@"day"];
            [allCourses addObject:courseDic];
        }
    }
    [self handleColor:allCourses];
}

- (void)handleColor:(NSMutableArray *)courses {
    _colorArray = [[NSMutableArray alloc]initWithObjects:@"229,28,35",@"233,30,99",@"156,39,175",@"103,58,183",@"63,81,181",@"86,119,252",@"3,169,244",@"0,188,212",@"0,150,136",@"37,150,36",@"139,195,74",@"205,220,57",@"29,233,182",@"255,193,7",@"255,152,0",@"255,87,34",@"224,64,251",@"255,109,0",@"61,90,254",@"213,0,249", nil];
//    _colorArray = [[NSMutableArray alloc]initWithObjects:@"255,161,16",@"56,188,242",@"149,213,27", nil];
    NSMutableArray *allCourses = [NSMutableArray array];
    NSMutableArray *courseArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < courses.count; i ++) {
        [courseArray addObject:[courses[i] objectForKey:@"course"]];
    }
    NSSet *courseSet = [NSSet setWithArray:courseArray];
    for (NSString *string in courseSet) {
        int j = arc4random()%_colorArray.count;
        for (int i = 0; i < courses.count; i ++) {
            if ([string isEqualToString:[NSString stringWithFormat:@"%@",[courses[i] objectForKey:@"course"]]]) {
                [courses[i] setObject:_colorArray[j] forKey:@"color"];
            }
        }
        [_colorArray removeObjectAtIndex:j];
    }
    for (int l = 0; l < courses.count; l ++) {
        Course *course = [[Course alloc]initWithPropertiesDictionary:courses[l]];
        [allCourses addObject:course];
    }
    [self handleData:allCourses];
}

- (void)handleData:(NSMutableArray *)courses {
    NSInteger currentTag = -1;
    _buttonTag = [NSMutableArray array];
    if (courses.count > 0) {
        int currentBegin = 0;
        int currentDay = 0;
        for (int i = 0; i<courses.count; i++) {
            Course *course = courses[i];
            int rowNum = course.begin_lesson.intValue - 1;
            int colNum = course.day.intValue;
            int period = course.period.intValue;
            
            if (rowNum == currentBegin && colNum == currentDay) {
                UIImageView *tagView = [[UIImageView alloc]initWithFrame:CGRectMake((colNum+0.5)*kWidthGrid-17, kWidthGrid*rowNum+kWidthGrid*period-17, 16, 16)];
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
        return RGBColor(red.floatValue, green.floatValue, blue.floatValue, 0.5);
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
    _backgroundView.backgroundColor = [UIColor grayColor];
    _backgroundView.alpha = 0.8;
    [[[UIApplication sharedApplication]keyWindow]addSubview:_backgroundView];
    
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/9, ScreenHeight/7, ScreenWidth/9*7, ScreenHeight/7*5)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 5.0;
    [[[UIApplication sharedApplication]keyWindow]addSubview:_alertView];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth/9*7-20, 40)];
    infoLabel.text = @"课程详细信息";
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.font = [UIFont systemFontOfSize:25];
    infoLabel.textColor = MAIN_COLOR;
    [_alertView addSubview:infoLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth/9*7, 2)];
    lineView.backgroundColor = MAIN_COLOR;
    [_alertView addSubview:lineView];
                                                                                                                                                                                                                                
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(10, ScreenHeight-ScreenHeight/7*2-50, ScreenWidth/9*7-20, 45)];
    done.layer.cornerRadius = 2.0;
    [done setTitle:@"确认" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
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

@end

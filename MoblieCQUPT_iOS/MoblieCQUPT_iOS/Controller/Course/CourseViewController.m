//
//  CourseViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/8/21.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "CourseViewController.h"

@interface CourseViewController ()

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self loadNetData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initView {
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 49)];
    [self.view addSubview:_mainView];
    UIView *dayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    [_mainView addSubview:dayView];
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, ScreenWidth, _mainView.frame.size.height - 30)];
    
    
    
    NSArray *array = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    for (int i = 0; i < 7; i ++) {
        UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake((i+0.5)*kWidthGrid, 0, kWidthGrid, 30)];
        dayLabel.text = [NSString stringWithFormat:@"%@",array[i]];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.textColor = [UIColor colorWithRed:3/255.0 green:164/255.0 blue:244/255.0 alpha:0.8];
        [dayView addSubview:dayLabel];
    }
    
    _mainScrollView.contentSize = CGSizeMake(ScreenWidth, 50 * 12);
    [_mainView addSubview:_mainScrollView];
    
    for (int i = 0; i < 12; i ++) {
        UILabel *classNum = [[UILabel alloc]initWithFrame:CGRectMake(0, i*50, kWidthGrid*0.5, 50)];
        classNum.text = [NSString stringWithFormat:@"%d",i+1];
        classNum.textAlignment = NSTextAlignmentCenter;
        classNum.textColor = [UIColor colorWithRed:3/255.0 green:164/255.0 blue:244/255.0 alpha:0.8];
        [_mainScrollView addSubview:classNum];
    }
    
    UIImageView *menu = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 60, ScreenHeight - 109, 50, 50)];
    menu.backgroundColor = [UIColor redColor];
    
    UPStackMenu *stack = [[UPStackMenu alloc] initWithContentView:menu];
    UPStackMenuItem *item = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-caidan.png"] highlightedImage:[UIImage imageNamed:@"iconfont-caidan-selected.png"] title:@"学期"];
    [item setTitleColor:[UIColor redColor]];
    item.tag = 1;
    [stack addItem:item];
    
    UPStackMenuItem *item1 = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-caidan.png"] highlightedImage:[UIImage imageNamed:@"iconfont-caidan-selected.png"] title:@"下一周"];
    [stack addItem:item1];
    item1.tag = 2;
    [self.view addSubview:stack];
    
    self.titleLabel.text = @"课表";
    self.tabBarController.tabBar.barTintColor = MAIN_COLOR;
    
    
}

- (void)didTouchStackMenuItem:(UPStackMenuItem *)item {
    
}

- (void)loadNetData {
    
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/kebiao" WithParameter:@{@"stuNum":@"2014213071"} WithReturnValeuBlock:^(id returnValue) {
//        NSArray *dataArray = [[NSArray alloc]init];
        _dataArray = [returnValue objectForKey:@"data"];
        [self handleWeek:_dataArray];
//        Course *course = [[Course alloc]initWithPropertiesDictionary:[returnValue objectForKey:@"data"][0]];
//        NSLog(@"%@",course.rawWeek);
        
        
        
    } WithFailureBlock:nil];
    
}

- (void)handleWeek:(NSArray *)array {
    NSMutableArray *allCourses =[NSMutableArray array];
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

            Course *course = [[Course alloc]initWithPropertiesDictionary:courseDic];
            [allCourses addObject:course];
        }
    }
    [self handleData:allCourses];
    
}

- (void)handleData:(NSMutableArray *)courses {
    if (courses.count > 0) {
        for (int i = 0; i<courses.count; i++) {
            Course *course = courses[i];
            int rowNum = course.begin_lesson.intValue - 1;
            int colNum = course.day.intValue;
            int period = course.period.intValue;
            
            CourseButton *courseButton = [[CourseButton alloc] initWithFrame:CGRectMake((colNum-0.5)*kWidthGrid, 50*rowNum, kWidthGrid, 50*period)];
            [courseButton setTitle:[NSString stringWithFormat:@"%@ @%@ %@",course.course,course.classroom,course.rawWeek]forState:UIControlStateNormal];
            courseButton.tag = i;
            int index = i%10;
            _colors = [[NSArray alloc] initWithObjects:@"9,155,43",@"251,136,71",@"163,77,140",@"32,81,148",@"255,170,0",@"4,155,151",@"38,101,252",@"234,51,36",@"107,177,39",@"245,51,119", nil];
            courseButton.backgroundColor = [self handleRandomColorStr:_colors[index]];
            [courseButton addTarget:self action:@selector(courseClick:) forControlEvents:UIControlEventTouchUpInside];
            [_mainScrollView addSubview:courseButton];
        }
    }
}

#pragma mark - 私有方法
//生成随机颜色
- (UIColor *)randomColor
{
    //    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    //    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    //    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    //    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    UIColor *color1 = RGBColor(9, 155, 43, 0.5);
    UIColor *color2 = RGBColor(251, 136, 71, 0.5);
    UIColor *color3 = RGBColor(163, 77, 140, 0.5);
    NSArray *array = [[NSArray alloc] initWithObjects:color1,color2,color3, nil];
    return [array objectAtIndex:arc4random()%3];
}

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
    NSInteger i = sender.tag;
    [self viewCourse:_dataArray[i]];
}
- (void)viewCourse:(NSMutableDictionary *)dataDic {
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"course"]] message:[NSString stringWithFormat:@"课时：%@\n老师：%@\n教室：%@",[dataDic objectForKey:@"lesson"],[dataDic objectForKey:@"teacher"],[dataDic objectForKey:@"classroom"]] delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
//    [alert show];
    _courseView = [[CourseView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    

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

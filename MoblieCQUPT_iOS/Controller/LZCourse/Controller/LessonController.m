//
//  LessonController.m
//  Demo
//
//  Created by 李展 on 2016/10/28.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "LessonController.h"
#import "PrefixHeader.pch"
#import "MainView.h"
#import "WeekScrollView.h"
#import "LessonButtonController.h"
#import "HttpClient.h"
#import "LessonHandle.h"
#import "DetailViewController.h"
#import "DetailRemindViewController.h"
#import "AddRemindViewController.h"
#import "CoverView.h"
#import <Masonry.h>
#define kAPPGroupID @"group.com.redrock.mobile"


@interface LessonController ()
@property MainView *mainView;
@property WeekScrollView *weekScrollView;
@property UIButton *barBtn;
@property NSMutableArray *dataArray;
@property NSMutableArray *remindArray;
@property NSMutableArray *examArray;
@property NSNumber *nowWeek;
@property NSMutableArray <LessonButtonController *> *controllerArray;
@property NSInteger selectedWeek;
@property UIImageView *noLessonImageView;
@property UIImageView *pullImageView;
@property CoverView *coverView;
@property DetailViewController *detailViewController;
@property AddRemindViewController *addRemindViewController;
@end

@implementation LessonController
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(reloadView) name:@"deleteRemind" object:nil];
    [center addObserver:self selector:@selector(reloadView) name:@"addRemind" object:nil];
    [center addObserver:self selector:@selector(reloadView) name:@"editRemind" object:nil];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"返回剪头"]];
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"返回剪头"]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
    backItem.title=@"";
    self.navigationItem.backBarButtonItem = backItem;
    
    [self initNavigationBar];
    [self initPullImageView];
    [self initWeekScrollView];
    [self initMainView];
    [self request];
    [self reTryRequest];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavigationBar{
    self.barBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, NVGBARHEIGHT*2, NVGBARHEIGHT)];
    [self.barBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.barBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.barBtn setTitle:@"本周" forState:UIControlStateNormal];
    [self.barBtn setTitleColor:[UIColor colorWithRed:64/255.f green:64/255.f blue:64/255.f alpha:1] forState:UIControlStateNormal];
    self.barBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//    self.navigationItem.titleView = self.barBtn;
    self.navigationItem.titleView = self.barBtn;
    //初始化点击Button
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(0, 0, NVGBARHEIGHT/2, NVGBARHEIGHT/2);
    [addBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    //初始化右边添加button
}


- (void)initMainView{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.dataArray = [[userDefaults objectForKey:@"lessonResponse"] objectForKey:@"data"];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *remindPath = [path stringByAppendingPathComponent:@"remind.plist"];
//    NSString *examPath = [path stringByAppendingString:@"exam.plist"];
    NSLog(@"%@",remindPath);
    self.remindArray = [NSMutableArray arrayWithContentsOfFile:remindPath];
//    self.examArray = [NSMutableArray arrayWithContentsOfFile:examPath];
    self.view.backgroundColor = [UIColor whiteColor];
    self.mainView = [[MainView alloc]initWithFrame:CGRectMake(0, STATUSBARHEIGHT+NVGBARHEIGHT, SCREENWIDTH, SCREENHEIGHT-STATUSBARHEIGHT-NVGBARHEIGHT-TABBARHEIGHT)];
    [self.view addSubview:self.mainView]; //初始化主界面
    [self initBtnController];
    for (NSDictionary *lessonDic in self.dataArray) {
        LessonMatter *lesson = [LessonHandle handle:lessonDic];
        NSInteger index = lesson.hash_day.integerValue*LONGLESSON+lesson.begin_lesson.integerValue/2;
        [self.controllerArray[index].matter.lessonArray addObject:lesson];
    }
    
    for (NSDictionary *remind in self.remindArray) {
        for (NSDictionary *date in [remind objectForKey:@"date"]) {
            RemindMatter *remindMatter = [[RemindMatter alloc]initWithRemind:remind];
            remindMatter.week = [date objectForKey:@"week"];
            remindMatter.classNum = [date objectForKey:@"class"];
            remindMatter.day = [date objectForKey:@"day"];
            NSInteger index = remindMatter.day.integerValue*LONGLESSON+remindMatter.classNum.integerValue;
            [self.controllerArray[index].matter.remindArray addObject:remindMatter];
        }
    }
    
    //    for (NSDictionary *exam in self.examArray) {
    //        ExamMatter *examMatter = [[ExamMatter alloc]init];
    //    }
    // 获取数据
    [self showMatterWithWeek:@(self.selectedWeek)];
    //初始化课程button
}


- (void)initWeekScrollView{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.nowWeek = [userDefaults objectForKey:@"nowWeek"];
    self.weekScrollView = [[WeekScrollView alloc]initWithFrame:CGRectMake(0, NVGBARHEIGHT+STATUSBARHEIGHT, SCREENWIDTH, SCREENHEIGHT/2.5)];
    self.weekScrollView.frame = CGRectMake(0, 0, SCREENWIDTH, 1);
    self.weekScrollView.backgroundColor = [UIColor whiteColor];
    self.weekScrollView.showWeekScrollView = NO;
    //初始化下拉周列表

    NSInteger count = self.weekScrollView.btnArray.count;
    for (NSInteger i = 0; i<count; i++) {
        self.weekScrollView.btnArray[i].tag = i;
        [self.weekScrollView.btnArray[i] addTarget:self action:@selector(clickWeek:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.weekScrollView.btnArray[self.nowWeek.integerValue] setTitle:@"本周" forState:UIControlStateNormal];
    self.selectedWeek = self.nowWeek.integerValue;
    self.weekScrollView.btnArray[self.selectedWeek].selected = YES;
    //初始化列表中的button
    
    self.coverView = [[CoverView alloc]initWithFrame:CGRectMake(0, NVGBARHEIGHT+STATUSBARHEIGHT, SCREENWIDTH, SCREENHEIGHT-(NVGBARHEIGHT+STATUSBARHEIGHT))];
    __weak LessonController *weakSelf = self;
    self.coverView.passTap = ^(NSSet *touches,UIEvent *event){
        [weakSelf touchesBegan:touches withEvent:event];
    }; //初始化遮罩
}

- (void)initBtnController{
    self.controllerArray = [[NSMutableArray alloc]initWithCapacity:(LONGLESSON*DAY)];
    for (int i = 0; i<DAY; i++) {
        for (int j = 0; j<LONGLESSON; j++) {
            self.controllerArray[i*LONGLESSON+j] = [[LessonButtonController alloc]initWithDay:i Lesson:j];
            [self.controllerArray[i*LONGLESSON+j].btn setTag:i*LONGLESSON+j];
            [self.controllerArray[i*LONGLESSON+j].btn addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)showMatterWithWeek:(NSNumber *)week{
    int lessonNum = 0;
    [self.noLessonImageView removeFromSuperview];
    for (LessonButtonController *controller in self.controllerArray) {
        [controller.view removeFromSuperview];
        if([controller matterWithWeek:week]){
            [self.mainView.scrollView addSubview:controller.view];
            lessonNum++;
        }
    }
    if (lessonNum == 0) {
        self.noLessonImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"无课"]];
        self.noLessonImageView.frame = CGRectMake(2*MWIDTH, SCREENHEIGHT/6, SCREENWIDTH-3*MWIDTH, SCREENWIDTH/2);
        [self.mainView.scrollView addSubview:self.noLessonImageView];
    }
}

- (void)request{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *stuNum = [defaults objectForKey:@"stuNum"];
    NSString *idNum = [defaults objectForKey:@"idNum"];
    stuNum = @"2015211572";
    idNum = @"200015";
//    if (stuNum==nil || idNum == nil) {
        [[NSUserDefaults standardUserDefaults]setObject:stuNum forKey:@"stuNum"];
        [[NSUserDefaults standardUserDefaults]setObject:idNum forKey:@"idNum"];
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *remindPath = [path stringByAppendingPathComponent:@"remind.plist"];
        //    NSString *examPath = [path stringByAppendingPathComponent:@"exam.plist"];
        HttpClient *client = [HttpClient defaultClient];
        NSDictionary *parameter = @{@"stuNum":stuNum};
        [client requestWithPath:kebiaoAPI method:HttpRequestPost parameters:parameter prepareExecute:nil progress:^(NSProgress *progress) {
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"%@",responseObject);
            [defaults setObject:[responseObject objectForKey:@"nowWeek"] forKey:@"nowWeek"];
            [defaults setObject:responseObject forKey:@"lessonResponse"];
            
            // 共享数据
            NSUserDefaults *shared = [[NSUserDefaults alloc]initWithSuiteName:kAPPGroupID];
            [shared setObject:responseObject forKey:@"lessonResponse"];
            [shared synchronize];
            //
            
            [self reloadView];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];
        
        [client requestWithPath:GETREMINDAPI method:HttpRequestPost parameters:@{@"stuNum":stuNum,@"idNum":idNum} prepareExecute:^{
            
        } progress:^(NSProgress *progress) {
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            NSMutableArray *reminds = [responseObject objectForKey:@"data"];
            if ([reminds writeToFile:remindPath atomically:YES]) {
                [self reloadView];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];
        //    [client requestWithPath:EXAMAPI method:HttpRequestPost parameters:@{@"stuNum":@"2015211572"}prepareExecute:^{
        //
        //    } progress:^(NSProgress *progress) {
        //
        //    } success:^(NSURLSessionDataTask *task, id responseObject) {
        ////        [[responseObject objectForKey:@"data"] writeToFile:examPath atomically:YES encoding:NSUTF16StringEncoding error:nil];
        //        NSLog(@"%@",responseObject);
        //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //        NSLog(@"%@",error);
        //    }];
//    }
}

- (void)reloadView{
    [self.mainView removeFromSuperview];
    [self.weekScrollView removeFromSuperview];
    [self initMainView];
    [self initWeekScrollView];
    [self.detailViewController reloadMatters:self.controllerArray[self.detailViewController.time].matter];
}

- (void)initPullImageView{
    self.pullImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"下拉"]];
    [self.barBtn addSubview:self.pullImageView];
    [self.pullImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.barBtn.titleLabel.mas_right).offset(5);
        make.centerY.equalTo(self.barBtn.titleLabel);
    }];
}

- (void)addAction{
    AddRemindViewController *vc = [[AddRemindViewController alloc]init];
    [self addChildViewController:vc];
    [self.navigationController pushViewController:vc animated:YES];
    [vc didMoveToParentViewController:self];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)clickWeek:(UIButton *)sender{
    [self.barBtn setTitle:sender.currentTitle forState:UIControlStateNormal];
    self.weekScrollView.btnArray[self.selectedWeek].selected = NO;
    self.selectedWeek = sender.tag;
    sender.selected = YES;
    
    if ([self.barBtn.currentTitle  isEqual: @"整学期"]) {
        [self.mainView removeDayLbTime];
        [self showMatterWithWeek:@0];
    }
    else{
        [self.mainView loadDayLbTimeWithWeek:sender.tag nowWeek:self.nowWeek.integerValue];
        [self showMatterWithWeek:@(sender.tag)];
    }
    [self clickBtn];
}

- (void)clickBtn{
    if (self.weekScrollView.showWeekScrollView) {
        self.pullImageView.image = [UIImage imageNamed:@"下拉"];
        [UIView animateWithDuration:0.3 animations:^{
            self.weekScrollView.frame = CGRectMake(0, 0, SCREENWIDTH, 1);
        }completion:^(BOOL finished) {
            [self.weekScrollView removeFromSuperview];
            [self.coverView removeFromSuperview];
            self.weekScrollView.showWeekScrollView = NO;
        }];
    }
    else{
        self.pullImageView.image = [UIImage imageNamed:@"上拉"];
        NSInteger initial = (self.selectedWeek-4)>0?(self.selectedWeek-4):0;
        [self.weekScrollView setContentOffset:CGPointMake(0, initial*self.weekScrollView.btnArray[self.selectedWeek].frame.size.height)];
        [self.view addSubview:self.coverView];
        [self.view addSubview:self.weekScrollView];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.weekScrollView.frame = CGRectMake(0, NVGBARHEIGHT+STATUSBARHEIGHT, SCREENWIDTH, SCREENHEIGHT/2.5);
        }completion:^(BOOL finished) {
            self.weekScrollView.showWeekScrollView = YES;
        }];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if([self.weekScrollView showWeekScrollView]){
        [self clickBtn];

    }
}

- (void)showDetail:(UIButton *)sender{
    self.tabBarController.tabBar.hidden = YES;
    self.detailViewController = [[DetailViewController alloc]initWithMatters:self.controllerArray[sender.tag].matter week:self.selectedWeek time:sender.tag];
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

- (void)reTryRequest{
     NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *failurePath = [path stringByAppendingPathComponent:@"failure.plist"];
    NSMutableArray *failureRequests = [NSMutableArray arrayWithContentsOfFile:failurePath];
    if (failureRequests.count == 0) {
        return;
    }
    else{
        NSDictionary *failure = failureRequests[0];
        NSString *type = [failure objectForKey:@"type"];
        NSMutableDictionary *parameters = [failure objectForKey:@"parameters"];
        NSError *error;
        NSArray *dateArray = [parameters objectForKey:@"date"];
        NSMutableDictionary *jsonParameters = [parameters mutableCopy];
        if (dateArray != nil) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dateArray options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            [jsonParameters setObject:jsonString forKey:@"date"];
        }
        NSMutableDictionary *realParameters;
        HttpClient *client = [HttpClient defaultClient];
        NSString *path = [NSString string];
        if ([type isEqualToString:@"edit"]) {
            path = EDITREMINDAPI;
            realParameters = jsonParameters;
        }
        else if([type isEqualToString:@"delete"]){
            path = DELETEREMINDAPI;
            realParameters = parameters;
        }
        else if([type isEqualToString:@"add"]){
            path = ADDREMINDAPI;
            realParameters = jsonParameters;
        }
        [client requestWithPath:path method:HttpRequestPost parameters:realParameters prepareExecute:^{
            
        } progress:^(NSProgress *progress) {
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            [failureRequests removeObject:failure];
            if ([failureRequests writeToFile:failurePath atomically:YES]) {
                [self reTryRequest];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
            return;
            
        }];
    }
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

//
//  LZNoCourseDateDetailViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/24.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZNoCourseDateDetailViewController.h"
#import "MainView.h"
#import "LZPersonModel.h"
#import "LessonMatter.h"
#import "LessonButton.h"
#import "LZWeekScrollView.h"
#import "UIFont+AdaptiveFont.h"
#import "LessonButtonViewModel.h"

@interface LZNoCourseDateDetailViewController ()<LZWeekScrollViewDelegate>
@property (nonatomic, strong) MainView *mainView;
@property (nonatomic, strong) LZWeekScrollView *weekScrollView;
@property (nonatomic, strong) UIButton *barBtn;
@property (nonatomic, strong) UIImageView *pullImageView;
@property (nonatomic, assign) CGFloat weekScrollViewHeight;
@property (nonatomic, strong) NSMutableArray <LZPersonModel *>*persons;
@property (nonatomic, copy) NSArray <LessonButton *>* lessonBtns;
@property (nonatomic, copy) NSArray <LessonButtonViewModel *> *btnModels;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, assign) BOOL isNetWorkSuccess;
@property (nonatomic, assign) NSInteger nowWeek;
@end

@implementation LZNoCourseDateDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText=@"loading";
    self.isNetWorkSuccess = YES;
    self.nowWeek = 0;
    self.weekScrollViewHeight = SCREEN_HEIGHT*0.06;
    [self getLessonsData];
    [self initNavigationBar];
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.weekScrollView];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithPersons:(NSArray<LZPersonModel *> *)persons{
    self = [self init];
    if (self) {
        self.persons = persons.mutableCopy;
    }
    return self;
}

- (void)initBtns{
    NSMutableArray *btns = [NSMutableArray array];
    for (int day = 0; day<DAY; day++) {
        for (int lesson = 0; lesson<LONGLESSON; lesson++) {
            LessonButton *btn = [[LessonButton alloc]initWithFrame:CGRectMake(MWIDTH+day*LESSONBTNSIDE+SEGMENT/2, lesson*LESSONBTNSIDE*2+SEGMENT/2, LESSONBTNSIDE-SEGMENT, LESSONBTNSIDE*2-SEGMENT)];
            [btns addObject:btn];
            [self.mainView.scrollView addSubview:btn];
            btn.hidden = YES;
        }
    }
    self.lessonBtns = btns;
}

- (MainView *)mainView{
    if (_mainView == nil) {
        _mainView = [[MainView alloc]initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-HEADERHEIGHT)];
        [self initBtns];
    }
    return _mainView;
}

- (LZWeekScrollView *)weekScrollView{
    if (_weekScrollView == nil) {
        NSMutableArray *weekArray = @[@"整学期",@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周",@"第九周",@"第十周",@"第十一周",@"第十二周",@"第十三周",@"第十四周",@"第十五周",@"第十六周",@"第十七周",@"第十八周",@"第十九周",@"第二十周"].mutableCopy;
        _nowWeek = [[UserDefaultTool valueWithKey:@"nowWeek"] integerValue] ?:_nowWeek;
        if (_nowWeek >0 && _nowWeek<=20) {
            weekArray[_nowWeek] = @"本周";
        }
        _weekScrollView = [[LZWeekScrollView alloc]initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREEN_WIDTH, _weekScrollViewHeight) andTitles:weekArray];
        _weekScrollView.eventDelegate = self;
        [self clickBtn];
        
    }
    return _weekScrollView;
}

- (void)initNavigationBar{
    self.barBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, NVGBARHEIGHT*2, NVGBARHEIGHT)];
    [self.barBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.barBtn setTitle:self.weekScrollView.currentIndexTitle forState:UIControlStateNormal];
    [self.barBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.barBtn.titleLabel.font = [UIFont adaptFontSize:18];
    self.navigationItem.titleView = self.barBtn;
    //初始化点击Button
    
    self.pullImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeTable_image_pull"]];
    [self.barBtn addSubview:self.pullImageView];
    [self.pullImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.barBtn.titleLabel.mas_right).offset(5);
        make.centerY.equalTo(self.barBtn.titleLabel);
    }];
    //初始化下拉箭头
}

- (void)clickBtn{
    if (!self.weekScrollView.hidden) {
        [UIView animateWithDuration:0.3 animations:^{
            self.pullImageView.transform = CGAffineTransformMakeScale(1.0,1.0);
            self.weekScrollView.frame = CGRectMake(0, HEADERHEIGHT, SCREEN_WIDTH, 0);
            self.mainView.frame = CGRectMake(0, HEADERHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-(HEADERHEIGHT));
        }completion:^(BOOL finished) {
            self.weekScrollView.hidden = YES;
        }];
    }
    else{
        [UIView animateWithDuration:0.3 animations:^{
            self.pullImageView.transform = CGAffineTransformMakeScale(1.0,-1.0);
            self.weekScrollView.frame = CGRectMake(0, HEADERHEIGHT, SCREEN_WIDTH, _weekScrollViewHeight);
            self.mainView.frame = CGRectMake(0, HEADERHEIGHT+_weekScrollViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-(HEADERHEIGHT+_weekScrollViewHeight));
            
        }completion:^(BOOL finished) {
            self.weekScrollView.hidden = NO;
        }];
    }
}

- (void)eventWhenTapAtIndex:(NSInteger)index{
    [self.barBtn setTitle:self.weekScrollView.titles[index] forState:UIControlStateNormal];
    [self showMatterWithWeek:index];
    [self clickBtn];
}

- (void)showMatterWithWeek:(NSInteger)week{
    [self.mainView loadDayLbTimeWithWeek:week nowWeek:self.nowWeek];
    for (int i = 0; i < self.lessonBtns.count; i++) {
        [self.btnModels[i] handleTitlesWithWeek:week];
        [self.lessonBtns[i] setTitle:self.btnModels[i].titles forState:UIControlStateNormal];
        [self.lessonBtns[i] setBackgroundColor:[UIColor colorWithHexString:self.btnModels[i].color]];
        self.lessonBtns[i].hidden = self.btnModels[i].isHidden;
    }
}

- (void)getLessonsData{
    HttpClient *client = [HttpClient defaultClient];
    dispatch_group_t group = dispatch_group_create();
    for (LZPersonModel *person in self.persons) {
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            [client requestWithPath:kebiaoAPI method:HttpRequestPost parameters:@{@"stuNum":person.stuNum} prepareExecute:^{
                
            } progress:^(NSProgress *progress) {
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                self.nowWeek = [responseObject[@"nowWeek"] integerValue];
                NSMutableArray *lessons = [NSMutableArray array];
                for (NSDictionary *dic in responseObject[@"data"]) {
                    LessonMatter *lesson = [[LessonMatter alloc] initWithLesson:dic];
                    [lessons addObject:lesson];
                }
                person.lessons = lessons;
                dispatch_semaphore_signal(semaphore);
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                self.isNetWorkSuccess = NO;
                dispatch_semaphore_signal(semaphore);
            }];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        });
    }
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"%@",self.persons);
        if (!self.isNetWorkSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.hud.mode = MBProgressHUDModeText;
                self.hud.labelText = @"网络错误";
                [self.hud hide:YES afterDelay:1];
            });
        }
        else{
            NSMutableArray *viewModels = [NSMutableArray array];
            for (int day = 0; day<DAY; day++) {
                for (int lesson = 0; lesson<LONGLESSON; lesson++) {
                    LessonButtonViewModel *viewModel = [[LessonButtonViewModel alloc]initWithPersons:self.persons day:day andBeginLesson:lesson];
                    [viewModels addObject:viewModel];
                }
            }
            self.btnModels = viewModels;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.hud hide:YES];
                [self.weekScrollView scrollToIndex:_nowWeek];
                
            });
        }
    });
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

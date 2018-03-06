 //
//  QueryViewController.m
//  MoblieCQUPT_iOS
//
//  Created by MaggieTang on 05/10/2017.
//  Copyright © 2017 Orange-W. All rights reserved.
//
#import "QueryHeader.h"
#import "QueryViewController.h"
#import "QueryTableViewCell.h"
#import "QueryLoginViewController.h"
#import "fourViewController.h"
#import "fiveViewController.h"
#import "sixViewController.h"
#import "sevenViewController.h"
#import "AllYearsViewController.h"
#import "MineViewController.h"
#import "HeaderGifRefresh.h"
#import "QueryDataModel.h"

@interface QueryViewController()<UIScrollViewDelegate>
@property QueryLoginViewController *queryLoginView;
@property UIScrollView *scrollView;
@property QueryHeader *headView;
@property (nonatomic, strong) UIButton *allYears;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) AllYearsViewController *allYearsVC;
@property (nonatomic, strong) sevenViewController *sevenVC;
@property (nonatomic, strong) sixViewController *sixVC;
@property (nonatomic, strong) fiveViewController *fiveVC;
@property (nonatomic, strong) fourViewController *fourVC;

@end

@implementation QueryViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    if (self.index) {
        [self changeScrollview:self.index];
        }
}

- (void)getVolunteerData{
    QueryDataModel *model = [[QueryDataModel alloc]initWithData:[UserDefaultTool valueWithKey:@"totalarray"]];
    NSString *uid = model.uid;
    NSString *hour = model.hour;
    NSArray *array = model.record;
    NSMutableArray *modelArray = [NSMutableArray array];
    NSMutableArray *modelArray1 = [NSMutableArray array];
    NSMutableArray *modelArray2 = [NSMutableArray array];
    NSMutableArray *modelArray3 = [NSMutableArray array];
    for (NSDictionary *data in array) {
        QueryModel *model = [[QueryModel alloc]initWithDic:data];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [formatter dateFromString:model.start_time];
        [formatter setDateFormat:@"yyyy"];
        NSInteger years = [[formatter stringFromDate:date]integerValue];
        NSString *year = [NSString stringWithFormat:@"%ld",(long)years];
        if ([year  isEqual: @"2017"]) {
            [modelArray addObject:model];
        }
        if ([year isEqual: @"2016"]) {
            [modelArray1 addObject:model];
        }
        if ([year isEqual: @"2015"]) {
            [modelArray2 addObject:model];
        }
        if ([year isEqual: @"2014"]) {
            [modelArray3 addObject:model];
        }
    }
    NSUserDefaults *hourDefault = [NSUserDefaults standardUserDefaults];
    [hourDefault setObject:hour forKey:@"totalhour"];
    [UserDefaultTool saveValue:uid forKey:@"uid"];
    self.array = [NSMutableArray arrayWithObjects:modelArray,modelArray1,modelArray2,modelArray3, nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getVolunteerData];
    self.navigationController.navigationBar.hidden = YES;
    UIImageView *toolBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,HEADERHEIGHT)];
    toolBarImageView.image = [UIImage imageNamed:@"toolbar_background"];
    [self.view addSubview:toolBarImageView];
    self.selectedIndex = 0;

    int heightH = (STATUSBARHEIGHT+HEADERHEIGHT/2)-(18.f/667)*MAIN_SCREEN_H;
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake((16.f/375)*MAIN_SCREEN_W,heightH,(10.f/375)*MAIN_SCREEN_W,(16.f/667)*MAIN_SCREEN_H)];
    [back addTarget:self action:@selector(buttonAction1) forControlEvents:UIControlEventTouchUpInside];
    [back setBackgroundImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    [self.view addSubview:back];
    
    int padding = (155.f/375)*MAIN_SCREEN_W;
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(padding, heightH, MAIN_SCREEN_W-padding*2, (19.f/667)*MAIN_SCREEN_H)];
    title.text = @"全部";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:18];
    title.textColor = [UIColor whiteColor];
    [self.view addSubview:title];
    
    //解除绑定button
    UIButton *removeBind = [[UIButton alloc]initWithFrame:CGRectMake((280.f/375)*MAIN_SCREEN_W,heightH,(84.f/375)*MAIN_SCREEN_W,(18.f/667)*MAIN_SCREEN_H)];
    [removeBind addTarget:self action:@selector(buttonActionRemove) forControlEvents:UIControlEventTouchUpInside];
    [removeBind setBackgroundColor:[UIColor clearColor]];
    [removeBind setTitle:@"解绑账号" forState:UIControlStateNormal];
    removeBind.titleLabel.font = [UIFont systemFontOfSize:14];
    removeBind.titleLabel.textAlignment = NSTextAlignmentCenter;
    [removeBind setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:removeBind];
    //全部展开button
    self.allYears = [[UIButton alloc]initWithFrame:CGRectMake(MAIN_SCREEN_W/2+(MAIN_SCREEN_W-padding*2)/2,heightH+6,(15.f/375)*MAIN_SCREEN_W,(8.f/667)*MAIN_SCREEN_H)];
    [self.allYears addTarget:self action:@selector(buttonActionUnfold) forControlEvents:UIControlEventTouchUpInside];
    [self.allYears setBackgroundImage:[UIImage imageNamed:@"展开后"] forState:UIControlStateNormal];
    [self.view addSubview:self.allYears];
    
    __weak typeof(self) weakSelf = self;
    self.view.backgroundColor=[UIColor whiteColor];
    _headView = [[QueryHeader alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 39)];
    NSDate  *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSInteger year=[components year];
    NSString *yearString = [NSString stringWithFormat:@"%ld",year];
    NSString *yearString1 = [NSString stringWithFormat:@"%ld",year-1];
    NSString *yearString2 = [NSString stringWithFormat:@"%ld",year-2];
    NSString *yearString3 = [NSString stringWithFormat:@"%ld",year-3];
    _headView.items = [NSArray arrayWithObjects:@"全部",yearString,yearString1,yearString2,yearString3, nil];;
    _headView.itemClickAtIndex = ^(NSInteger index){
    [weakSelf adjustScrollView:index];
        title.text = weakSelf.headView.items[index];
    };
        [self.view addSubview:_headView];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame),SCREENWIDTH,SCREENHEIGHT-CGRectGetMaxY(_headView.frame))];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*5, _scrollView.bounds.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:_scrollView];
    [self addViewControllsToScrollView];
    
}
- (void)buttonAction1{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"uid"]) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MineViewController class]]) {
                MineViewController *main =(MineViewController *)controller;
                [self.navigationController popToViewController:main animated:YES];
            }
        }
    }else{
        [self.navigationController popViewControllerAnimated:true];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[QueryLoginViewController class]]) {
            self.navigationController.viewControllers=@[self.navigationController.viewControllers[0],self];
        }
    }
}

- (void)buttonActionRemove{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"亲，真的要取消已经绑定的账号咩" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MineViewController class]]) {
                QueryLoginViewController *vc = [[QueryLoginViewController alloc]init];
                self.navigationController.viewControllers = @[self.navigationController.viewControllers[0],vc,self];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController popViewControllerAnimated:YES];
            }

            [userDefaults removeObjectForKey:@"uid"];
            [userDefaults synchronize];
        }
    }];
    [alertC addAction:cancel];
    [alertC addAction:confirm];
    [self presentViewController:alertC animated:YES completion:nil];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = round(self.scrollView.contentOffset.x / self.scrollView.bounds.size.width);
    if (self.selectedIndex != index) {
        [self.scrollView setContentOffset:CGPointMake(index*scrollView.bounds.size.width, 0) animated:YES];
        [_headView setSelectAtIndex:index];
        
        self.selectedIndex = index;

    }
}

- (void)addViewControllsToScrollView{
    UIColor *backgroundColor = [UIColor colorWithRed:244/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    self.allYearsVC = [[AllYearsViewController alloc]init];
    //self.allYearsVC .view.backgroundColor = backgroundColor;
    self.allYearsVC .view.frame = CGRectMake(0, 0, _scrollView.bounds.size.width,MAIN_SCREEN_H);
    self.allYearsVC.mutableArray = self.array;
    self.allYearsVC.tableView.mj_header = [HeaderGifRefresh headerWithRefreshingTarget:self refreshingAction:@selector(refresh:)];
    [_scrollView addSubview: self.allYearsVC.view];
    //self.scrollView.backgroundColor = backgroundColor;
    [self addChildViewController: self.allYearsVC];
    
    self.sevenVC = [[sevenViewController alloc]init];
    self.sevenVC.view.frame = CGRectMake(_scrollView.bounds.size.width*1, 0, _scrollView.bounds.size.width,MAIN_SCREEN_H);
    //self.sevenVC.view.backgroundColor = backgroundColor;
    self.sevenVC.mutableArray = self.array;
    self.sevenVC.tableView.mj_header = [HeaderGifRefresh headerWithRefreshingTarget:self refreshingAction:@selector(refresh:)];
    [_scrollView addSubview:self.sevenVC.view];
    [self addChildViewController:self.sevenVC];
    
    self.sixVC = [[sixViewController alloc]init];
    self.sixVC.view.frame = CGRectMake(_scrollView.bounds.size.width*2, 0, _scrollView.bounds.size.width, MAIN_SCREEN_H);
    //self.sixVC.view.backgroundColor = backgroundColor;
    self.sixVC.mutableArray = self.array;
    self.sixVC.tableView.mj_header = [HeaderGifRefresh headerWithRefreshingTarget:self refreshingAction:@selector(refresh:)];
    [_scrollView addSubview:self.sixVC.view];
    [self addChildViewController:self.sixVC];
    
    self.fiveVC = [[fiveViewController alloc]init];
    self.fiveVC.view.frame = CGRectMake(_scrollView.bounds.size.width*3, 0, _scrollView.bounds.size.width, MAIN_SCREEN_H);
    //self.fiveVC.view.backgroundColor = backgroundColor;
    self.fiveVC.mutableArray = self.array;
    self.fiveVC.tableView.mj_header = [HeaderGifRefresh headerWithRefreshingTarget:self refreshingAction:@selector(refresh:)];
    [_scrollView addSubview:self.fiveVC.view];
    [self addChildViewController:self.fiveVC];
    
    self.fourVC = [[fourViewController alloc]init];
    self.fourVC.view.frame = CGRectMake(_scrollView.bounds.size.width*4, 0, _scrollView.bounds.size.width,MAIN_SCREEN_H);
    //self.fourVC.view.backgroundColor = backgroundColor;
    self.fourVC.mutableArray = self.array;
    self.fourVC.tableView.mj_header = [HeaderGifRefresh headerWithRefreshingTarget:self refreshingAction:@selector(refresh:)];
    [_scrollView addSubview:self.fourVC.view];
    [self addChildViewController:self.fourVC];
}
- (void)adjustScrollView:(NSInteger)index{
    [UIView animateWithDuration:0.2 animations:^{
        _scrollView.contentOffset = CGPointMake(index*_scrollView.bounds.size.width, 0);
    }];
}
-(void)changeScrollview:(NSInteger)index{
    
    [UIView animateWithDuration:0.1f animations:^{
        _scrollView.contentOffset = CGPointMake(index*_scrollView.bounds.size.width, 0);
    }];
    
}
- (void)buttonActionUnfold{
    if (_headView.hidden) {
        _headView.hidden = NO;
        [UIView animateWithDuration:0.1f animations:^{
            self.allYears.transform = CGAffineTransformMakeScale(1, 1);
            _headView.frame = CGRectMake(0, 64, SCREENWIDTH, 39);
            _scrollView.frame = CGRectMake(0, 39+64, SCREENWIDTH, SCREENHEIGHT-64-39);
            self.allYearsVC.tableView.frame = CGRectMake(0, 0,MAIN_SCREEN_W, MAIN_SCREEN_H-64-39);
            self.sevenVC.tableView.frame = CGRectMake(0, 0,MAIN_SCREEN_W, MAIN_SCREEN_H-64-39);
            self.sixVC.tableView.frame = CGRectMake(0, 0,MAIN_SCREEN_W, MAIN_SCREEN_H-64-39);
            self.fiveVC.tableView.frame = CGRectMake(0, 0,MAIN_SCREEN_W, MAIN_SCREEN_H-64-39);
            self.fourVC.tableView.frame = CGRectMake(0, 0,MAIN_SCREEN_W, MAIN_SCREEN_H-64-39);
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
    [UIView animateWithDuration:0.1f animations:^{
        _headView.frame = CGRectMake(0, 64, SCREENWIDTH, 0);
        self.allYears.transform = CGAffineTransformMakeScale(1, -1);
        _scrollView.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64);
        self.allYearsVC.tableView.frame = CGRectMake(0, 0,MAIN_SCREEN_W, MAIN_SCREEN_H-64);
        self.sevenVC.tableView.frame = CGRectMake(0, 0,MAIN_SCREEN_W, MAIN_SCREEN_H-64);
        self.sixVC.tableView.frame = CGRectMake(0, 0,MAIN_SCREEN_W, MAIN_SCREEN_H-64);
        self.fiveVC.tableView.frame = CGRectMake(0, 0,MAIN_SCREEN_W, MAIN_SCREEN_H-64);
        self.fourVC.tableView.frame = CGRectMake(0, 0,MAIN_SCREEN_W, MAIN_SCREEN_H-64);

    }completion:^(BOOL finished) {
        _headView.hidden = YES;
    }];
    }
}

- (void)refresh:(MJRefreshGifHeader *)header{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.allYearsVC.tableView.mj_header endRefreshing];
        [self.sevenVC.tableView.mj_header endRefreshing];
        [self.sixVC.tableView.mj_header endRefreshing];
        [self.fiveVC.tableView.mj_header endRefreshing];
        [self.fourVC.tableView.mj_header endRefreshing];
            dispatch_async(dispatch_get_main_queue(), ^{
            NSUserDefaults *default1 = [NSUserDefaults standardUserDefaults];
            NSUserDefaults *default2 = [NSUserDefaults standardUserDefaults];
            NSString *account = [default1 objectForKey:@"account"];
            NSString *password = [default2 objectForKey:@"password"];
            NSString *urlString = @"https://wx.idsbllp.cn/servicerecord/login";
            NSDictionary *parameters = @{@"account":account,@"password":password};
            HttpClient *client = [HttpClient defaultClient];
            [client requestWithPath:urlString method:HttpRequestPost parameters:parameters prepareExecute:^{
                
            } progress:^(NSProgress *progress) {
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"请求成功%@",responseObject);
                [self getVolunteerData];
                [self.allYearsVC.tableView reloadData];
                [self.sevenVC.tableView reloadData];
                [self.sixVC.tableView reloadData];
                [self.fiveVC.tableView reloadData];
                [self.fourVC.tableView reloadData];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"请求失败%@",error);
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"您的网络状态不好哟" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"再试试" style:UIAlertActionStyleCancel handler:nil];
                [alertC addAction:cancel];
                [self presentViewController:alertC animated:YES completion:nil];
}];
        });
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

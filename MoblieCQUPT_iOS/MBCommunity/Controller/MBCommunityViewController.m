//
//  MBCommunityViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/3/31.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommunityViewController.h"
#import "MBCommunityModel.h"
#import "MBCommunity_ViewModel.h"
#import "MBSegmentedView.h"
#import "MBCommunityTableView.h"
#import "MBCommunityCellTableViewCell.h"
#import "TopicModel.h"

#import "MBCommuityDetailsViewController.h"
#import "MBReleaseViewController.h"
#import "LoginViewController.h"
#import "MyMessagesViewController.h"
#import "MJrefresh.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "MBCommunityHandle.h"
#import "BannerScrollView.h"

@interface MBCommunityViewController ()<UITableViewDataSource,UITableViewDelegate,MBCommunityCellEventDelegate>

@property (strong, nonatomic) MBSegmentedView *segmentView;

@property (strong, nonatomic) UIBarButtonItem *addButton;
@property (strong, nonatomic) NSMutableArray<MBCommunityTableView *> *tableViewArray;
@property (strong, nonatomic) NSMutableArray *indicatorViewArray;

@property (strong, nonatomic) NSMutableArray <NSDictionary *>* dataDicArray;
@property (strong, nonatomic) NSMutableArray <NSDictionary *>* parameterArray;
@property (strong, nonatomic) NSMutableArray <TopicModel *>*topicArray;
@property BOOL hasLoadedTopic;
@property BOOL hasLoadedDiscuss;
@property LoginViewController *loginViewController;
@property BannerScrollView *bannerScrollView;
@end

@implementation MBCommunityViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataDicArray = [NSMutableArray array];
    self.parameterArray = [NSMutableArray array];
    self.topicArray = [NSMutableArray array];
    for (int i = 0; i<3; i++) {
        [self.dataDicArray addObject:
         @{@"page":@0,
           @"viewModels":
               [NSMutableArray array]}];
        self.parameterArray[i] = self.dataDicArray[i].copy;
    }
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:FONT_COLOR};
    self.navigationItem.rightBarButtonItem = self.addButton;
    NSArray *segments = @[@"热门动态",@"哔哔叨叨",@"官方资讯"];
    _segmentView = [[MBSegmentedView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) withSegments:segments];
    [self setupTableView:segments];
    // block回调
    __weak typeof(self) weakSelf = self;
    _segmentView.clickSegmentBtnBlock = ^(UIButton *sender) {
        if(weakSelf.tableViewArray[sender.tag].hidden){
            NSLog(@"%ld正在请求数据\n",(long)sender.tag);
            [weakSelf request:sender.tag];
        }
    };
    //菊花
    _indicatorViewArray = [NSMutableArray array];
    for (int i = 0; i < segments.count; i ++) {
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.frame = CGRectMake(i*ScreenWidth, 0, ScreenWidth, _segmentView.backScrollView.frame.size.height);
        [_segmentView.backScrollView addSubview:indicatorView];
        [indicatorView startAnimating];
        [_indicatorViewArray addObject:indicatorView];
    }
    [self request:0];
    [self.view addSubview:_segmentView];
    
    
    
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"返回箭头"]];
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"返回箭头"]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
    backItem.title=@"";
    self.navigationItem.backBarButtonItem = backItem;
    
    // Do any additional setup after loading the view from its nib.
}

//当从详情界面返回时 重新刷新cell
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (int i = 0; i < self.tableViewArray.count; i ++) {
        [self.tableViewArray[i] reloadData];
    }
}

#pragma mark -

- (UIBarButtonItem *)addButton {
    if (!_addButton) {
        UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
        [add setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        add.frame = CGRectMake(0, 0, NVGBARHEIGHT/2, NVGBARHEIGHT/2);
        [add addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _addButton = [[UIBarButtonItem alloc]initWithCustomView:add];
    }
    
    return _addButton;
}

- (void)clickAddButton:(UIButton *) sender{
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    if (stuNum == nil) {
        [MBCommunityHandle noLogin:self handler:^(BOOL success) {
            if (success) {
                [self clickAddButton:sender];
            }
        }];
    }else{
        MBReleaseViewController *releaseVC = [[MBReleaseViewController alloc]init];
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:releaseVC];
        releaseVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController presentViewController:nvc animated:YES completion:nil];
    }
}


- (void)setupTableView:(NSArray *)segments {
    self.hasLoadedTopic = NO;
    self.hasLoadedDiscuss = NO;
    _tableViewArray = [NSMutableArray<MBCommunityTableView *> array];
    for (int i = 0; i < segments.count; i ++) {
        MBCommunityTableView *tableView = [[MBCommunityTableView alloc]initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, _segmentView.backScrollView.frame.size.height) style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tag = i;
        tableView.sectionHeaderHeight = 0;
        tableView.sectionFooterHeight = 0;
        tableView.tableStyle = segments[i];
        [_tableViewArray addObject:tableView];
        tableView.hidden = YES;
        [_segmentView.backScrollView addSubview:tableView];
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.parameterArray[i] =
            @{@"page":@0,
              @"viewModels":
                  [NSMutableArray array]};
            [self request:i];
        }];
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self request:i];
        }];
    }
}

#pragma mark - 请求网络数据

- (void)request:(NSInteger)type{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadNetDataWithType:type];
        //        NSLog(@"Request_1");
    });
    if (type==1) {
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //请求2
            [self getTopicData];
            //            NSLog(@"Request_2");
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //界面刷新
        if (type == 1) {
            if (self.hasLoadedTopic &&self.hasLoadedDiscuss) {
                UIActivityIndicatorView *indicatorView = self.indicatorViewArray[type];
                [indicatorView stopAnimating];
                self.tableViewArray[type].hidden = NO;
                
                [self.tableViewArray[type] reloadData];
                [self.tableViewArray[type].mj_header endRefreshing];
                [self.tableViewArray[type].mj_footer endRefreshing];
            }
        }
        else{
            if (!self.tableViewArray[type].hidden) {
                UIActivityIndicatorView *indicatorView = self.indicatorViewArray[type];
                [indicatorView stopAnimating];
                self.tableViewArray[type].hidden = NO;
                
                [self.tableViewArray[type] reloadData];
                [self.tableViewArray[type].mj_header endRefreshing];
                [self.tableViewArray[type].mj_footer endRefreshing];
            }
        }
     
    });
}

- (void)loadNetDataWithType:(NSInteger)type {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    //type 0 = 热门, 1 = 哔哔叨叨, 2 = 官方咨询)
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"]?:@"";
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"]?:@"";
    NSMutableDictionary *parameter =
    @{@"stuNum":stuNum,
      @"idNum":idNum,
      @"version":@(1.0)}.mutableCopy;
    [parameter setObject:self.parameterArray[type][@"page"] forKey:@"page"];
    NSMutableArray *viewModels = self.parameterArray[type][@"viewModels"];
    NSString *url = SEARCHHOTARTICLE_API;
    if (type == 1) {
        url = LISTARTICLE_API;
        [parameter setObject:@5 forKey:@"type_id"];
    }else if (type == 2) {
        url = LISTNEWS_API;
    }
    [NetWork NetRequestPOSTWithRequestURL:url WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        dispatch_semaphore_signal(sema);
        self.hasLoadedDiscuss = YES;
        NSMutableArray *dataArray = returnValue[@"data"];
        NSNumber *page = returnValue[@"page"];
        page = @(page.integerValue+1);
        for (int i=0; i<dataArray.count; i++) {
            MBCommunityModel *model = [[MBCommunityModel alloc]initWithDictionary:dataArray[i]];
            MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
            viewModel.model = model;
            [viewModels addObject:viewModel];
        }
        NSDictionary *dataDic = @{@"page":page,
                                  @"viewModels":viewModels};
        self.dataDicArray[type] = dataDic;
        self.parameterArray[type] = dataDic.copy;
        if (type!=1) {
            self.tableViewArray[type].hidden = NO;
        }
    } WithFailureBlock:^{
        NSLog(@"请求数据失败");
        dispatch_semaphore_signal(sema);
        self.parameterArray[type] = self.dataDicArray[type].copy;
        if (!self.tableViewArray[type].hidden) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"您的网络不给力!";
            [hud hide:YES afterDelay:1];
        }
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
}

- (void)getTopicData{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"]?:@"";
    [NetWork NetRequestPOSTWithRequestURL:TOPICLIST_API WithParameter:@{@"stuNum":stuNum,
                                                                        }
                     WithReturnValeuBlock:^(id returnValue) {
                         NSLog(@"%@",returnValue);
                         dispatch_semaphore_signal(sema);
                         self.hasLoadedTopic = YES;
                         self.topicArray = [NSMutableArray array];
                         NSMutableArray *dataArray = returnValue[@"data"];
                         for (NSDictionary *dic in dataArray) {
                             TopicModel *model = [[TopicModel alloc] initWithDic:dic];
                             [self.topicArray addObject:model];
                         }
                         self.bannerScrollView =[[BannerScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 130) andTopics:self.topicArray];
                     }
                         WithFailureBlock:^{
                             dispatch_semaphore_signal(sema);
                             if (!self.tableViewArray[1].hidden) {
                                 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                                 hud.mode = MBProgressHUDModeText;
                                 hud.labelText = @"您的网络不给力!";
                                 [hud hide:YES afterDelay:1];
                             }
                         }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

#pragma mark -UITableView

- (NSInteger)tableView:(MBCommunityTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(MBCommunityTableView *)tableView {
    if(tableView.tag==1){
        return [self.dataDicArray[tableView.tag][@"viewModels"] count]+1;
    }
    else{
        return  [self.dataDicArray[tableView.tag][@"viewModels"] count];
    }
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.section;
    if (tableView.tag==1) {
        if (index == 0) {
            return self.bannerScrollView.height;
        }
        return [self.dataDicArray[tableView.tag][@"viewModels"][index-1] cellHeight];
    }
    else{
        return [self.dataDicArray[tableView.tag][@"viewModels"][index] cellHeight];
    }
    
    
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(MBCommunityTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.section;
    MBCommunityCellTableViewCell *cell = [MBCommunityCellTableViewCell cellWithTableView:tableView type:MBCommunityViewCellSimple];
    MBCommunity_ViewModel *viewModel;
    if (tableView.tag==1) {
        if(index == 0){
            UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:self.bannerScrollView.frame];
            [cell addSubview:self.bannerScrollView];
            return cell;
        }
        viewModel = self.dataDicArray[tableView.tag][@"viewModels"][index-1];
    }
    else{
        viewModel = self.dataDicArray[tableView.tag][@"viewModels"][index];
    }
    
    if (tableView.tag == 2) {
        cell.headImageView.userInteractionEnabled = NO;
    }
    cell.eventDelegate = self;
    cell.clickSupportBtnBlock = [MBCommunityHandle clickSupportBtn:self];
    cell.subViewFrame = viewModel;
    return cell;
}

//点击cell的头像的代理方法
- (void)eventWhenclickHeadImageView:(MBCommunityModel *)model {
    MyMessagesViewController *myMeVc = [[MyMessagesViewController alloc]initWithLoadType:MessagesViewLoadTypeOther withCommunityModel:model];
    myMeVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myMeVc animated:YES];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.section;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MBCommuityDetailsViewController *d = [[MBCommuityDetailsViewController alloc]init];
    d.hidesBottomBarWhenPushed = YES;
    MBCommunity_ViewModel *viewModel;
    if (tableView.tag == 1) {
        viewModel = self.dataDicArray[tableView.tag][@"viewModels"][index-1];
        if (index == 0) {
            return;
        }
    }
    else{
        viewModel = self.dataDicArray[tableView.tag][@"viewModels"][index];
    }
    d.viewModel = viewModel;
    [self.navigationController pushViewController:d animated:YES];
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

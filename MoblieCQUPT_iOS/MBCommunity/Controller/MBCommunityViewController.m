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

#import "MBCommuityDetailsViewController.h"
#import "MBReleaseViewController.h"
#import "LoginViewController.h"
#import "MyMessagesViewController.h"
#import "MJrefresh.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "MBCommunityHandle.h"

@interface MBCommunityViewController ()<UITableViewDataSource,UITableViewDelegate,MBCommunityCellEventDelegate>

@property (strong, nonatomic) MBSegmentedView *segmentView;

@property (strong, nonatomic) UIBarButtonItem *addButton;
@property NSMutableArray <NSDictionary *>* dataDicArray;
@property (strong, nonatomic) NSMutableArray<MBCommunityTableView *> *tableViewArray;
@property (strong, nonatomic) NSMutableArray *indicatorViewArray;

@property (strong, nonatomic) NSMutableArray *parameterArray;
@property LoginViewController *loginViewController;
@end

@implementation MBCommunityViewController
bool hasLoadedArray[3];
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataDicArray = [NSMutableArray array];
    self.parameterArray = [NSMutableArray array];
    for (int i = 0; i<3; i++) {
        hasLoadedArray[i] = NO;
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
        [weakSelf segmentBtnClick:sender];
    };
    _segmentView.scrollViewBlock = ^(NSInteger index) {
        if (!hasLoadedArray[index]){
            [weakSelf loadNetDataWithType:index];
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
    [self loadNetDataWithType:0];
    [self.view addSubview:_segmentView];
    
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

- (void)segmentBtnClick:(UIButton *)sender {
    if (_segmentView.currentSelectBtn != sender) {
        sender.selected = YES;
        _segmentView.currentSelectBtn.selected = NO;
        _segmentView.currentSelectBtn = sender;
    }
    _segmentView.backScrollView.contentOffset = CGPointMake(sender.tag*ScreenWidth, 0);
    [UIView animateWithDuration:0.1 animations:^{
        self.segmentView.underLine.frame = CGRectMake(sender.frame.origin.x, self.segmentView.underLine.frame.origin.y, self.segmentView.underLine.frame.size.width, self.segmentView.underLine.frame.size.height);
    } completion:nil];
}

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
        __weak typeof(self) weakSelf = self;
        self.loginViewController.loginSuccessHandler = ^(BOOL success) {
            if (success) {
                [weakSelf clickAddButton:sender];
            }
        };
        [MBCommunityHandle noLogin:self];
    }else{
        MBReleaseViewController *releaseVC = [[MBReleaseViewController alloc]init];
        releaseVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController presentViewController:releaseVC animated:YES completion:nil];
    }

}


- (void)setupTableView:(NSArray *)segments {
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
            [self loadNetDataWithType:i];
        }];
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadNetDataWithType:i];
        }];
    }
}

#pragma mark - 请求网络数据

- (void)loadNetDataWithType:(NSInteger)type {
    //type 0 = 热门, 1 = 哔哔叨叨, 2 = 官方咨询)
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"]?:@"";
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"]?:@"";
    NSMutableDictionary *parameter =
    @{@"stuNum":stuNum,
      @"idNum":idNum,
      @"version":@(1.0)}.mutableCopy;
    MBCommunityTableView *tableView = self.tableViewArray[type];
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
        hasLoadedArray[type] = YES;
        NSNumber *page;
        NSMutableArray *dataArray = [NSMutableArray array];
        dataArray = returnValue[@"data"];
        page = returnValue[@"page"];
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
        UIActivityIndicatorView *indicatorView = self.indicatorViewArray[type];
        [indicatorView stopAnimating];
        tableView.hidden = NO;
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
        [tableView.mj_footer endRefreshing];
        
    } WithFailureBlock:^{
        NSLog(@"请求数据失败");
        if(hasLoadedArray[type]){
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"您的网络不给力!";
            [hud hide:YES afterDelay:1];
        }
        self.parameterArray[type] = self.dataDicArray[type].copy;
        [tableView.mj_header endRefreshing];
        [tableView.mj_footer endRefreshing];
    }];
}
#pragma mark -

- (NSInteger)tableView:(MBCommunityTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(MBCommunityTableView *)tableView {
    return [self.dataDicArray[tableView.tag][@"viewModels"] count];
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.section;
    return [self.dataDicArray[tableView.tag][@"viewModels"][index] cellHeight];

    
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (MBCommunityCellTableViewCell *)tableView:(MBCommunityTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.section;
    MBCommunityCellTableViewCell *cell = [MBCommunityCellTableViewCell cellWithTableView:tableView];
    MBCommunity_ViewModel *viewModel =self.dataDicArray[tableView.tag][@"viewModels"][index];
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MBCommuityDetailsViewController *d = [[MBCommuityDetailsViewController alloc]init];
    d.hidesBottomBarWhenPushed = YES;
    NSInteger index = indexPath.section;
    MBCommunity_ViewModel *viewModel = self.dataDicArray[tableView.tag][@"viewModels"][index];
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

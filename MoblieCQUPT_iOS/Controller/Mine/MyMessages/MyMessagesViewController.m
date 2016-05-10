//
//  MyMessagesViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/5/10.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MyMessagesViewController.h"
#import "MBCommunityCellTableViewCell.h"
#import "MBCommunityTableView.h"
#import "LoginEntry.h"
#import "MBCommunityModel.h"
#import "MBCommunity_ViewModel.h"
#import "MyMessagesTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+AFNetworking.h"
#import "MBCommunityModel.h"
#import "MBCommunity_ViewModel.h"
#import "MBCommuityDetailsViewController.h"
#import "MBProgressHUD.h"

#define SEARCHTREBDS_API @"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Article/searchtrends"

@interface MyMessagesViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) MBCommunityTableView *communityTableView;
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) NSMutableArray *allDataArray;
@property (strong, nonatomic) NSMutableDictionary *myInfoData;
@property (copy, nonatomic) NSString *currenSelectCellOfRow;
@property (copy, nonatomic) NSString *currenSelectCellOfTableView;
@property (assign, nonatomic) NSInteger flag;

@end

@implementation MyMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.communityTableView];
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    [self setupRefresh];
    _flag = 0;
    //请求个人信息
    __weak typeof(self) weakSelf = self;
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Person/search"
                            WithParameter:@{@"stuNum":stuNum, @"idNum":idNum}
                     WithReturnValeuBlock:^(id returnValue) {
                         _myInfoData = returnValue[@"data"];
                         [weakSelf.communityTableView reloadData];
                         [weakSelf loadNet];
                     } WithFailureBlock:^{
                         
                     }];
}

- (MBCommunityTableView *)communityTableView {
    if (!_communityTableView) {
        _communityTableView = [[MBCommunityTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _communityTableView.dataSource = self;
        _communityTableView.delegate = self;
        _communityTableView.sectionHeaderHeight = 0;
        _communityTableView.sectionFooterHeight = 0;
    }
    return _communityTableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_currenSelectCellOfRow) {
        NSInteger row = [self.currenSelectCellOfRow integerValue];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:row];
    
        [self.communityTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}
- (void)loadNet {
    _allDataArray = [NSMutableArray array];
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    NSString *size = @"15";
    NSString *stunum_other = stuNum;
    NSDictionary *parameter = @{@"stuNum":stuNum,
                                @"idNum":idNum,
                                @"page":[NSNumber numberWithInteger:_flag],
                                @"size":size,
                                @"stunum_other":stunum_other};
    __weak typeof(self) weakSelf = self;
    [NetWork NetRequestPOSTWithRequestURL:SEARCHTREBDS_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSArray *dataArray = returnValue[@"data"];
        NSLog(@"the :%@", returnValue);
        for (int i = 0; i < dataArray.count; i++) {
            MBCommunityModel *model = [[MBCommunityModel alloc]initWithDictionary:dataArray[i] withMBCommunityModelType:MBCommunityModelTypeListArticle];
            MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
            viewModel.model = model;
            [weakSelf.allDataArray addObject:viewModel];
            [weakSelf.communityTableView reloadData];
        }
    } WithFailureBlock:^{
        
    }];
}

#pragma mark - 分页加载
//集成刷新控件
- (void)setupRefresh
{
    NSLog(@"heheh");
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.communityTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.communityTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.communityTableView.headerPullToRefreshText = @"下拉即可刷新";
    self.communityTableView.headerReleaseToRefreshText = @"松开即可刷新";
    self.communityTableView.headerRefreshingText = @"正在刷新中";
    
    self.communityTableView.footerPullToRefreshText = @"上拉加载更多";
    self.communityTableView.footerReleaseToRefreshText = @"松开加载更多";
    self.communityTableView.footerRefreshingText = @"玩命加载中";
}

- (void)headerRereshing{
    _allDataArray = [NSMutableArray array];
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    NSString *size = @"15";
    NSString *stunum_other = stuNum;
    NSDictionary *parameter = @{@"stuNum":stuNum,
                                @"idNum":idNum,
                                @"page":[NSNumber numberWithInteger:_flag],
                                @"size":size,
                                @"stunum_other":stunum_other};
    __weak typeof(self) weakSelf = self;
    [NetWork NetRequestPOSTWithRequestURL:SEARCHTREBDS_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSArray *dataArray = returnValue[@"data"];
        NSLog(@"the :%@", returnValue);
        for (int i = 0; i < dataArray.count; i++) {
            MBCommunityModel *model = [[MBCommunityModel alloc]initWithDictionary:dataArray[i] withMBCommunityModelType:MBCommunityModelTypeListArticle];
            MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
            viewModel.model = model;
            [weakSelf.allDataArray addObject:viewModel];
            [weakSelf.communityTableView reloadData];
            [weakSelf.communityTableView headerEndRefreshing];
        }
    } WithFailureBlock:^{
        
    }];
}

- (void)footerRereshing{
    _flag += 1;
    _allDataArray = [NSMutableArray array];
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    NSString *size = @"15";
    NSString *stunum_other = stuNum;
    NSDictionary *parameter = @{@"stuNum":stuNum,
                                @"idNum":idNum,
                                @"page":[NSNumber numberWithInteger:_flag],
                                @"size":size,
                                @"stunum_other":stunum_other};
    __weak typeof(self) weakSelf = self;
    [NetWork NetRequestPOSTWithRequestURL:SEARCHTREBDS_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSArray *dataArray = returnValue[@"data"];
        NSLog(@"the :%@", returnValue);
        for (int i = 0; i < dataArray.count; i++) {
            MBCommunityModel *model = [[MBCommunityModel alloc]initWithDictionary:dataArray[i] withMBCommunityModelType:MBCommunityModelTypeListArticle];
            MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
            viewModel.model = model;
            [weakSelf.allDataArray addObject:viewModel];
            [weakSelf.communityTableView reloadData];
            [weakSelf.communityTableView footerEndRefreshing];
        }
    } WithFailureBlock:^{
        
    }];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(MBCommunityTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(MBCommunityTableView *)tableView{
    return self.allDataArray.count + 2;
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }else if (indexPath.section == 1) {
        return 50;
    }else {
        return ((MBCommunity_ViewModel *)self.allDataArray[indexPath.section - 2]).cellHeight;
    }
    
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 0.0001;
    }else if (section == 0 || section == 2){
        return 0.00001;
    }else {
        return 10;
    }
    
}

- (UITableViewCell *)tableView:(MBCommunityTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //加载个人信息cell
        MyMessagesTableViewCell *cell = [MyMessagesTableViewCell cellWithTableView:tableView];
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:_myInfoData[@"photo_thumbnail_src"]]];
        cell.nicknameLabel.text = _myInfoData[@"nickname"];
        cell.introductionLabel.text = _myInfoData[@"introduction"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"headViewCell"];
            
            UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
            head.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];

            UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 40)];
            back.backgroundColor = [UIColor whiteColor];
            
            UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
        
            headLabel.text = @"近期动态";
            headLabel.font = [UIFont systemFontOfSize:16];
            headLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
            [headLabel sizeToFit];
            headLabel.center = CGPointMake(10+headLabel.frame.size.width/2, back.frame.size.height/2);
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 39, ScreenWidth, 1)];
            line.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
            
            [back addSubview:headLabel];
            [back addSubview:line];
            [head addSubview:back];
            [cell.contentView addSubview:head];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else {
        MBCommunityCellTableViewCell *communityCell = [MBCommunityCellTableViewCell cellWithTableView:tableView];
        MBCommunity_ViewModel *viewModel = self.allDataArray[indexPath.section - 2];
        MBCommunityModel *model = [[MBCommunityModel alloc]init];
        model = viewModel.model;
        model.headImageView = self.myInfoData[@"photo_thumbnail_src"];
        model.IDLabel = [NSString stringWithFormat:@"%@",self.myInfoData[@"nickname"]];
        viewModel.model = model;
        communityCell.subViewFrame = viewModel;
        
        return communityCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//取消cell选中状态
    _currenSelectCellOfRow = [NSString stringWithFormat:@"%ld",indexPath.section];
    //查询文章内容
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    NSString *artcileID;
    if (indexPath.section > 1) {
        MBCommunityModel *model = ((MBCommunity_ViewModel *)self.allDataArray[indexPath.section - 2]).model;
        artcileID = model.articleID;
    }
    __weak typeof(self) weakSelf = self;
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Article/searchContent"
                            WithParameter:@{@"stuNum":stuNum, @"idNum":idNum, @"type_id":@5, @"article_id":artcileID}
                     WithReturnValeuBlock:^(id returnValue) {
                         NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[returnValue objectForKey:@"data"][0]];
                         [dic setObject:_myInfoData[@"nickname"] forKey:@"nickname"];
                         
                         MBCommunity_ViewModel *community_ViewModel = weakSelf.allDataArray[indexPath.section -2];
                         
                         MBCommuityDetailsViewController *commuityDetailsVC = [[MBCommuityDetailsViewController alloc]init];
                         commuityDetailsVC.viewModel = community_ViewModel;
                         NSLog(@" awdadawdawd%@", community_ViewModel.model);
                         [weakSelf.navigationController pushViewController:commuityDetailsVC animated:YES];
                     } WithFailureBlock:^{
                         MBProgressHUD *uploadProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                         uploadProgress.mode = MBProgressHUDModeText;
                         uploadProgress.labelText = @"网络状况不佳";
                         [uploadProgress hide:YES afterDelay:1];
                     }];
}
@end

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
#import "MJrefresh.h"


@interface MyMessagesViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (copy, nonatomic) NSString *stunum_other;//请求动态的学号

@property (assign, nonatomic) MessagesViewLoadType loadType;

@property (strong, nonatomic) MBCommunityTableView *communityTableView;
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) NSMutableArray *allDataArray;
@property (strong, nonatomic) NSMutableDictionary *myInfoData;
@property (copy, nonatomic) NSString *currenSelectCellOfRow;
@property (copy, nonatomic) NSString *flag;

@end

@implementation MyMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationItem.title = @"个人动态";
    [self.view addSubview:self.communityTableView];
    [self setupRefresh];
    _flag = @"0";
    //请求个人信息
    if (_loadType == MessagesViewLoadTypeSelf) {
        NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
        NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
        _stunum_other = stuNum;
        __weak typeof(self) weakSelf = self;
        [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Person/search"
                                WithParameter:@{@"stuNum":stuNum, @"idNum":idNum}
                         WithReturnValeuBlock:^(id returnValue) {
                             _myInfoData = returnValue[@"data"];
                             [weakSelf.communityTableView reloadData];
                             [weakSelf loadNet];
                         } WithFailureBlock:^{
                             
                         }];

    }else {
        if (self.model) {
            _stunum_other = self.model.stuNum;
        }else if (self.commentModel) {
            _stunum_other = self.commentModel.stuNum;
        }
        
         __weak typeof(self) weakSelf = self;
        [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Person/search"
                                WithParameter:@{@"stuNum":@"2014213071",
                                                @"idNum":@"040975",
                                                @"stunum_other":self.stunum_other}
                         WithReturnValeuBlock:^(id returnValue) {
                             _myInfoData = returnValue[@"data"];
                             [weakSelf.communityTableView reloadData];
                             [weakSelf loadNet];
                         } WithFailureBlock:^{
                             
                         }];
//        [self.communityTableView reloadData];
//        [self loadNet];
    }
}
- (instancetype)initWithLoadType:(MessagesViewLoadType)loadType withCommunityModel:(MBCommunityModel *)model {
    _model = model;
    return [self initWithLoadType:loadType];
}

- (instancetype)initWithLoadType:(MessagesViewLoadType)loadType withCommentModel:(MBCommentModel *)model {
    _commentModel = model;
    return [self initWithLoadType:loadType];
}

- (instancetype)initWithLoadType:(MessagesViewLoadType)loadType {
    if (self = [super init]) {
        _loadType = loadType;
    }
    return self;
}

//- (instancetype)initWithCommunityModel:(MBCommunityModel *)model {
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_currenSelectCellOfRow) {
        NSInteger row = [self.currenSelectCellOfRow integerValue];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:row];
        
        [self.communityTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}
- (void)loadNet {
    NSString *size = @"15";
    NSString *stunum_other = self.stunum_other;
    NSDictionary *parameter = @{@"page":_flag,
                                @"size":size,
                                @"stunum_other":stunum_other};
    __weak typeof(self) weakSelf = self;
    [NetWork NetRequestPOSTWithRequestURL:SEARCHTREBDS_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSArray *dataArray = returnValue[@"data"];
        weakSelf.allDataArray = [NSMutableArray array];
        for (int i = 0; i < dataArray.count; i++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataArray[i]];
            [dic setObject:dic[@"photo_src"] forKey:@"article_photo_src"];
            [dic setObject:dic[@"thumbnail_src"] forKey:@"article_thumbnail_src"];
            MBCommunityModel * communityModel= [[MBCommunityModel alloc] initWithDictionary:dic withMBCommunityModelType:MBCommunityModelTypeListArticle];
            communityModel.IDLabel = _myInfoData[@"nickname"];
            communityModel.headImageView =  _myInfoData[@"photo_thumbnail_src"];
            MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
            viewModel.model = communityModel;
            [weakSelf.allDataArray addObject:viewModel];
        }
        [weakSelf.communityTableView reloadData];
    } WithFailureBlock:^{
        
    }];
}

#pragma mark - 分页加载
//集成刷新控件
- (void)setupRefresh
{
    self.communityTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.communityTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];

}

- (void)headerRereshing{
    _flag = @"0";
    
    NSString *size = @"15";
    NSString *stunum_other = self.stunum_other;
    NSDictionary *parameter = @{@"page":_flag,
                                @"size":size,
                                @"stunum_other":stunum_other};
    __weak typeof(self) weakSelf = self;
    NSLog(@"上拉加载");
    [NetWork NetRequestPOSTWithRequestURL:SEARCHTREBDS_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSArray *dataArray = returnValue[@"data"];
        weakSelf.allDataArray = [NSMutableArray array];
        for (int i = 0; i < dataArray.count; i++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataArray[i]];
            [dic setObject:dic[@"photo_src"] forKey:@"article_photo_src"];
            [dic setObject:dic[@"thumbnail_src"] forKey:@"article_thumbnail_src"];
            MBCommunityModel * communityModel= [[MBCommunityModel alloc] initWithDictionary:dic withMBCommunityModelType:MBCommunityModelTypeListArticle];
            communityModel.IDLabel = _myInfoData[@"nickname"];
            communityModel.headImageView =  _myInfoData[@"photo_thumbnail_src"];
            MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
            viewModel.model = communityModel;
            [weakSelf.allDataArray addObject:viewModel];
        }
        [weakSelf.communityTableView reloadData];
        [weakSelf.communityTableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        NSLog(@"请求失败");
        [weakSelf.communityTableView.mj_header endRefreshing];
    }];
}

- (void)footerRereshing{
    _flag = [NSString stringWithFormat:@"%ld",(long)[_flag integerValue]+1];
    NSString *size = @"15";
    NSString *stunum_other = self.stunum_other;
    NSDictionary *parameter = @{@"page":_flag,
                                @"size":size,
                                @"stunum_other":stunum_other};
    __weak typeof(self) weakSelf = self;
    [NetWork NetRequestPOSTWithRequestURL:SEARCHTREBDS_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSArray *dataArray = returnValue[@"data"];
        for (int i = 0; i < dataArray.count; i++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataArray[i]];
            [dic setObject:dic[@"photo_src"] forKey:@"article_photo_src"];
            [dic setObject:dic[@"thumbnail_src"] forKey:@"article_thumbnail_src"];
            MBCommunityModel * communityModel= [[MBCommunityModel alloc] initWithDictionary:dic withMBCommunityModelType:MBCommunityModelTypeListArticle];
            communityModel.IDLabel = _myInfoData[@"nickname"];
            communityModel.headImageView =  _myInfoData[@"photo_thumbnail_src"];
            MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
            viewModel.model = communityModel;
            [weakSelf.allDataArray addObject:viewModel];
            
        }
        [weakSelf.communityTableView reloadData];
        [weakSelf.communityTableView.mj_footer endRefreshing];
    } WithFailureBlock:^{
        [weakSelf.communityTableView.mj_footer endRefreshing];
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
//        NSInteger se = indexPath.section;
        MBCommunityCellTableViewCell *communityCell = [MBCommunityCellTableViewCell cellWithTableView:tableView];
        MBCommunity_ViewModel *viewModel = _allDataArray[indexPath.section - 2];
//        MBCommunityModel *model = [[MBCommunityModel alloc]init];
//        model = viewModel.model;
//        model.headImageView = self.myInfoData[@"photo_thumbnail_src"];
//        model.IDLabel = [NSString stringWithFormat:@"%@",self.myInfoData[@"nickname"]];
//        viewModel.model = model;
        communityCell.subViewFrame = viewModel;
        communityCell.headImageView.userInteractionEnabled = NO;
        
        return communityCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//取消cell选中状态
    _currenSelectCellOfRow = [NSString stringWithFormat:@"%ld",indexPath.section];
    //查询文章内容
    NSString *artcileID;
    if (indexPath.section > 1) {
        MBCommunityModel *model = ((MBCommunity_ViewModel *)self.allDataArray[indexPath.section - 2]).model;
        artcileID = model.articleID;
    }
    __weak typeof(self) weakSelf = self;
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/NewArticle/searchContent"
                            WithParameter:@{@"type_id":@5, @"article_id":artcileID}
                     WithReturnValeuBlock:^(id returnValue) {
                         NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[returnValue objectForKey:@"data"][0]];
                         [dic setObject:_myInfoData[@"nickname"] forKey:@"nickname"];
                         [dic setObject:dic[@"photo_src"] forKey:@"article_photo_src"];
                         [dic setObject:dic[@"thumbnail_src"] forKey:@"article_thumbnail_src"];
                         MBCommunityModel * communityModel= [[MBCommunityModel alloc] initWithDictionary:dic withMBCommunityModelType:MBCommunityModelTypeListArticle];
                         communityModel.IDLabel = _myInfoData[@"nickname"];
                         communityModel.headImageView =  _myInfoData[@"photo_thumbnail_src"];
                         
                         MBCommunity_ViewModel *community_ViewModel = self.allDataArray[indexPath.section - 2];
                         community_ViewModel.model = communityModel;
                         MBCommuityDetailsViewController *commuityDetailsVC = [[MBCommuityDetailsViewController alloc]init];
                         commuityDetailsVC.viewModel = community_ViewModel;
                         
                         [weakSelf.navigationController pushViewController:commuityDetailsVC animated:YES];
                     } WithFailureBlock:^{
                         MBProgressHUD *uploadProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                         uploadProgress.mode = MBProgressHUDModeText;
                         uploadProgress.labelText = @"网络状况不佳";
                         [uploadProgress hide:YES afterDelay:1];
                     }];
}
@end

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
#import "MBCommunityHandle.h"




@interface MyMessagesViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (copy, nonatomic) NSString *stunum_other;//请求动态的学号
@property (assign, nonatomic) MessagesViewLoadType loadType;
@property (strong, nonatomic) MBCommunityTableView *communityTableView;
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) NSMutableArray *allDataArray;
@property (strong, nonatomic) NSMutableDictionary *myInfoData;
@property NSInteger flag;

@end

@implementation MyMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = YES;
//    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationItem.title = @"个人动态";
    [self.view addSubview:self.communityTableView];
    [self setupRefresh];
    [self getPersonalInfo];
    _flag = 0;
    self.allDataArray = [NSMutableArray array];
    //请求个人信息
}

- (void)viewWillAppear:(BOOL)animated{
    [self.communityTableView reloadData];
}

- (void)getPersonalInfo{
    NSString *stuNum = [UserDefaultTool getStuNum] ?:@"";
    NSString *idNum = [UserDefaultTool getIdNum]?:@"";
    if (self.loadType == MessagesViewLoadTypeOther) {
        _stunum_other = self.commentModel.stuNum?:self.model.user_id;
    }
    else{
        _stunum_other = stuNum;
    }
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Person/search" WithParameter:@{@"stuNum":stuNum, @"idNum":idNum,@"stunum_other":_stunum_other,@"version":@1.0}
                     WithReturnValeuBlock:^(id returnValue) {
                         _myInfoData = returnValue[@"data"];
                         [self.communityTableView reloadData];
                         [self loadNet];
                     } WithFailureBlock:^{
                         
                     }];
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

- (void)loadNet {
    NSString *stuNum = [UserDefaultTool getStuNum] ?:@"";
    NSDictionary *parameter = @{@"stuNum":stuNum,
                                @"page":@(_flag),
                                @"size":@"15",
                                @"stunum_other":self.stunum_other,
                                @"version":@1.0};
    [NetWork NetRequestPOSTWithRequestURL:SEARCHTREBDS_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSArray *dataArray = returnValue[@"data"];
        for (int i = 0; i < dataArray.count; i++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataArray[i]];
            [dic setObject:dic[@"photo_src"] forKey:@"article_photo_src"];
            [dic setObject:dic[@"thumbnail_src"] forKey:@"article_thumbnail_src"];
            if([UserDefaultTool getStuNum]){
                [dic setObject:_myInfoData[@"nickname"] forKey:@"nickname"];
                [dic setObject:_myInfoData[@"photo_thumbnail_src"] forKey:@"user_thumbnail_src"];
                [dic setObject:_myInfoData[@"photo_src"] forKey:@"user_photo_src"];
                [dic setObject:_myInfoData[@"photo_thumbnail_src"] forKey:@"photo_thumbnail_src"];
            }
            MBCommunityModel * communityModel= [[MBCommunityModel alloc] initWithDictionary:dic];
            MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
            viewModel.model = communityModel;
            [self.allDataArray addObject:viewModel];
        }
        [self.communityTableView reloadData];
        [self.communityTableView.mj_footer endRefreshing];
        [self.communityTableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        NSLog(@"请求失败");
        MBProgressHUD *uploadProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        uploadProgress.mode = MBProgressHUDModeText;
        uploadProgress.labelText = @"网络状况不佳";
        [uploadProgress hide:YES afterDelay:1];
        [self.communityTableView.mj_footer endRefreshing];
        [self.communityTableView.mj_header endRefreshing];
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
    _flag = 0;
    self.allDataArray = [NSMutableArray array];
    [self loadNet];
}

- (void)footerRereshing{
    _flag++;
    [self loadNet];
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
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:_myInfoData[@"photo_thumbnail_src"]] placeholderImage:[UIImage imageNamed:@"headImage.png"]];
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
        MBCommunityCellTableViewCell *cell = [MBCommunityCellTableViewCell cellWithTableView:tableView type:MBCommunityViewCellDetail];
        MBCommunity_ViewModel *viewModel = _allDataArray[indexPath.section - 2];
        cell.subViewFrame = viewModel;
        cell.headImageView.userInteractionEnabled = NO;
        cell.clickSupportBtnBlock = [MBCommunityHandle clickSupportBtn:self];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 1){
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//取消cell选中状态
    //查询文章内容
        MBCommunity_ViewModel *community_ViewModel = self.allDataArray[indexPath.section - 2];
        MBCommuityDetailsViewController *commuityDetailsVC = [[MBCommuityDetailsViewController alloc]init];
        commuityDetailsVC.viewModel = community_ViewModel;
        [self.navigationController pushViewController:commuityDetailsVC animated:YES];
    }
}
@end

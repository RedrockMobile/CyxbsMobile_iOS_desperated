//
//  AboutMeViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/3/31.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "AboutMeViewController.h"
#import "MJRefresh.h"
#import "LoginEntry.h"
#import "AboutMeTableViewCell.h"
#import "AboutMePraiseTableViewCell.h"
#import "ShopDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+AFNetworking.h"
#import "MBCommunityModel.h"
#import "MBCommunity_ViewModel.h"
#import "MBCommuityDetailsViewController.h"
#import "MBProgressHUD.h"


@interface AboutMeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;
@property (assign, nonatomic) NSInteger flag;
@property (strong, nonatomic) NSMutableArray *articleIdArray;
@property (strong, nonatomic) NSMutableArray *nickname;

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

    _flag = 0;
    
    [self setupRefresh];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


#pragma mark - 分页加载
//集成刷新控件
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉即可刷新";
    self.tableView.headerReleaseToRefreshText = @"松开即可刷新";
    self.tableView.headerRefreshingText = @"正在刷新中";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多";
    self.tableView.footerRefreshingText = @"玩命加载中";
}

- (void)headerRereshing{
    //获取已登录用户的账户信息
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Article/aboutme" WithParameter:@{@"page":@0, @"size":@15, @"stuNum":stuNum, @"idNum":idNum} WithReturnValeuBlock:^(id returnValue) {
        [_data removeAllObjects];
        
        [_data addObjectsFromArray:[returnValue objectForKey:@"data"]];
        // 刷新表格
        [self.tableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    } WithFailureBlock:^{
        UILabel *faileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        faileLable.text = @"哎呀！网络开小差了 T^T";
        faileLable.textColor = [UIColor blackColor];
        faileLable.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        faileLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:faileLable];
        [_tableView removeFromSuperview];
    }];
}

- (void)footerRereshing{
    _flag += 1;
    //获取已登录用户的账户信息
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Article/aboutme" WithParameter:@{@"page":[NSNumber numberWithInteger:_flag], @"size":@15, @"stuNum":stuNum, @"idNum":idNum} WithReturnValeuBlock:^(id returnValue) {

        [_data addObjectsFromArray:[returnValue objectForKey:@"data"]];
        // 刷新表格
        [self.tableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
        
    } WithFailureBlock:^{
        UILabel *faileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        faileLable.text = @"哎呀！网络开小差了 T^T";
        faileLable.textColor = [UIColor blackColor];
        faileLable.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        faileLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:faileLable];
        [_tableView removeFromSuperview];
    }];
}

//覆盖初始化方法
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H) style:UITableViewStyleGrouped];
        [self dataFlash];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        UINib *nib2 = [UINib nibWithNibName:@"AboutMePraiseTableViewCell" bundle:nil];
        [_tableView registerNib:nib2 forCellReuseIdentifier:@"praiseCell"];
        UINib *nib1 = [UINib nibWithNibName:@"AboutMeTableViewCell" bundle:nil];
        [_tableView registerNib:nib1 forCellReuseIdentifier:@"remarkCell"];
        
    }
    
    return _tableView;
}

- (void)dataFlash{
    //获取已登录用户的账户信息
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Article/aboutme"
                            WithParameter:@{@"page":@0, @"size":@15, @"stuNum":stuNum, @"idNum":idNum}
                     WithReturnValeuBlock:^(id returnValue) {
        
        _data = [[NSMutableArray alloc] init];
        [_data addObjectsFromArray:[returnValue objectForKey:@"data"]];
         
        //按顺序保存article_id
         _articleIdArray = [[NSMutableArray alloc] init];
         for (NSDictionary *dic1 in _data) {
             [_articleIdArray addObject:dic1[@"article_id"]];
         }
        
        //按顺序保存nickname
         _nickname = [[NSMutableArray alloc] init];
         for (NSDictionary *dic2 in _data) {
             [_nickname addObject:dic2[@"nickname"]];
         }
                         
        [_tableView reloadData];
        
    } WithFailureBlock:^{
        UILabel *failLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        failLabel.text = @"哎呀！网络开小差了 T^T";
        failLabel.textColor = [UIColor blackColor];
        failLabel.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        failLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:failLabel];
        [_tableView removeFromSuperview];
    }];
}

#pragma mark - TableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *typeString = _data[indexPath.section][@"type"];
    if ([typeString isEqualToString:@"praise"]) {
        return 140;
    } else {
        return 170;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 6;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//取消cell选中状态
    
    //查询文章内容
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    __weak typeof(self) weakSelf = self;
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Article/searchContent"
                            WithParameter:@{@"stuNum":stuNum, @"idNum":idNum, @"type_id":@5, @"article_id":_articleIdArray[indexPath.section]}
                     WithReturnValeuBlock:^(id returnValue) {
                         NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[returnValue objectForKey:@"data"][0]];
                         [dic setObject:_nickname[indexPath.section] forKey:@"nickname"];
                         [dic setObject:dic[@"photo_src"] forKey:@"article_photo_src"];
                         [dic setObject:dic[@"thumbnail_src"] forKey:@"article_thumbnail_src"];
                         MBCommunityModel * communityModel= [[MBCommunityModel alloc] initWithDictionary:dic withMBCommunityModelType:MBCommunityModelTypeListArticle];
                         communityModel.IDLabel = [LoginEntry getByUserdefaultWithKey:@"nickname"];
                         communityModel.headImageView = [LoginEntry getByUserdefaultWithKey:@"photo_src"];
                         
                         MBCommunity_ViewModel *community_ViewModel = [[MBCommunity_ViewModel alloc] init];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *typeString = _data[indexPath.section][@"type"];
    //判断是评论还是赞
    if ([typeString isEqualToString:@"remark"]) {
        
        AboutMeTableViewCell *remarkCell = [tableView dequeueReusableCellWithIdentifier:@"remarkCell"];
        if (!remarkCell) {
            remarkCell = [[AboutMeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"remarkCell"];
        }
        
        if (_data[indexPath.section][@"photo_src"]) {
            [remarkCell.avatar sd_setImageWithURL:[NSURL URLWithString:_data[indexPath.section][@"photo_src"]]];
            remarkCell.avatar.layer.masksToBounds = YES;
            remarkCell.avatar.layer.cornerRadius = remarkCell.avatar.frame.size.height/2;
        }
        
        if (![_data[indexPath.section][@"article_photo_src"] isEqualToString:@""]) {
            NSString *imageString1 = _data[indexPath.section][@"article_photo_src"];
            NSArray *imageNameArray1 = [imageString1 componentsSeparatedByString:@","];
            NSString *imageUrl1 = [NSString stringWithFormat:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/Public/photo/%@", imageNameArray1[0]];
            [remarkCell.articlePhoto sd_setImageWithURL:[NSURL URLWithString:imageUrl1] placeholderImage:[UIImage imageNamed:@"GMEmptyFolder.png"]];
        } else {
            remarkCell.articlePhotoWidth.constant = 0.1;
            [remarkCell setNeedsLayout];
            [remarkCell layoutIfNeeded];
        }
        
        remarkCell.nickName.text = _data[indexPath.section][@"nickname"];
        remarkCell.createdTime.text = _data[indexPath.section][@"created_time"];
        remarkCell.content.text = _data[indexPath.section][@"content"];
        remarkCell.articleContent.text = _data[indexPath.section][@"article_content"];
        
        return remarkCell;

    } else if ([typeString isEqualToString:@"praise"]){
        
        AboutMePraiseTableViewCell *praiseCell = [tableView dequeueReusableCellWithIdentifier:@"praiseCell"];
        if (!praiseCell) {
            praiseCell = [[AboutMePraiseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"praiseCell"];
        }
        
        if (![_data[indexPath.section][@"photo_src"] isEqualToString:@""]) {
            [praiseCell.avatar sd_setImageWithURL:[NSURL URLWithString:_data[indexPath.section][@"photo_src"]] placeholderImage:[UIImage imageNamed:@"headImage.png"]];
            praiseCell.avatar.layer.masksToBounds = YES;
            praiseCell.avatar.layer.cornerRadius = praiseCell.avatar.frame.size.height/2;
        } else {
            [praiseCell.avatar setImage:[UIImage imageNamed:@"headImage.png"]];
        }
        
        if (![_data[indexPath.section][@"article_photo_src"] isEqualToString:@""]) {
            NSString *imageString2 = _data[indexPath.section][@"article_photo_src"];
            NSArray *imageNameArray2 = [imageString2 componentsSeparatedByString:@","];
            NSString *imageUrl2 = [NSString stringWithFormat:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/Public/photo/%@", imageNameArray2[0]];
            [praiseCell.articlePhoto sd_setImageWithURL:[NSURL URLWithString:imageUrl2] placeholderImage:[UIImage imageNamed:@"GMEmptyFolder.png"]];
        } else {
            praiseCell.articlePhotoWidth.constant = 0.1;
            [praiseCell setNeedsLayout];
            [praiseCell layoutIfNeeded];
        }
        
        praiseCell.nickname.text = _data[indexPath.section][@"nickname"];
        praiseCell.createdTime.text = _data[indexPath.section][@"created_time"];
        praiseCell.articleContent.text = _data[indexPath.section][@"article_content"];
        return praiseCell;
    }
    return  nil;
}

@end

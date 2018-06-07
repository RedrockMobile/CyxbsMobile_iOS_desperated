//
//  AboutMeViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/3/31.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "AboutMeViewController.h"
#import "MJRefresh.h"
#import "AboutMeTableViewCell.h"
#import "AboutMePraiseTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+AFNetworking.h"
#import "MBCommuityDetailsViewController.h"
#import "MBProgressHUD.h"



@interface AboutMeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;
@property (assign, nonatomic) NSInteger flag;
@property (strong, nonatomic) NSMutableArray *articleIdArray;
@property (strong, nonatomic) NSMutableArray *nickname;
@property (strong, nonatomic) NSString *type;
@end

@implementation AboutMeViewController

- (instancetype)initViewType:(NSString *)type{
    if (self = [super init]) {
        _type = type;
        _flag = 0;
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self.view addSubview:self.tableView];
        [self setupRefresh];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - 分页加载
//集成刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)headerRereshing{
    //获取已登录用户的账户信息
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    [NetWork NetRequestPOSTWithRequestURL:@"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/aboutMe" WithParameter:@{@"page":@0, @"size":@15, @"stunum":@"2016210049", @"idnum":@"27001X",@"type":_type}
                     WithReturnValeuBlock:^(id returnValue) {
        [_data removeAllObjects];
        
        [_data addObjectsFromArray:[returnValue objectForKey:@"data"]];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.tableView.mj_header endRefreshing];
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
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    [NetWork NetRequestPOSTWithRequestURL:@"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/aboutMe" WithParameter:@{@"page":[NSNumber numberWithInteger:_flag], @"size":@15, @"stunum":@"2016210049", @"idnum":@"27001X",@"type":_type} WithReturnValeuBlock:^(id returnValue) {
        
        NSArray *newData = [returnValue objectForKey:@"data"];
        [_data addObjectsFromArray:newData];
        // 刷新表格
        if (newData.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }
        
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.view.height)  style:UITableViewStyleGrouped];
        [self dataFlash];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //sention间距
        _tableView.sectionHeaderHeight = 10;
        _tableView.sectionFooterHeight = 10;
        
        UINib *nib2 = [UINib nibWithNibName:@"AboutMePraiseTableViewCell" bundle:nil];
        [_tableView registerNib:nib2 forCellReuseIdentifier:@"praiseCell"];
        UINib *nib1 = [UINib nibWithNibName:@"AboutMeTableViewCell" bundle:nil];
        [_tableView registerNib:nib1 forCellReuseIdentifier:@"remarkCell"];
        self.tableView.estimatedRowHeight = 80.0f;
        self.tableView.rowHeight = UITableViewAutomaticDimension; 
    }
    
    return _tableView;
}

- (void)dataFlash{
    //获取已登录用户的账户信息
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    [NetWork NetRequestPOSTWithRequestURL:@"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/aboutMe"
                            WithParameter:@{@"page":@0, @"size":@15, @"stunum":@"2016210049", @"idnum":@"27001X",
                                @"type":_type}
                     WithReturnValeuBlock:^(id returnValue) {
        
        _data = [[NSMutableArray alloc] init];
        [_data addObjectsFromArray:[returnValue objectForKey:@"data"]];
         
        //按顺序保存article_id
         _articleIdArray = [[NSMutableArray alloc] init];
         for (NSDictionary *dic1 in _data) {
             [_articleIdArray addObject:dic1[@"question_id"]];
         }
        
        //按顺序保存nickname
         _nickname = [[NSMutableArray alloc] init];
         for (NSDictionary *dic2 in _data) {
             [_nickname addObject:dic2[@"nickname"]];
         }
             self.tableView.mj_footer.hidden = NO;
                         
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
    if ([typeString isEqualToString:@"1"]) {
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
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    __weak typeof(self) weakSelf = self;
    [NetWork NetRequestPOSTWithRequestURL:@"https://wx.idsbllp.cn/cyxbsMobile/index.php/Home/NewArticle/searchContent"
                            WithParameter:@{@"stunum":stuNum,
                                @"idnum":idNum,@"type":@1, @"article_id":_articleIdArray[indexPath.section],}
                     WithReturnValeuBlock:^(id returnValue) {
                         NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[returnValue objectForKey:@"data"][0]];
                         [dic setObject:_nickname[indexPath.section] forKey:@"nickname"];
                         [dic setObject:dic[@"photo_src"] forKey:@"photo_src"];
                         [dic setObject:dic[@"thumbnail_src"] forKey:@"photo_thumbnail_src"];
                         MBCommunityModel * communityModel= [[MBCommunityModel alloc] initWithDictionary:dic];
                         communityModel.nickname = [UserDefaultTool valueWithKey:@"nickname"];
                         communityModel.user_photo_src = [UserDefaultTool valueWithKey:@"photo_src"];
                         
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
    if ([typeString isEqualToString:@"1"]) {

        AboutMeTableViewCell *remarkCell = [tableView dequeueReusableCellWithIdentifier:@"remarkCell"];
        if (!remarkCell) {
            remarkCell = [[AboutMeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"remarkCell"];
        }
        
        if (_data[indexPath.section][@"photo_thumbnail_src"]) {
            [remarkCell.avatar sd_setImageWithURL:[NSURL URLWithString:_data[indexPath.section][@"photo_thumbnail_src"]]];
            remarkCell.avatar.layer.masksToBounds = YES;
            remarkCell.avatar.layer.cornerRadius = remarkCell.avatar.frame.size.height/2;
        }
        
        if (![_data[indexPath.section][@"photo_src"] isEqualToString:@""]) {
            NSString *imageString1 = _data[indexPath.section][@"photo_src"];
            [remarkCell.articlePhoto sd_setImageWithURL:[NSURL URLWithString:imageString1] placeholderImage:[UIImage imageNamed:@"GMEmptyFolder.png"]];
        } else {
            remarkCell.articlePhotoWidth.constant = 0.1;
            [remarkCell setNeedsLayout];
            [remarkCell layoutIfNeeded];
        }
        
        remarkCell.nickName.text = _data[indexPath.section][@"nickname"];
        remarkCell.createdTime.text = _data[indexPath.section][@"created_at"];
        remarkCell.content.text = _data[indexPath.section][@"content"];
        remarkCell.articleContent.text = _data[indexPath.section][@"answer_content"];
        
        return remarkCell;
        //2是点赞
    } else if ([typeString isEqualToString:@"2"]){
        AboutMePraiseTableViewCell *praiseCell = [tableView dequeueReusableCellWithIdentifier:@"praiseCell"];
        if (!praiseCell) {
            praiseCell = [[AboutMePraiseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"praiseCell"];
        }

        if (![_data[indexPath.section][@"photo_thumbnail_src"] isEqualToString:@""]) {
            [praiseCell.avatar sd_setImageWithURL:[NSURL URLWithString:_data[indexPath.section][@"photo_thumbnail_src"]] placeholderImage:[UIImage imageNamed:@"headImage.png"]];
            praiseCell.avatar.layer.masksToBounds = YES;
            praiseCell.avatar.layer.cornerRadius = praiseCell.avatar.frame.size.height/2;
        } else {
            [praiseCell.avatar setImage:[UIImage imageNamed:@"headImage.png"]];
        }

        if (![_data[indexPath.section][@"photo_src"] isEqualToString:@""]) {
            NSString *imageString2 = _data[indexPath.section][@"photo_src"];
            [praiseCell.articlePhoto sd_setImageWithURL:[NSURL URLWithString:imageString2] placeholderImage:[UIImage imageNamed:@"GMEmptyFolder.png"]];
        } else {
            praiseCell.articlePhotoWidth.constant = 0.1;
            [praiseCell setNeedsLayout];
            [praiseCell layoutIfNeeded];
        }

        praiseCell.nickname.text = _data[indexPath.section][@"nickname"];
        praiseCell.createdTime.text = _data[indexPath.section][@"created_at"];
        praiseCell.articleContent.text = _data[indexPath.section][@"content"];
        return praiseCell;
    }
    return  nil;
}

@end

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

@interface MBCommunityViewController ()<UITableViewDataSource,UITableViewDelegate,MBCommunityCellEventDelegate>

@property (strong, nonatomic) MBSegmentedView *segmentView;

@property (strong, nonatomic) UIBarButtonItem *addButton;
@property NSMutableArray <NSDictionary *>* dataDicArray;
@property (strong, nonatomic) NSMutableArray<MBCommunityTableView *> *tableViewArray;
@property (strong, nonatomic) NSMutableArray *indicatorViewArray;
@property (strong, nonatomic) NSDictionary *tempDic;

//@property (copy, nonatomic) NSString *currenSelectCellOfRow;
//@property (copy, nonatomic) NSString *currenSelectCellOfTableView;

@end

@implementation MBCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataDicArray = [NSMutableArray array];
    for (int i = 0; i<3; i++) {
        [self.dataDicArray addObject:
                @{@"page":@0,
                  @"viewModels":
                    [NSMutableArray array]}];
    }
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:FONT_COLOR};
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
    NSArray *segments = @[@"热门动态",@"哔哔叨叨",@"官方资讯"];
    _segmentView = [[MBSegmentedView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) withSegments:segments];
    [self setupTableView:segments];
    // block回调
    __weak typeof(self) weakSelf = self;
    _segmentView.clickSegmentBtnBlock = ^(UIButton *sender) {
        [weakSelf segmentBtnClick:sender];
    };
   __block BOOL hasLoadingBBDD = NO;
   __block BOOL hasLoadingNews = NO;
    _segmentView.scrollViewBlock = ^(NSInteger index) {
        if (!hasLoadingBBDD && index == 1) {
            [weakSelf loadNetDataWithType:index];
            hasLoadingBBDD = YES;
        }
        if (!hasLoadingNews && index==2) {
            [weakSelf loadNetDataWithType:index];
            hasLoadingNews = YES;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    self.navigationItem.rightBarButtonItem = self.addButton;
//    if (_currenSelectCellOfRow) {
//        NSInteger row = [self.currenSelectCellOfRow integerValue];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:row];
//        MBCommunityTableView *tableView = self.tableViewArray[[self.currenSelectCellOfTableView integerValue]];
//        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//    }
}

#pragma mark - 请求网络数据

- (void)loadNetDataWithType:(NSInteger)type {
    //type 0 = 热门, 1 = 哔哔叨叨, 2 = 官方咨询)
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    NSString *url;
    NSMutableDictionary *parameter =
            @{@"stuNum":stuNum,
              @"idNum":idNum,
              @"version":@(1.0)}.mutableCopy;
    MBCommunityTableView *tableView = self.tableViewArray[type];

    NSMutableArray *viewModels;
    [parameter setObject:self.dataDicArray[type][@"page"] forKey:@"page"];
    viewModels = self.dataDicArray[type][@"viewModels"];
    if (type == 0) {
        url = SEARCHHOTARTICLE_API;
    }else if (type == 1) {
        url = LISTARTICLE_API;
        [parameter setObject:@5 forKey:@"type_id"];
    }else if (type == 2) {
        url = LISTNEWS_API;
    }
    [NetWork NetRequestPOSTWithRequestURL:url WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSNumber *page;
        NSMutableArray *dataArray = [NSMutableArray array];
        if (type == 0) {
            for (int i = 0; i < ((NSArray *)returnValue).count; i ++) {
                [dataArray addObject:returnValue[i][@"data"]];
                page = returnValue[i][@"page"];
            }
        }else if (type == 1 || type ==2) {
            dataArray = returnValue[@"data"];
            page = returnValue[@"page"];
        }
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
        UIActivityIndicatorView *indicatorView = self.indicatorViewArray[type];
        [indicatorView stopAnimating];
        tableView.hidden = NO;
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
        [tableView.mj_footer endRefreshing];
    } WithFailureBlock:^{
        NSLog(@"请求数据失败");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您的网络不给力!";
        [hud hide:YES afterDelay:1];

        self.dataDicArray[type] = self.tempDic;
        [tableView.mj_header endRefreshing];
        [tableView.mj_footer endRefreshing];
    }];
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
    if (stuNum.length == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"是否登录？" message:@"你都没有登录咯,肯定不让你发布呀" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:nil];
        
        __weak typeof(self) weakSelf = self;
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            LoginViewController *LVC = [[LoginViewController alloc] init];
            LVC.loginSuccessHandler = ^(BOOL success) {
                if (success) {
                    [weakSelf clickAddButton:sender];
                }
            };
            
            [weakSelf presentViewController:LVC animated:YES completion:nil];
        }];
        
        [alertC addAction:cancel];
        [alertC addAction:confirm];
        
        [self presentViewController:alertC animated:YES completion:nil];

    }else if (stuNum.length != 0) {
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
            self.tempDic = self.dataDicArray[i];
            self.dataDicArray[i] =
                        @{@"page":@0,
                          @"viewModels":
                        [NSMutableArray array]};
            [self loadNetDataWithType:i];
        }];
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.tempDic = self.dataDicArray[i];
            [self loadNetDataWithType:i];
        }];
    }
}

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
    cell.eventDelegate = self;
    MBCommunity_ViewModel *viewModel =self.dataDicArray[tableView.tag][@"viewModels"][index];
    if (tableView.tag == 2) {
        cell.headImageView.userInteractionEnabled = NO;
    }
    __weak typeof(self) weakSelf = self;
    cell.clickSupportBtnBlock = ^(UIButton *imageBtn,UIButton *labelBtn,MBCommunity_ViewModel *viewModel) {
        MBCommunityModel *model = viewModel.model;
        if (imageBtn.selected && labelBtn.selected) {
            NSInteger currentSupportNum = [labelBtn.titleLabel.text integerValue];
            currentSupportNum--;
//            NSInteger nowSupportNum;
//            if (currentSupportNum == 0) {
//                nowSupportNum = 0;
//            }else {
//                nowSupportNum = currentSupportNum - 1;
//            }
            [labelBtn setTitle:[NSString stringWithFormat:@"%ld",currentSupportNum] forState:UIControlStateNormal];
//            model.like_num = @(currentSupportNum);
            [weakSelf uploadSupport:viewModel withType:1];
            imageBtn.selected = !imageBtn.selected;
            labelBtn.selected = !labelBtn.selected;
//            weakSelf.currenSelectCellOfRow = [NSString stringWithFormat:@"%ld",indexPath.section];
//            weakSelf.currenSelectCellOfTableView = [NSString stringWithFormat:@"%ld",tableView.tag];
            NSLog(@"点击取消赞");
            
        }else {
            NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
            NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
            if (stuNum.length == 0 && idNum.length == 0) {
                [weakSelf uploadSupport:viewModel withType:0];
            }else {
                NSInteger currentSupportNum = [labelBtn.titleLabel.text integerValue];
                [labelBtn setTitle:[NSString stringWithFormat:@"%ld",currentSupportNum+1] forState:UIControlStateNormal];
                model.like_num = @(currentSupportNum+1);
                [weakSelf uploadSupport:viewModel withType:0];
                imageBtn.selected = !imageBtn.selected;
                labelBtn.selected = !labelBtn.selected;
//                weakSelf.currenSelectCellOfRow = [NSString stringWithFormat:@"%ld",indexPath.section];
//                weakSelf.currenSelectCellOfTableView = [NSString stringWithFormat:@"%ld",tableView.tag];
                NSLog(@"点击赞");
            }
            
        }
    };
    
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
//    _currenSelectCellOfRow = [NSString stringWithFormat:@"%ld",indexPath.section];
//    _currenSelectCellOfTableView = [NSString stringWithFormat:@"%ld",tableView.tag];
    [self.navigationController pushViewController:d animated:YES];
}
#pragma mark - 上传点赞

- (void)uploadSupport:(MBCommunity_ViewModel *)viewModel withType:(NSInteger)type {
    //type == 0 赞 , type == 1 取消赞
    MBCommunityModel *model = viewModel.model;
    NSString *url;
    if (type == 0) {
        url = ADDSUPPORT_API;
    }else if (type == 1) {
        url = CANCELSUPPOTRT_API;
    }
    
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    NSNumber *article_id = model.article_id;
    NSNumber *type_id = model.type_id;
    //如果stuNum和idNum为nil 则不能点赞 提示是否登录
    if (stuNum.length == 0 && idNum.length == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"是否登录？" message:@"没有完善信息呢,肯定不让你点赞呀" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:nil];
        
        __weak typeof(self) weakSelf = self;
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            LoginViewController *LVC = [[LoginViewController alloc] init];
            LVC.loginSuccessHandler = ^(BOOL success) {
                if (success) {
                    [weakSelf uploadSupport:viewModel withType:type];
                }
            };

            [weakSelf presentViewController:LVC animated:YES completion:nil];
        }];
        
        [alertC addAction:cancel];
        [alertC addAction:confirm];
        
        [self presentViewController:alertC animated:YES completion:nil];
    }else {
//        NSInteger row = [self.currenSelectCellOfRow integerValue];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:row];
//        MBCommunityTableView *tableView = self.tableViewArray[[self.currenSelectCellOfTableView integerValue]];
//        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        NSDictionary *parameter = @{@"stuNum":stuNum,
                                    @"idNum":idNum,
                                @"article_id":article_id,
                                    @"type_id":type_id};
        [NetWork NetRequestPOSTWithRequestURL:url WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        
        } WithFailureBlock:^{
            NSLog(@"请求赞出错");
        }];
    }
}

#pragma mark -



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

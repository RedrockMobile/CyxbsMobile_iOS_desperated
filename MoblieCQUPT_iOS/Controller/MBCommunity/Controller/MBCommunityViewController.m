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


@interface MBCommunityViewController ()<UITableViewDataSource,UITableViewDelegate,MBCommunityCellEventDelegate>

@property (strong, nonatomic) MBSegmentedView *segmentView;

@property (strong, nonatomic) UIBarButtonItem *addButton;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *frameArray;

@property (strong, nonatomic) NSMutableArray *hotData;
@property (strong, nonatomic) NSMutableArray *BBDDData;
@property (strong, nonatomic) NSMutableArray *newsData;

@property (assign, nonatomic) BOOL isLoadingHotData;
@property (assign, nonatomic) BOOL isLoadingBBDDData;
@property (assign, nonatomic) BOOL isLoadingNewsData;

@property (strong, nonatomic) NSMutableDictionary *allData;

@property (strong, nonatomic) NSMutableArray<MBCommunityTableView *> *tableViewArray;
@property (strong, nonatomic) NSMutableArray *indicatorViewArray;

@property (copy, nonatomic) NSString *currenSelectCellOfRow;
@property (copy, nonatomic) NSString *currenSelectCellOfTableView;

//@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation MBCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isLoadingHotData = NO;
    _isLoadingBBDDData = NO;
    _isLoadingNewsData = NO;
    _allData = [NSMutableDictionary dictionary];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
    NSArray *segments = @[@"热门动态",@"哔哔叨叨",@"官方资讯"];
    _segmentView = [[MBSegmentedView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) withSegments:segments];
    [self setupTableView:segments];
    // block回调
    __weak typeof(self) weakSelf = self;
    _segmentView.clickSegmentBtnBlock = ^(UIButton *sender) {
        
        [weakSelf segmentBtnClick:sender];
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
    _isLoadingHotData = YES;
    
    _segmentView.scrollViewBlock = ^(NSInteger index) {
        
        if (index == 1 && !_isLoadingBBDDData) {
            if (!weakSelf.BBDDData) {
                [weakSelf loadNetDataWithType:index];
                _isLoadingBBDDData = YES;
            }
        }else if (index == 2 && !_isLoadingNewsData) {
            if (!weakSelf.newsData) {
                [weakSelf loadNetDataWithType:index];
                _isLoadingNewsData = YES;
            }
        }
    };
    // ******
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
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
    if (_currenSelectCellOfRow) {
        NSInteger row = [self.currenSelectCellOfRow integerValue];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:row];
        MBCommunityTableView *tableView = self.tableViewArray[[self.currenSelectCellOfTableView integerValue]];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (NSMutableDictionary *)allData {
    if (!_allData) {
        _allData = [NSMutableDictionary dictionary];
    }
    return _allData;
}

#pragma mark - 请求网络数据

- (void)loadNetDataWithType:(NSInteger)type {
    
    NSLog(@"%ld",type);
    
    //type 0 = 热门, 1 = 哔哔叨叨, 2 = 官方咨询
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"] ?: @"";
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"] ?: @"";
    NSString *page = @"0";
    NSString *size = @"0";
    NSString *type_id = @"5";
    NSString *url;
    NSDictionary *parameter;
    if (type == 0) {
        url = SEARCHHOTARTICLE_API;
        parameter = @{@"stuNum":stuNum,
                      @"idNum":idNum,
                      @"page":page,
                      @"size":size};
    }else if (type == 1) {
        url = LISTARTICLE_API;
        parameter = @{@"stuNum":stuNum,
                      @"idNum":idNum,
                      @"page":page,
                      @"size":size,
                      @"type_id":type_id};
    }else if (type == 2) {
        url = LISTNEWS_API;
        parameter = @{@"stuNum":stuNum,
                      @"idNum":idNum,
                      @"page":page,
                      @"size":size,
                      @"type_id":type_id};
    }
    
    // 请求
    
    [NetWork NetRequestPOSTWithRequestURL:url WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSMutableDictionary *dicData = [NSMutableDictionary dictionary];
        NSMutableArray *dataModel = [NSMutableArray array];
        NSMutableArray *netData = [NSMutableArray array];
        if (type == 0) {
            for (int i = 0; i < ((NSArray *)returnValue).count; i ++) {
                [netData addObject:returnValue[i][@"data"]];
                [dicData setObject:returnValue[i][@"page"] forKey:@"page"];
            }
        }else if (type == 1) {
            netData = returnValue[@"data"];
            [dicData setObject:returnValue[@"page"] forKey:@"page"];
        }else if (type == 2) {
            netData = returnValue[@"data"];
            [dicData setObject:returnValue[@"page"] forKey:@"page"];
        }
        
        
        [netData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MBCommunityModel *model;
            if (type == 0) {
                model = [[MBCommunityModel alloc]initWithDictionary:netData[idx] withMBCommunityModelType:MBCommunityModelTypeHot];
            }else if (type == 1) {
                model = [[MBCommunityModel alloc]initWithDictionary:netData[idx] withMBCommunityModelType:MBCommunityModelTypeListArticle];
            }else if (type == 2) {
                model = [[MBCommunityModel alloc]initWithDictionary:netData[idx] withMBCommunityModelType:MBCommunityModelTypeListNews];
            }
            
            MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
            viewModel.model = model;
            [dataModel addObject:viewModel];
        }];
        
        [dicData setObject:dataModel forKey:@"data"];
        
        
        if (type == 0) {
            _hotData = dicData[@"data"];
            [_allData setObject:dicData forKey:@"hotData"];
        }else if (type == 1) {
            _BBDDData = dicData[@"data"];
            [_allData setObject:dicData forKey:@"BBDDData"];
        }else if (type == 2) {
            _newsData = dicData[@"data"];
            [_allData setObject:dicData forKey:@"newsData"];
        }
        
        UIActivityIndicatorView *indicatorView = self.indicatorViewArray[type];
        [indicatorView stopAnimating];
        
        
        MBCommunityTableView *tableView = self.tableViewArray[type];
        tableView.hidden = NO;
        [tableView reloadData];
        
        
    } WithFailureBlock:^{
        NSLog(@"请求数据失败");
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
        add.frame = CGRectMake(0, 0, 17, 17);
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
        [self setupMJRefresh];
    }
}

- (NSInteger)tableView:(MBCommunityTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(MBCommunityTableView *)tableView {
    if (tableView.tag == 0) {
        return ((NSMutableArray *)_allData[@"hotData"][@"data"]).count;
    }else if (tableView.tag == 1) {
        return ((NSMutableArray *)_allData[@"BBDDData"][@"data"]).count;
    }else if (tableView.tag == 2) {
        return ((NSMutableArray *)_allData[@"newsData"][@"data"]).count;
    }else {
       return 0;
    }
    
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
    if (tableView.tag == 0) {
        viewModel = _allData[@"hotData"][@"data"][indexPath.section];
        return viewModel.cellHeight;
    }else if (tableView.tag == 1) {
        viewModel = _allData[@"BBDDData"][@"data"][indexPath.section];
        return viewModel.cellHeight;
    }else if (tableView.tag == 2) {
        viewModel = _allData[@"newsData"][@"data"][indexPath.section];
        return viewModel.cellHeight;
    }else {
        return 0;
    }
    
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (MBCommunityCellTableViewCell *)tableView:(MBCommunityTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBCommunityCellTableViewCell *cell = [MBCommunityCellTableViewCell cellWithTableView:tableView];
    cell.eventDelegate = self;
    MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
    if (tableView.tag == 0) {
        viewModel = _allData[@"hotData"][@"data"][indexPath.section];
    }else if (tableView.tag == 1) {
        viewModel = _allData[@"BBDDData"][@"data"][indexPath.section];
    }else if (tableView.tag == 2) {
        viewModel = _allData[@"newsData"][@"data"][indexPath.section];
    }
    if (tableView.tag == 2) {
        cell.headImageView.userInteractionEnabled = NO;
    }
    
    __weak typeof(self) weakSelf = self;
    cell.clickSupportBtnBlock = ^(UIButton *imageBtn,UIButton *labelBtn,MBCommunity_ViewModel *viewModel) {
        MBCommunityModel *model = viewModel.model;
        if (imageBtn.selected && labelBtn.selected) {
            NSInteger currentSupportNum = [labelBtn.titleLabel.text integerValue];
            NSInteger nowSupportNum;
            if (currentSupportNum == 0) {
                nowSupportNum = 0;
            }else {
                nowSupportNum = currentSupportNum - 1;
            }
            [labelBtn setTitle:[NSString stringWithFormat:@"%ld",nowSupportNum] forState:UIControlStateNormal];
            model.numOfSupport = [NSString stringWithFormat:@"%ld",nowSupportNum];
            [weakSelf uploadSupport:viewModel withType:1];
            imageBtn.selected = !imageBtn.selected;
            labelBtn.selected = !labelBtn.selected;
            weakSelf.currenSelectCellOfRow = [NSString stringWithFormat:@"%ld",indexPath.section];
            weakSelf.currenSelectCellOfTableView = [NSString stringWithFormat:@"%ld",tableView.tag];
            NSLog(@"点击取消赞");
            
        }else {
            NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
            NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
            if (stuNum.length == 0 && idNum.length == 0) {
                [weakSelf uploadSupport:viewModel withType:0];
            }else {
                NSInteger currentSupportNum = [labelBtn.titleLabel.text integerValue];
                [labelBtn setTitle:[NSString stringWithFormat:@"%ld",currentSupportNum+1] forState:UIControlStateNormal];
                model.numOfSupport = [NSString stringWithFormat:@"%ld",currentSupportNum+1];
                [weakSelf uploadSupport:viewModel withType:0];
                imageBtn.selected = !imageBtn.selected;
                labelBtn.selected = !labelBtn.selected;
                weakSelf.currenSelectCellOfRow = [NSString stringWithFormat:@"%ld",indexPath.section];
                weakSelf.currenSelectCellOfTableView = [NSString stringWithFormat:@"%ld",tableView.tag];
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
    
    [self.navigationController pushViewController:myMeVc animated:YES];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MBCommuityDetailsViewController *d = [[MBCommuityDetailsViewController alloc]init];
    
    MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
    if (tableView.tag == 0) {
        viewModel = _allData[@"hotData"][@"data"][indexPath.section];
        NSLog(@"%@",_allData[@"hotData"][@"page"]);
    }else if (tableView.tag == 1) {
        viewModel = _allData[@"BBDDData"][@"data"][indexPath.section];
    }else if (tableView.tag == 2) {
        viewModel = _allData[@"newsData"][@"data"][indexPath.section];
    }
    d.viewModel = viewModel;
//    NSLog(@"%@",viewModel.model);
    _currenSelectCellOfRow = [NSString stringWithFormat:@"%ld",indexPath.section];
    _currenSelectCellOfTableView = [NSString stringWithFormat:@"%ld",tableView.tag];
    [self.navigationController pushViewController:d animated:YES];
}

#pragma mark - 下拉和上拉刷新

- (void)setupMJRefresh {
    for (int i = 0; i < self.tableViewArray.count ; i++) {
        MBCommunityTableView *tableView = self.tableViewArray[i];
        __weak typeof(MBCommunityTableView *) weakTableView = tableView;
        __weak typeof(self) weakSelf = self;
        
        __block NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"] ?: @"";
        __block NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"] ?: @"";
        __block NSString *page;
        __block NSString *currentPage;
        __block NSString *size = @"0";
        __block NSString *type_id = @"5";
        __block NSString *url;
        __block NSDictionary *parameter;
        //添加下拉刷新控件
        [tableView addHeaderWithCallback:^{
            page = @"0";
            if (i == 0) {
                url = SEARCHHOTARTICLE_API;
                parameter = @{@"stuNum":stuNum,
                              @"idNum":idNum,
                              @"page":page,
                              @"size":size};
            }else if (i == 1) {
                url = LISTARTICLE_API;
                parameter = @{@"stuNum":stuNum,
                              @"idNum":idNum,
                              @"page":page,
                              @"size":size,
                              @"type_id":type_id};
            }else if (i == 2) {
                url = LISTNEWS_API;
                parameter = @{@"stuNum":stuNum,
                              @"idNum":idNum,
                              @"page":page,
                              @"size":size,
                              @"type_id":type_id};
            }
            [NetWork NetRequestPOSTWithRequestURL:url WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
                NSMutableDictionary *dicData = [NSMutableDictionary dictionary];
                NSMutableArray *dataModel = [NSMutableArray array];
                NSMutableArray *netData = [NSMutableArray array];
                if (i == 0) {
                    for (int i = 0; i < ((NSArray *)returnValue).count; i ++) {
                        [netData addObject:returnValue[i][@"data"]];
                        [dicData setObject:returnValue[i][@"page"] forKey:@"page"];
                    }
                }else if (i == 1) {
                    netData = returnValue[@"data"];
                    [dicData setObject:returnValue[@"page"] forKey:@"page"];
                }else if (i == 2) {
                    netData = returnValue[@"data"];
                    [dicData setObject:returnValue[@"page"] forKey:@"page"];
                }
                
                [netData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MBCommunityModel *model;
                    if (i == 0) {
                        model = [[MBCommunityModel alloc]initWithDictionary:netData[idx] withMBCommunityModelType:MBCommunityModelTypeHot];
                    }else if (i == 1) {
                        model = [[MBCommunityModel alloc]initWithDictionary:netData[idx] withMBCommunityModelType:MBCommunityModelTypeListArticle];
                    }else if (i == 2) {
                        model = [[MBCommunityModel alloc]initWithDictionary:netData[idx] withMBCommunityModelType:MBCommunityModelTypeListNews];
                    }
                    
                    MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
                    viewModel.model = model;
                    [dataModel addObject:viewModel];
                }];
                
                [dicData setObject:dataModel forKey:@"data"];
                
                
                if (i == 0) {
                    _hotData = dicData[@"data"];
                    [_allData setObject:dicData forKey:@"hotData"];
                }else if (i == 1) {
                    _BBDDData = dicData[@"data"];
                    [_allData setObject:dicData forKey:@"BBDDData"];
                }else if (i == 2) {
                    _newsData = dicData[@"data"];
                    [_allData setObject:dicData forKey:@"newsData"];
                }
                [weakTableView reloadData];
                [weakTableView headerEndRefreshing];
            } WithFailureBlock:^{
                [weakTableView headerEndRefreshing];
                NSLog(@"刷新数据失败");
            }];
        }];
        
        //添加上拉加载控件
        [tableView addFooterWithCallback:^{
            if (i == 0) {
                currentPage = weakSelf.allData[@"hotData"][@"page"];
                NSInteger nextPage = [currentPage integerValue];
                page = [NSString stringWithFormat:@"%ld",nextPage+1];
                url = SEARCHHOTARTICLE_API;
                parameter = @{@"stuNum":stuNum,
                              @"idNum":idNum,
                              @"page":page,
                              @"size":size};
            }else if (i == 1) {
                currentPage = weakSelf.allData[@"BBDDData"][@"page"];
                NSInteger nextPage = [currentPage integerValue];
                page = [NSString stringWithFormat:@"%ld",nextPage+1];
                url = LISTARTICLE_API;
                parameter = @{@"stuNum":stuNum,
                              @"idNum":idNum,
                              @"page":page,
                              @"size":size,
                              @"type_id":type_id};
            }else if (i == 2) {
                currentPage = weakSelf.allData[@"newsData"][@"page"];
                NSInteger nextPage = [currentPage integerValue];
                page = [NSString stringWithFormat:@"%ld",nextPage+1];
                url = LISTNEWS_API;
                parameter = @{@"stuNum":stuNum,
                              @"idNum":idNum,
                              @"page":page,
                              @"size":size,
                              @"type_id":type_id};
            }
            [NetWork NetRequestPOSTWithRequestURL:url WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
                NSMutableDictionary *dicData = [NSMutableDictionary dictionary];
                NSMutableArray *dataModel;
                NSMutableArray *netData = [NSMutableArray array];
                if (i == 0) {
                    for (int i = 0; i < ((NSArray *)returnValue).count; i ++) {
                        [netData addObject:returnValue[i][@"data"]];
                        [dicData setObject:returnValue[i][@"page"] forKey:@"page"];
                    }
                    dataModel = [NSMutableArray arrayWithArray:weakSelf.hotData];
                }else if (i == 1) {
                    netData = returnValue[@"data"];
                    [dicData setObject:returnValue[@"page"] forKey:@"page"];
                    dataModel = [NSMutableArray arrayWithArray:weakSelf.BBDDData];
                }else if (i == 2) {
                    netData = returnValue[@"data"];
                    [dicData setObject:returnValue[@"page"] forKey:@"page"];
                    dataModel = [NSMutableArray arrayWithArray:weakSelf.newsData];
                }
                
                if (netData.count != 0) {
                    [netData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        MBCommunityModel *model;
                        if (i == 0) {
                            model = [[MBCommunityModel alloc]initWithDictionary:netData[idx] withMBCommunityModelType:MBCommunityModelTypeHot];
                        }else if (i == 1) {
                            model = [[MBCommunityModel alloc]initWithDictionary:netData[idx] withMBCommunityModelType:MBCommunityModelTypeListArticle];
                        }else if (i == 2) {
                            model = [[MBCommunityModel alloc]initWithDictionary:netData[idx] withMBCommunityModelType:MBCommunityModelTypeListNews];
                        }
                        
                        MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
                        viewModel.model = model;
                        [dataModel addObject:viewModel];
                    }];
                    
                    [dicData setObject:dataModel forKey:@"data"];
                    
                    
                    if (i == 0) {
                        _hotData = dicData[@"data"];
                        [_allData setObject:dicData forKey:@"hotData"];
                    }else if (i == 1) {
                        _BBDDData = dicData[@"data"];
                        [_allData setObject:dicData forKey:@"BBDDData"];
                    }else if (i == 2) {
                        _newsData = dicData[@"data"];
                        [_allData setObject:dicData forKey:@"newsData"];
                    }
                    [weakTableView reloadData];

                }
                
                [weakTableView footerEndRefreshing];
            } WithFailureBlock:^{
                [weakTableView footerEndRefreshing];
                NSLog(@"加载更多数据失败");
            }];
        }];
        
        tableView.headerPullToRefreshText = @"下拉即可刷新";
        tableView.headerReleaseToRefreshText = @"松开即可刷新";
        tableView.headerRefreshingText = @"正在刷新中";
        
        tableView.footerPullToRefreshText = @"上拉加载更多";
        tableView.footerReleaseToRefreshText = @"松开加载更多";
        tableView.footerRefreshingText = @"玩命加载中";
    }
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
    NSString *article_id = model.articleID;
    NSString *type_id = model.typeID;
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
        NSDictionary *parameter = @{@"stuNum":stuNum,
                                    @"idNum":idNum,
                                    @"article_id":article_id,
                                    @"type_id":type_id};
        
        __block MBCommunityModel *modelBlock = model;
        __block MBCommunity_ViewModel *viewModelBlock = viewModel;
        __weak typeof(self) weakSelf = self;
        
        [NetWork NetRequestPOSTWithRequestURL:url WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
            modelBlock.isMyLike = [NSString stringWithFormat:@"%d",![modelBlock.isMyLike boolValue]];
            viewModelBlock.model = modelBlock;
            NSInteger row = [weakSelf.currenSelectCellOfRow integerValue];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:row];
            MBCommunityTableView *tableView = weakSelf.tableViewArray[[weakSelf.currenSelectCellOfTableView integerValue]];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            NSLog(@"请求 %@",modelBlock.isMyLike);
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

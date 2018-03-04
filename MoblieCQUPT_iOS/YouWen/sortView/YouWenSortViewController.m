//
//  YouWenSortViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/24.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenSortViewController.h"
#import "YouWenTableViewCell.h"
#import "YouWenDataModel.h"
#import <MJRefresh.h>
@interface YouWenSortViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tab;
@property (strong, nonatomic) NSMutableArray *cellArray;
@property (strong, nonatomic) YouWenDataModel *dataModel;
@property (nonatomic, assign) NSInteger YWpage;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation YouWenSortViewController
- (instancetype)initViewStyle:(NSString *)style{
    if (self = [super init]) {
        _dataModel = [[YouWenDataModel alloc]initWithStyle:style];
        _YWpage = 0;
    }
    return self;
}
- (NSMutableArray *)dataArray{
    if (_dataArray) {
        _dataArray = [NSArray array].mutableCopy;
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tab = [[UITableView alloc] init];
    _cellArray = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableData) name:@"DataLoading" object:nil];
    _tab.delegate = self;
    _tab.dataSource = self;
    _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tab.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    header.stateLabel.textColor = [UIColor blackColor];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tab.mj_header = header;
    MJRefreshAutoNormalFooter* footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getNewPageData)];
    footer.stateLabel.textColor = [UIColor blackColor];
    _tab.mj_footer = footer;
    [self.view addSubview:_tab];
    [_tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    [_tab.mj_header beginRefreshing];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
}

- (void)refreshTableData{
    if (_tab.mj_header.state == MJRefreshStateRefreshing) {
        if (_dataModel.YWdataArray.count) {
            if (!_dataArray.count) {
                _dataArray = _dataModel.YWdataArray.mutableCopy;
            }
            else {
                [_dataModel.YWdataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj[@"created_at"] isEqualToString:
                         _dataArray[idx][@"created_at"]]){
                        *stop = YES;
                    }
                    else {
                        [_dataArray insertObject:obj atIndex:0];
                    }
                }];
            }
            [_tab reloadData];
            [_tab.mj_header endRefreshing];
        }
    }
    else{
        if (_dataModel.YWdataArray.count) {
            [_dataArray addObjectsFromArray:_dataModel.YWdataArray.mutableCopy];
            [_tab reloadData];
            [_tab.mj_footer endRefreshing];
        }
        else {
            [_tab.mj_footer endRefreshingWithNoMoreData];
        }
    }
}
- (void)getNewData{
    [_dataModel newYWDate];
}
- (void)getNewPageData{
    _YWpage ++;
    [_dataModel newPage:[NSString stringWithFormat:@"%ld", (long)_YWpage]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSDictionary *dic = _dataArray[indexPath.row];
    YouWenTableViewCell *cell = [YouWenTableViewCell cellWithTableView:tableView andDic:dic];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSValue *value = [NSValue valueWithCGRect:cell.cellSize];
    _cellArray[indexPath.row] =  value;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSValue *value = _cellArray[indexPath.row];
    CGRect cellSize = [value CGRectValue];
    return cellSize.size.height;
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

//
//  YouWenSortViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/24.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenSortViewController.h"
#import "YouWenTableViewCell.h"
#import <MJRefresh.h>
@interface YouWenSortViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *cellArray;

@end

@implementation YouWenSortViewController
- (instancetype)initViewStyle:(NSString *)style{
    if (self = [super init]) {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tab = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _cellArray = [NSMutableArray array];
    tab.delegate = self;
    tab.dataSource = self;
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    tab.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.stateLabel.textColor = [UIColor blackColor];
    header.lastUpdatedTimeLabel.hidden = YES;
    tab.mj_header = header;
    MJRefreshAutoNormalFooter* footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    footer.stateLabel.textColor = [UIColor blackColor];
    footer.refreshingTitleHidden = YES;
    tab.mj_footer = footer;
    [self.view addSubview:tab];
}
- (void)refreshData{
    
}
- (void)getNewData{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSDictionary *dic = @{@"name":@"刘同学", @"sort":@"线代", @"gender":@"male", @"title":@"线代第一题不会", @"detail": @"撒打发速度发斯蒂芬答复大师傅手动阀收到法撒旦法师大法师打发阿萨德发都是", @"gender":@"male"};
    YouWenTableViewCell *cell = [YouWenTableViewCell cellWithTableView:tableView andDic:dic];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSValue *value = [NSValue valueWithCGRect:cell.cellSize];
    _cellArray[indexPath.row] =  value;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
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

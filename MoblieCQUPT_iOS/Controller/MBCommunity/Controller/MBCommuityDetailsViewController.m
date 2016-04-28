//
//  MBCommuityDetailsViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/21.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommuityDetailsViewController.h"
#import "MBCommunityCellTableViewCell.h"
#import "MBCommunityTableView.h"
#import "MBCommentCell.h"
#import "MBReleaseViewController.h"


@interface MBCommuityDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) MBCommunityTableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) UIView *headView;


@end

@implementation MBCommuityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self loadData];
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)loadData {
    _dataArray = [NSMutableArray array];
    
    NSArray *headImage = @[@"智妍1.jpg",@"熊.jpg",@"1智妍.jpg"];
    
    NSArray *idArray = @[@"朴智妍",@"一只贱贱的熊",@"陈格格"];
    
    NSArray *time = @[@"今天10:04",@"今天04:06",@"今天06:07"];
    
    NSArray *content = @[@"那些比你牛逼的人还在努力 你努力还有个屁用",@"如果没有热爱 梦何以实现",@"如果你光有真心，口口声声要给我好的生活却从来不为我们两个的未来打拼，那这个时候真心就显得很空洞。"];
    
    for (int i = 0; i < 6; i ++) {
        int index = arc4random() % 3;
        int index2 = arc4random() % 3;
        int index3 = arc4random() % 3;
        
        MBCommentModel *model = [[MBCommentModel alloc]init];
        model.headImageView = headImage[index];
        model.IDLabel = idArray[index];
        model.timeLabel = time[index2];
        model.contentLabel = content[index3];
        
        MBComment_ViewModel *viewModel = [[MBComment_ViewModel alloc]init];
        viewModel.model = model;
        [_dataArray addObject:viewModel];
    }
}


- (MBCommunityTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MBCommunityTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
    }
    return _tableView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return self.headView;
    }else {
        return nil;
    }
    
}

- (UIView *)headView {
    
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        _headView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 40)];
        back.backgroundColor = [UIColor whiteColor];
        
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
        headLabel.text = @"评论";
        headLabel.font = [UIFont systemFontOfSize:16];
        headLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
        [headLabel sizeToFit];
        headLabel.center = CGPointMake(10+headLabel.frame.size.width/2, back.frame.size.height/2);
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 39, ScreenWidth, 1)];
        line.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        
        [back addSubview:headLabel];
        [back addSubview:line];
        [_headView addSubview:back];
    }
    
    return _headView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return self.dataArray.count;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.viewModel.cellHeight;
    }else {
        return ((MBComment_ViewModel *)self.dataArray[indexPath.row]).cellHeight;
    }
}


- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    }else if (section == 0){
        return 0.00001;
    }else {
        return 10;
    }
    
}
- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForFooterInSection:(NSInteger)section {
        return 0;
}

- (UITableViewCell *)tableView:(MBCommunityTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MBCommunityCellTableViewCell *cell = [MBCommunityCellTableViewCell cellWithTableView:tableView];
        cell.subViewFrame = self.viewModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        MBCommentCell *cell = [MBCommentCell cellWithTableView:tableView];
        cell.viewModel = (MBComment_ViewModel *)self.dataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;   
        return cell;
    }
    
    
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

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

@interface MBCommunityViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) MBSegmentedView *segmentView;

@property (strong, nonatomic) UIBarButtonItem *addButton;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *frameArray;

@property (strong, nonatomic) NSMutableArray *allData;

@property (strong, nonatomic) NSMutableArray *tableViewArray;

@end

@implementation MBCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadModel];
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
    _segmentView.scrollViewBlock = ^(NSInteger index) {
        [weakSelf.tableViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == index) {
                MBCommunityTableView *tableView = weakSelf.tableViewArray[idx];
                if (tableView.hidden) {
                    tableView.hidden = NO;
                }
            }
        }];
    };
    // ******
    [self.view addSubview:_segmentView];
    
    // Do any additional setup after loading the view from its nib.
}

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
        NSLog(@"创建右");
        UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
        [add setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        add.frame = CGRectMake(0, 0, 17, 17);
        [add addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _addButton = [[UIBarButtonItem alloc]initWithCustomView:add];
    }
    
    return _addButton;
}

- (void)clickAddButton:(UIButton *) sender{
    MBReleaseViewController *releaseVC = [[MBReleaseViewController alloc]init];
    [self.navigationController presentViewController:releaseVC animated:YES completion:nil];
}

- (void)loadModel {
    NSArray *headImage = @[@"智妍1.jpg",@"熊.jpg",@"1智妍.jpg"];
    
    NSArray *idArray = @[@"朴智妍",@"一只贱贱的熊",@"陈格格"];
    
    NSArray *time = @[@"今天10:04",@"今天04:06",@"今天06:07"];
    
    NSArray *content = @[@"如果你光有真心，口口声声要给我好的生活却从来不为我们两个的未来打拼，那这个时候真心就显得很空洞。",
                         @"习惯性说嗯 不是敷衍 只是证明我在听 我太懒记性不好 生活就这样没有太好但也并不会坏喜欢的可以关注我，这里总有一句你喜欢的话。",
                         @"睡的时候，不辜负床，忙的时候，不辜负路，爱的时候，不辜负人，饿的时候，不辜负胃。",
                         @"如果我用你待我的方式来待你，恐怕你早已离去。所以说，不管亲情，友情，还是爱情，凡事换个角度，假如你是我，你未必有我大度！",
                         @"或许以后的我会喜欢上另外一个人就像当初喜欢上你一样，也或许除了你，我再也遇不到能让我感受得到心跳的人，到最后只能把你埋在心里，我知道当青春逝去的时候，很多东西都会面目全非，所以我才更加珍惜，也许你会是我人生中最大的遗憾，但我始终谢谢你，来过我的青春。"
                         ];
    NSArray *support = @[@"212",@"425",@"343"];
    NSArray *comment = @[@"666",@"777",@"888"];
    
    NSArray *pic = @[@"图片1.jpg",@"图片2.jpg",@"图片3.jpg",@"图片4.jpg",@"图片5.jpg",@"图片6.jpg",@"图片7.jpg"];
    _allData = [NSMutableArray array];
    for (int j = 0; j < 3; j ++) {
        NSMutableDictionary *item = [NSMutableDictionary dictionary];
        _dataArray = [NSMutableArray array];
        for (int i = 0,index6 = 0; i < 10; i ++,index6 ++) {
            int index = arc4random() % 3;
            int index2 = arc4random() % 3;
            int index3 = arc4random() % 5;
            int index4 = arc4random() % 3;
            int index5 = arc4random() % 3;
            
            MBCommunityModel *model = [[MBCommunityModel alloc]init];
            model.headImageView = headImage[index];
            model.IDLabel = idArray[index];
            model.timeLabel = time[index2];
            model.contentLabel = content[index3];
            model.numOfComment = comment[index4];
            model.numOfSupport = support[index5];
            NSMutableArray *pic1 = [NSMutableArray array];
            for (int i = 0; i < index6; i ++) {
                int index7 = arc4random() % 7;
                [pic1 addObject:pic[index7]];
            }
            model.pictureArray = pic1;
            
            [_dataArray addObject:model];
        }
        //生存viewModel
        _frameArray = [NSMutableArray array];
        for (MBCommunityModel *model in self.dataArray) {
            MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
            viewModel.model = model;
            [_frameArray addObject:viewModel];
        }
        [item setObject:_dataArray forKey:@"data"];
        [item setObject:_frameArray forKey:@"frame"];
        [_allData addObject:item];
    }
    
}

- (void)setupTableView:(NSArray *)segments {
    _tableViewArray = [NSMutableArray array];
    for (int i = 0; i < segments.count; i ++) {
        MBCommunityTableView *tableView = [[MBCommunityTableView alloc]initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, _segmentView.backScrollView.frame.size.height) style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tag = i;
        tableView.sectionHeaderHeight = 0;
        tableView.sectionFooterHeight = 0;
        tableView.tableStyle = segments[i];
        [_tableViewArray addObject:tableView];
        if (i == 0) {
            tableView.hidden = NO;
        }else {
            tableView.hidden = YES;
        }
        
        [_segmentView.backScrollView addSubview:tableView];
    }
}

- (NSInteger)tableView:(MBCommunityTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(MBCommunityTableView *)tableView {
    return ((NSMutableArray *)self.allData[tableView.tag][@"data"]).count;
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBCommunity_ViewModel *viewModel = self.allData[tableView.tag][@"frame"][indexPath.section];
    return viewModel.cellHeight;
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (MBCommunityCellTableViewCell *)tableView:(MBCommunityTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBCommunityCellTableViewCell *cell = [MBCommunityCellTableViewCell cellWithTableView:tableView];
    MBCommunity_ViewModel *viewModel = self.allData[tableView.tag][@"frame"][indexPath.section];
    cell.subViewFrame = viewModel;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MBCommunity_ViewModel *viewModel = self.allData[tableView.tag][@"frame"][indexPath.section];
    MBCommuityDetailsViewController *d = [[MBCommuityDetailsViewController alloc]init];
    d.navigationItem.title = viewModel.model.IDLabel;
    d.viewModel = viewModel;
    [self.navigationController pushViewController:d animated:YES];
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

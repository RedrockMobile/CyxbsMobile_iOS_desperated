//
//  draftsViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/25.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "draftsViewController.h"
#import "draftsTableViewCell.h"
#import "draftsModel.h"

@interface draftsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *draftTableView;
@property (nonatomic, strong) NSMutableArray<draftsModel *> *dataArray;
@property (assign, nonatomic) NSInteger flag;
@end

@implementation draftsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _flag = 0;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    _dataArray = [NSMutableArray array];
    
    _draftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _draftTableView.backgroundColor = RGBColor(241, 241, 241, 1);
    _draftTableView.delegate = self;
    _draftTableView.dataSource = self;
    [self.view addSubview:_draftTableView];
    [self setupRefresh];
    [self dataFlash];
}
- (void)setupRefresh
{
    self.draftTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.draftTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    self.draftTableView.mj_footer.hidden = YES;
}

- (void)headerRereshing{
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    [NetWork NetRequestPOSTWithRequestURL:@"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/getDraftList" WithParameter:@{@"page":@0, @"size":@15, @"stunum":@"2016210049", @"idnum":@"27001X"}
                     WithReturnValeuBlock:^(id returnValue) {
                         [_dataArray removeAllObjects];
                         for (NSDictionary *dic in returnValue[@"data"]) {
                             draftsModel *model = [[draftsModel alloc] initWithDic:dic];
                             [_dataArray addObject:model];
                         }
                         [_draftTableView.mj_header endRefreshing];
                         [_draftTableView reloadData];
                     } WithFailureBlock:^{
                         UILabel *faileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
                         faileLable.text = @"哎呀！网络开小差了 T^T";
                         faileLable.textColor = [UIColor blackColor];
                         faileLable.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
                         faileLable.textAlignment = NSTextAlignmentCenter;
                         [self.view addSubview:faileLable];
                         [_draftTableView removeFromSuperview];
                     }];
}

- (void)footerRereshing{
    _flag += 1;
    //获取已登录用户的账户信息
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    [NetWork NetRequestPOSTWithRequestURL:@"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/getDraftList" WithParameter:@{@"page":[NSNumber numberWithInteger:_flag], @"size":@15, @"stunum":@"2016210049", @"idnum":@"27001X"} WithReturnValeuBlock:^(id returnValue) {
        
        NSArray *newData = [returnValue objectForKey:@"data"];
        for (NSDictionary *dic in newData) {
            draftsModel *model = [[draftsModel alloc] initWithDic:dic];
            [_dataArray addObject:model];
        }
        // 刷新表格
        if (newData.count == 0) {
            [self.draftTableView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            [_draftTableView reloadData];
            [_draftTableView.mj_footer endRefreshing];
        }
        
    } WithFailureBlock:^{
        UILabel *faileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        faileLable.text = @"哎呀！网络开小差了 T^T";
        faileLable.textColor = [UIColor blackColor];
        faileLable.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        faileLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:faileLable];
        [_draftTableView removeFromSuperview];
    }];
}

- (void)dataFlash{
    //获取已登录用户的账户信息
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    [NetWork NetRequestPOSTWithRequestURL:@"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/getDraftList"
                            WithParameter:@{@"page":@0, @"size":@15, @"stunum":@"2016210049", @"idnum":@"27001X",
                            }
                     WithReturnValeuBlock:^(id returnValue) {
                         for (NSDictionary *dic in returnValue[@"data"]) {
                             draftsModel *model = [[draftsModel alloc] initWithDic:dic];
                             [_dataArray addObject:model];
                         }

                         [_draftTableView reloadData];
                         
                         
                     } WithFailureBlock:^{
                         UILabel *failLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
                         failLabel.text = @"哎呀！网络开小差了 T^T";
                         failLabel.textColor = [UIColor blackColor];
                         failLabel.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
                         failLabel.textAlignment = NSTextAlignmentCenter;
                         [self.view addSubview:failLabel];
                         [_draftTableView removeFromSuperview];
                     }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    draftsTableViewCell *cell;
    cell = [draftsTableViewCell cellWithTableView:_draftTableView AndData:_dataArray[indexPath.row]];
    return cell;
        
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //        获取选中删除行索引值
        NSInteger row = [indexPath row];
        //        通过获取的索引值删除数组中的值
        [self.dataArray removeObjectAtIndex:row];
        //        删除单元格的某一行时，在用动画效果实现删除过程
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)){
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//        [self.dataArray removeObjectAtIndex:indexPath.row];
        completionHandler (YES);
    }];
    //所以图片在这个环境里都会变成白色，折中的办法
    deleteRowAction.image = [UIImage imageNamed:@"dropDelete"];
    deleteRowAction.backgroundColor = RGBColor(103, 131, 247, 1);
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //开启编辑模式
    [tableView setEditing:YES animated:YES];
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
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

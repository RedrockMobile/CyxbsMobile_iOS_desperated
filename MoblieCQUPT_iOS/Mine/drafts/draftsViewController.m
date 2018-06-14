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
#import "YouWenAddViewController.h"
#import "NSString+Emoji.h"

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
    _draftTableView.estimatedRowHeight = 60.0f;
    _draftTableView.rowHeight = UITableViewAutomaticDimension;
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
    NSLog(@"%ld", (long)indexPath.row);
    draftsTableViewCell *cell = [draftsTableViewCell cellWithTableView:_draftTableView AndData:_dataArray[indexPath.row]];
    [cell layoutIfNeeded];
    return cell;
        
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSInteger row = [indexPath row];
        [self.dataArray removeObjectAtIndex:row];
        
        NSString *stuNum = [UserDefaultTool getStuNum];
        NSString *idNum = [UserDefaultTool getIdNum];
        [NetWork NetRequestPOSTWithRequestURL:@"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/deleteItemInDraft"
                                WithParameter:@{@"stunum":@"2016210049", @"idnum":@"27001X",@"id":_dataArray[row].cellID
                                                }
                         WithReturnValeuBlock:^(id returnValue) {
                             
                                 //成功后做什么？？？
                         } WithFailureBlock:^{
                             //失败后做什么？？
                         }];
        
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
//    [tableView setEditing:YES animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//取消cell选中状态
    
    if (_dataArray[indexPath.row].titleType.length) {
        NSString *style = _dataArray[indexPath.row].titleType;
        YouWenAddViewController *views = [[YouWenAddViewController alloc] initWithStyle:style];
        views.titleStr =  _dataArray[indexPath.row].title_content;
        views.detailStr = _dataArray[indexPath.row].description;
        [self.navigationController pushViewController:views animated:YES];
    }
    else {
        NSString *style = _dataArray[indexPath.row].type;
        YouWenAddViewController *views = [[YouWenAddViewController alloc] initWithStyle:style];
        views.titleStr =  _dataArray[indexPath.row].title_content;
        views.detailStr = _dataArray[indexPath.row].content;
        [self.navigationController pushViewController:views animated:YES];
    }
    
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

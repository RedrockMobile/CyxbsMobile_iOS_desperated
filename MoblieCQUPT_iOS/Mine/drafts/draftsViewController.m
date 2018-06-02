//
//  draftsViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/25.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "draftsViewController.h"
#import "draftsTableViewCell.h"

@interface draftsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *draftTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation draftsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    UIImageView *emptyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drafts"]];
//    emptyImage.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:emptyImage];
//
//    [emptyImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view);
//        make.centerY.mas_equalTo(self.view);
//    }];
    _dataArray = [NSMutableArray array];
    
    _draftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _draftTableView.backgroundColor = RGBColor(241, 241, 241, 1);
    _draftTableView.delegate = self;
    _draftTableView.dataSource = self;
//    _draftTableView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.view addSubview:_draftTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    draftsTableViewCell *cell;
    cell = [draftsTableViewCell cellWithTableView:_draftTableView AndLab:YES];
 
    return cell;
        
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
    deleteRowAction.image = [UIImage imageNamed:@"draftDrop"];
    deleteRowAction.backgroundColor = RGBColor(176, 176, 176, 1);
    
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

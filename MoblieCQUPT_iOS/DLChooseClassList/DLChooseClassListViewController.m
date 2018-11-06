//
//  DLChooseClassListViewController.m
//  选课名单
//
//  Created by 丁磊 on 2018/9/19.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import "DLChooseClassListViewController.h"
#import "ListModel.h"
#import "ListTableViewCell.h"
#import "HttpClient.h"

#define LIST_URL @"http://wx.yyeke.com/api/search/coursetable/xkmdsearch?course_num=%@&classroom=%@"

@interface DLChooseClassListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) UITableView *listTab;
@property(strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation DLChooseClassListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选课名单";
    self.view.backgroundColor = [UIColor colorWithHue:0.6111 saturation:0.0122 brightness:0.9647 alpha:1.0];
    self.dataArray = [@[] mutableCopy];
    self.listTab = [[UITableView alloc]initWithFrame: CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    self.listTab.delegate = self;
    self.listTab.dataSource = self;
    self.listTab.backgroundColor = [UIColor clearColor];
    self.listTab.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_listTab];
    
    [self loadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [ListTableViewCell cellWithTableView:tableView andIndexpath:indexPath];
    cell.Model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.showTextBlock = ^(ListTableViewCell *Cell) {
        NSIndexPath *index = [tableView indexPathForCell:Cell];
        [tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListModel *model = self.dataArray[indexPath.row];
    if (model.isShowMore) {
        return [ListTableViewCell cellMoreHeight];
    }else{
        return [ListTableViewCell cellDefautHeight];
    }
}

- (void)loadData{
    NSString *urlStr = [NSString stringWithFormat:LIST_URL, self.course_num, self.classroom];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[HttpClient defaultClient] requestWithPath:urlStr method: HttpRequestGet parameters:nil prepareExecute:nil progress:^(NSProgress *progress) {
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr = responseObject[@"data"];
        if (arr != nil && ![arr isKindOfClass:[NSNull class]] && arr.count != 0){
            for (NSDictionary *dic in arr) {
                ListModel *model = [ListModel ListModelWithDict:dic];
                [self.dataArray addObject:model];
            }
            [self.listTab reloadData];
        }
        else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"数据错误" message:@"名单空了m(._.)m" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:act];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络错误" message:@"你的网络坏掉了m(._.)m" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
        NSLog(@"failure --- %@",error);
    }];
}


@end

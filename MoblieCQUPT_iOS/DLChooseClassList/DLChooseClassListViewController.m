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
#import <AFNetworking.h>

@interface DLChooseClassListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) UITableView *listTab;
@property(strong, nonatomic) NSMutableArray *dataArray;
@property(nonatomic, strong) NSString *classNum;
@end

@implementation DLChooseClassListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHue:0.6111 saturation:0.0122 brightness:0.9647 alpha:1.0];
    
    self.listTab = [[UITableView alloc]initWithFrame: CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65) style:UITableViewStylePlain];
    self.listTab.delegate = self;
    self.listTab.dataSource = self;
    self.listTab.backgroundColor = [UIColor clearColor];
    self.listTab.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_listTab];
    //[self initWithClassNum:@"A2010770"];
}

- (void)initWithClassNum:(NSString *)classNum{
    
    self.classNum = classNum;
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
    NSDictionary *dic = @{@"stuName": @"易烊千玺",
                          @"stuId": @"12345678",
                          @"major": @"电子信息工程",
                          @"classId": @"12345678",
                          @"school": @"通信与信息工程学院",
                          @"year": @"2017",
                          @"stuSex": @"男"
                          };
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        ListModel *model = [ListModel ListModelWithDict:dic];
        [self.dataArray addObject:model];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"ip/zhangyou01/search/kebiao/xkmd?jxb=%@",self.classNum];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr = responseObject[@"data"];
        for (NSDictionary *dic in arr) {
            ListModel *model = [ListModel ListModelWithDict:dic];
            [self.dataArray addObject:model];
        }
        [self.listTab reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"网络错误" message:@"数据加载失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act1=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [controller addAction:act1];
        
        [self presentViewController:controller animated:YES completion:^{
            
        }];
    }];
    
}


@end

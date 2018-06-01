//
//  LXAskDeatilViewController.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/5/30.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "LXAskDeatilViewController.h"
#import "LXAskTableViewCell.h"
#import "LXAskDetailModel.h"
#import <AFNetworking.h>

#define ASKURL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/ask"

@interface LXAskDeatilViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray <LXAskDetailModel *> *askDetailModelArr;

@end

@implementation LXAskDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.askDetailModelArr = [NSMutableArray array];
    [self.view addSubview:self.tableview];
    [self getData];
}


- (void) getData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameter = @{
                                @"stunum":[UserDefaultTool getStuNum],
                                @"idnum":[UserDefaultTool getIdNum],
                                @"page":@"1",
                                @"size":@"6"
                                };
    
    [manager POST:ASKURL parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"请求成功%@", responseObject);
        if ([self.solvedProblem isEqualToString:@"solvedProblem"]) {
            
            for (NSDictionary *dic in responseObject[@"data"][@"solvedProblem"]) {
                LXAskDetailModel *model = [[LXAskDetailModel alloc] initWithDic:dic];
                [self.askDetailModelArr addObject:model];
            }
            
        } else {
            for (NSDictionary *dic in responseObject[@"data"][@"notSolvedProblem"]) {
                LXAskDetailModel *model = [[LXAskDetailModel alloc] initWithDic:dic];
                [self.askDetailModelArr addObject:model];
            }
        }
        
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error:%@", error);
    }];
    
}


- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
    }
    
    return _tableview;
}


#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.askDetailModelArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110/692.0 * ScreenHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"LXAskTableViewCell";
    LXAskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[LXAskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
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

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
#import "YouWenDetailViewController.h"
#import <AFNetworking.h>

#define ASKURL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/ask"
#define HELPURL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/help"

@interface LXAskDeatilViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray <LXAskDetailModel *> *askDetailModelArr;
@property (nonatomic, strong) UIButton *askQuestionBtn;
@property (nonatomic, strong) NSString *type;

@end

@implementation LXAskDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.askDetailModelArr = [NSMutableArray array];
    [self.view addSubview:self.tableview];
    if (self.isAsk) {
        if ([self.solvedProblem isEqualToString:@"solvedProblem"]) {
            //2是已解决
            self.type = @"2";
        } else {
            self.type = @"1";
        }
    } else {
        if ([self.adoptedAnswers isEqualToString:@"adoptedAnswers"]) {
            //1是已采纳
            self.type = @"1";
        } else {
            self.type = @"2";
        }
    }
    [self getData];
}


- (void) getData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameter = @{
                                @"stunum":[UserDefaultTool getStuNum],
                                @"idnum":[UserDefaultTool getIdNum],
                                @"page":@"1",
                                @"size":@"6",
                                @"type":self.type
                                };
    
    NSString *url;
    if (self.isAsk) {
        url = ASKURL;
    } else {
        url = HELPURL;
    }
    
    [manager POST:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"请求成功%@", responseObject);
        if (self.solvedProblem) {
            if ([self.solvedProblem isEqualToString:@"solvedProblem"]) {
                
                for (NSDictionary *dic in responseObject[@"data"]) {
                    LXAskDetailModel *model = [[LXAskDetailModel alloc] initWithDic:dic];
                    [self.askDetailModelArr addObject:model];
                }
                
            } else {
                for (NSDictionary *dic in responseObject[@"data"]) {
                    LXAskDetailModel *model = [[LXAskDetailModel alloc] initWithDic:dic];
                    [self.askDetailModelArr addObject:model];
                }
            }
        } else {
            if ([self.adoptedAnswers isEqualToString:@"adoptedAnswers"]) {
                
                for (NSDictionary *dic in responseObject[@"data"]) {
                    LXAskDetailModel *model = [[LXAskDetailModel alloc] initWithDic:dic];
                    [self.askDetailModelArr addObject:model];
                }
                
            } else {
                for (NSDictionary *dic in responseObject[@"data"]) {
                    LXAskDetailModel *model = [[LXAskDetailModel alloc] initWithDic:dic];
                    [self.askDetailModelArr addObject:model];
                }
            }
        }
        
        
        
        //没有信息时的提示
        if (self.askDetailModelArr.count == 0) {
            UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH-147)/2.0, 330, 147, 40)];
            label.text = @"竟然是空的～";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14.0];
            label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.8];
            [self.view addSubview:label];
            self.askQuestionBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREENWIDTH-147)/2.0, 390, 147, 40)];
            if (self.isAsk) {
                [self.askQuestionBtn setTitle:@"去提问" forState:UIControlStateNormal];
                [self.askQuestionBtn addTarget:self action:@selector(askQuestion) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [self.askQuestionBtn setTitle:@"去回答" forState:UIControlStateNormal];
                [self.askQuestionBtn addTarget:self action:@selector(askQuestion) forControlEvents:UIControlEventTouchUpInside];
            }
            [self.askQuestionBtn setBackgroundColor:[UIColor colorWithRed:112/255.0 green:150/255.0 blue:249/255.0 alpha:1]];
            [self.view addSubview:self.askQuestionBtn];
            _tableview.tableFooterView = footerView;
        }
        
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error:%@", error);
    }];
    
}


- (void) askQuestion {
    ;
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
//        UIView *footerView = [[UIView alloc] init];
//        _tableview.tableFooterView = footerView;
        _tableview.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    }
    
    return _tableview;
}


#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.askDetailModelArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isAsk) {
        if ([self.solvedProblem isEqualToString:@"solvedProblem"]) {
            return 110/692.0 * ScreenHeight;
        } else {
            return 88/692.0 * ScreenHeight;
        }
    } else {
        return 110/692.0 * ScreenHeight;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"LXAskTableViewCell";
    LXAskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[LXAskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        if (self.isAsk) {
            cell.quesLabel.text = self.askDetailModelArr[indexPath.row].askQuesStr;
            cell.ansLabel.text = self.askDetailModelArr[indexPath.row].ansStr;
            if ([self.solvedProblem isEqualToString:@"solvedProblem"]) {
                //问一问已解决
                cell.timeLabel.text = [NSString stringWithFormat:@"解决时间：%@", self.askDetailModelArr[indexPath.row].updatedTimeStr];
            } else {
                //未解决
                cell.timeLabel.text = [NSString stringWithFormat:@"发布时间：%@", self.askDetailModelArr[indexPath.row].createdTimeStr];
            }
            
        } else {
            cell.quesLabel.text = self.askDetailModelArr[indexPath.row].helptitle;
            cell.ansLabel.text = self.askDetailModelArr[indexPath.row].helpContent;
            if ([self.adoptedAnswers isEqualToString:@"adoptedAnswers"]) {
                //帮一帮已采纳
                cell.timeLabel.text = [NSString stringWithFormat:@"采纳时间：%@", self.askDetailModelArr[indexPath.row].updatedTimeStr];
            } else {
                //未采纳
                cell.timeLabel.text = [NSString stringWithFormat:@"发布时间：%@", self.askDetailModelArr[indexPath.row].createdTimeStr];
            }
        }
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    YouWenDetailViewController *vc = [[YouWenDetailViewController alloc] init];
    vc.question_id = self.askDetailModelArr[indexPath.row].quesID;
    vc.isSelf = @"1";
    vc.questionTitle = self.askDetailModelArr[indexPath.row].askQuesStr;
    vc.hidesBottomBarWhenPushed = YES;
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
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

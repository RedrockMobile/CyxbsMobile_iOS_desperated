//
//  FYHAcademyGroupController.m
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/2.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "FYHAcademyGroupController.h"
#import "AcademyOrHometownItem.h"
#import "FYHGroupsTabelViweCell.h"
#import "WillCopy.h"

#define SEGMENTBAR_H 49
#define CELL_H 53

@interface FYHAcademyGroupController ()

//@property (nonatomic, weak) WillCopy *willCopyWindow;

@end

@implementation FYHAcademyGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToSelectedItem:) name:@"selected an academy" object:nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:247/255.0 blue:254/255.0 alpha:1];
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - TOTAL_TOP_HEIGHT - SEGMENTBAR_H - CELL_H);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    self.tableView.rowHeight = 68;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, 50)];
    label.text = @"没有更多了";
    label.textColor = [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableFooterView = label;
    
//    [self hideExcessLine:self.tableView];
    
    // 请求数据
    
    [self requestAllModelData];
}

-(void)hideExcessLine:(UITableView *)tableView{
    
    UIView *view=[[UIView alloc] init];
    view.backgroundColor=[UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - 设置模型
- (void)requestAllModelData {
    NSString *url = ACADEMYGROUPAPI;
    
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:url method:HttpRequestGet parameters:nil prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"text"]) {
            AcademyOrHometownItem *academy = [[AcademyOrHometownItem alloc] initWithDict:dict];
            [tempArray addObject:academy];
        }
        self.allModelArray = tempArray;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"model requests failed" object:nil];
    }];
}

#pragma mark - TableView 数据源

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    FYHGroupsTabelViweCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FYHGroupsTabelViweCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.allModelArray[indexPath.row].name;
    cell.groupNumber = self.allModelArray[indexPath.row].data;

    cell.backgroundColor = [UIColor colorWithRed:249/255.0 green:253/255.0 blue:255/255.0 alpha:1];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor colorWithRed:220/255.0 green:231/255.0 blue:252/255.0 alpha:1].CGColor;
    
    return cell;
}


//- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, MAIN_SCREEN_W,60.0)];
//
//    UILabel *label = [[UILabel alloc]init];
//    label.frame =CGRectMake(20,20, MAIN_SCREEN_W-40,20);
//    label.text = @"没有更多了";
//    label.textColor = [UIColor lightGrayColor];
//    label.font = [UIFont systemFontOfSize:15];
//    label.textAlignment = NSTextAlignmentCenter;
//    [footerView addSubview:label];
//
//    return footerView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0.00001f;
//}


//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    return @"没有更多了";
//}

- (void)jumpToSelectedItem:(NSNotification *)notification {
    for (int i = 0; i < self.allModelArray.count; i++) {
        if ([((AcademyOrHometownItem *)notification.userInfo[@"model"]).data isEqualToString:self.allModelArray[i].data]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            
            if (self.allModelArray.count - i <= 6) {
                [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
            } else if (i <= 6) {
                [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            } else {
                [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            }
            [self performSelector:@selector(dismissHighlight:) withObject:indexPath afterDelay:0.5];
            break;
        }
    }
}

- (void)dismissHighlight:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end


//
//  OriginazitionViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/11.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "Originazition.h"
#import "OriginazitionCell.h"
#import "PrefixHeader.pch"

#define url @"http://hongyan.cqupt.edu.cn/welcome/2017/api/apiForText.php"

@interface Originazition ()<UITableViewDelegate,UITableViewDataSource>
@property(strong, nonatomic) NSString *titleA;
@property(strong, nonatomic) NSString *resumeT;
@property(strong, nonatomic) NSMutableArray *dataArray;
@property(strong, nonatomic) UITableView *tablesView;
@property(strong, nonatomic) OriginazitionCell *cell;
@property NSInteger height;
@end

@implementation Originazition

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _height = 0;
    _tablesView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height - [UIScreen mainScreen].bounds.size.height*50/667*2 -50) style:UITableViewStylePlain];
    _tablesView.delegate = self;
    _tablesView.dataSource = self;
    self.tablesView.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
    _tablesView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self download];
}
- (void)download{
    NSDictionary *params = @{@"RequestType": @"organizations"};
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    NSMutableSet *acceptableSet = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [acceptableSet addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = acceptableSet;
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id  responseObject) {
        NSDictionary *dic = responseObject;
        _dataArray = [dic objectForKey:@"Data"][_i][@"department"];
        _titleA = [dic objectForKey:@"Data"][_i][@"name"];
        _resumeT = [dic objectForKey:@"Data"][_i][@"resume"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubview:_tablesView];
            [self.tablesView reloadData];
        });
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败了");
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [OriginazitionCell cellWithTableView:_tablesView];
    if (_i == 0) {
        _cell.namesLabel.text = _dataArray[indexPath.row][@"name"];
        _cell.detailLabel.text =_dataArray[indexPath.row][@"resume"];
        if (indexPath.row == _dataArray.count - 1) {
            _cell.cutLine.backgroundColor = [UIColor whiteColor];
            UIView *white = [[UIView alloc]initWithFrame:CGRectMake(_cell.frame.origin.x, _cell.frame.origin.y + 130, self.view.size.width, self.view.size.width/2)];
            white.backgroundColor = [UIColor whiteColor];
            [_cell.contentView addSubview:white];
        }
        return _cell;
    }
    else{
        if (indexPath.row == 0) {
            _cell.namesLabel.text = _titleA;
            _cell.detailLabel.text = _resumeT;
        }
        else{
        _cell.namesLabel.text = _dataArray[indexPath.row - 1][@"name"];
        _cell.detailLabel.text =_dataArray[indexPath.row -1][@"resume"];

        }
        if (indexPath.row == _dataArray.count ) {
            _cell.cutLine.backgroundColor = [UIColor whiteColor];
        }
        return _cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_i == 0) {
        return _dataArray.count;
    }
    else{
        return _dataArray.count + 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size;
    if (indexPath.row == 0) {
        size = [_resumeT boundingRectWithSize:CGSizeMake(SCREENWIDTH - 50, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15*SCREENWIDTH/375] }context:nil].size;
    }
    else{
        size = [_dataArray[indexPath.row -1][@"resume"] boundingRectWithSize:CGSizeMake(SCREENWIDTH - 50, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15*SCREENWIDTH/375] }context:nil].size;
    }
    return size.height + 80;
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

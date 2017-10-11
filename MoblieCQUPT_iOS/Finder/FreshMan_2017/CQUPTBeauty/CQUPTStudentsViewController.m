//
//  CQUPTStudentsViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/7.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "CQUPTStudentsViewController.h"
#import "CQUPTStudentsCell.h"
#import "UIImage+Circle.h"
#import "AppearView.h"
#import "AFNetWorking.h"



#define url @"https://wx.idsbllp.cn/welcome/2017/api/apiForText.php"

@interface CQUPTStudentsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *tableView;
@property (nonatomic, copy)NSMutableArray *dataArray;

@property (strong, nonatomic)AppearView *viewS;
@end

@implementation CQUPTStudentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc]init];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height - [UIScreen mainScreen].bounds.size.height*50/667 - 64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
    [self download];
    
    
}

- (void)download{
    NSDictionary *params = @{@"RequestType": @"excellentStu"};
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    NSMutableSet *acceptableSet = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [acceptableSet addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = acceptableSet;
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id  responseObject) {
        NSDictionary *dic = responseObject;
        _dataArray = [dic objectForKey:@"Data"];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:_tableView];
        [self.tableView reloadData];
        });
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败了");
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse = @"cell";
    CQUPTStudentsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[CQUPTStudentsCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuse];
        
    }
    
    cell.idLabel.text = _dataArray[indexPath.row][@"name"];
    NSURL *picUrl = [NSURL URLWithString:_dataArray[indexPath.row][@"url"]];

    [cell.imagesView sd_setImageWithURL:picUrl];
    cell.contextLabel.text = _dataArray[indexPath.row][@"motto"];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _viewS = [[AppearView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)WithString: _dataArray[indexPath.row][@"name"] With: _dataArray[indexPath.row][@"url"] AndContext:_dataArray[indexPath.row][@"resume"]];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    _viewS.closeImage.userInteractionEnabled = YES;
    [_viewS.closeImage addGestureRecognizer:tapRecognizer];
    [_viewS addGestureRecognizer:tapRecognizer];
    [self.view.window addSubview:_viewS];
}
- (void)tap{
    [_viewS removeFromSuperview];
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

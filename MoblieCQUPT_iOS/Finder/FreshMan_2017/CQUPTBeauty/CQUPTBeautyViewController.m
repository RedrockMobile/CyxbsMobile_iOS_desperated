//
//  CQUPTBeautyViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/8.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "CQUPTBeautyViewController.h"
#import "CQUPTBeautyCell.h"
#import "PrefixHeader.pch"
#import "BigView.h"
#define url @"https://redrock.team/welcome/2017/api/apiForText.php"

@interface CQUPTBeautyViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) NSMutableArray *dataArray;
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) CQUPTBeautyCell *cell;
@property (strong, nonatomic)NSMutableArray *nameText;
@property (strong, nonatomic)NSMutableArray *detailText;
@end

@implementation CQUPTBeautyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameText = [[NSMutableArray alloc] init];
    _detailText = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height - [UIScreen mainScreen].bounds.size.height*50/667 - 50) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self download];
}
- (void)download{
    NSDictionary *params = @{@"RequestType": @"beautyInCQUPT"};
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
    _cell = [[CQUPTBeautyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    if (!_cell) {
        _cell = [[CQUPTBeautyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
   
    NSURL *picUrl = [NSURL URLWithString:_dataArray[indexPath.row][@"url"]];
    [_cell.imagesView sd_setImageWithURL:picUrl];

    _cell.namesLabel.text = _dataArray[indexPath.row][@"title"];
    _cell.contextsLabel.text = _dataArray[indexPath.row][@"content"];
    return _cell;
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
    CGSize width = [_dataArray[indexPath.row][@"content"]boundingRectWithSize:CGSizeMake(SCREENWIDTH - 30, 200) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} context:nil].size;
    return width.height + 273;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)tap:(NSString *)image{
//    BigView *view = [BigView alloc] initWithFrame:self.view.frame AndImage:<#(NSString *)#>
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

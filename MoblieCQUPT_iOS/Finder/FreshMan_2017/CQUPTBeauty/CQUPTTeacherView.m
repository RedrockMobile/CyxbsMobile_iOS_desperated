//
//  CQUPTTeacherView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/14.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "CQUPTTeacherView.h"
#import "CQUPTTecherCell.h"
#define url @"http://hongyan.cqupt.edu.cn/welcome/2017/api/apiForText.php"
@interface CQUPTTeacherView ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) NSMutableArray *dataArray;
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) CQUPTTecherCell *cell;
@property (strong, nonatomic)NSMutableArray *nameText;
@end

@implementation CQUPTTeacherView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nameText = [[NSMutableArray alloc] init];
//    _detailText = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height - [UIScreen mainScreen].bounds.size.height*50/667 - 60) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    //    _tableView.rowHeight = UITableViewAutomaticDimension;
    [self download];
    
    // Do any additional setup after loading the view.
}

- (void)download{
    NSDictionary *params = @{@"RequestType": @"excellentTech"};
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
    _cell = [[CQUPTTecherCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    if (!_cell) {
        _cell = [[CQUPTTecherCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }

    NSString* encodedString1 = [_dataArray[indexPath.row * 2 ][@"url"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [_cell.imagesView1 sd_setImageWithURL:[NSURL URLWithString:encodedString1] placeholderImage:[UIImage imageNamed:@"placeholder"]];

    _cell.namesLabel1.text = _dataArray[indexPath.row * 2][@"name"];
    
    NSString* encodedString2 = [_dataArray[indexPath.row * 2 + 1 ][@"url"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [_cell.imagesView2 sd_setImageWithURL:[NSURL URLWithString:encodedString2] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _cell.namesLabel2.text = _dataArray[indexPath.row * 2 + 1][@"name"];
    return _cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count / 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return ((ScreenWidth  - 40)/2) + 32;
    
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

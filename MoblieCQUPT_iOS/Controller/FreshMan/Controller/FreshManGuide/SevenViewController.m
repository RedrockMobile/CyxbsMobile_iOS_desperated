//
//  SevenViewController.m
//  FreshMan
//
//  Created by dating on 16/8/12.
//  Copyright © 2016年 dating. All rights reserved.
//

#import "SevenViewController.h"
#import "SevenTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
#define url @"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/WelcomeFreshman/surroundingFood"
#define  navigationBarFrame 66
@interface SevenViewController ()
@property UITableView  *tableView;
@property(nonatomic,strong,readwrite)NSDictionary *dic;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property NSInteger LabelHight;

@end

@implementation SevenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self download];
    // Do any additional setup after loading the view.
}

- (void)download{
    AFHTTPRequestOperationManager *manger = [[AFHTTPRequestOperationManager alloc]init];
    NSMutableSet *acceptableSet = [NSMutableSet setWithSet:manger.responseSerializer.acceptableContentTypes];
    [acceptableSet addObject:@"text/html"];
    manger.responseSerializer.acceptableContentTypes = acceptableSet;
    [manger POST:url parameters:@{@"page": @0, @"size": @60} success:^(AFHTTPRequestOperation *operation, id responseObject) {
         _dic = [[NSDictionary alloc]init];
        _dic =(NSDictionary *)responseObject;
        _dataArray= _dic[@"data"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self tableview];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败了");
    }];
    
}
-(void)tableview{
    self.tableView = [[UITableView alloc]init];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tableView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height-104);
    [self.view addSubview:self.tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect rect1 =[self.dataArray[indexPath.row][@"tourroute"] boundingRectWithSize:CGSizeMake(screenSize.width - 110, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    CGRect rect2 =[self.dataArray[indexPath.row][@"introduction"] boundingRectWithSize:CGSizeMake(screenSize.width - 110, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    
    return rect1.size.height+rect2.size.height +80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SevenTableViewCell *cell = (SevenTableViewCell *)[[[NSBundle mainBundle]loadNibNamed :@"SevenTableViewCell" owner:self options:nil]  lastObject];
    cell.backgroundColor = [UIColor whiteColor];
    cell.Name.numberOfLines = 0;
    cell.adress.numberOfLines = 0;
    cell.introduce.numberOfLines = 0;
    cell.image.layer.masksToBounds = YES;
    cell.image.layer.cornerRadius = 10;
    cell.Name.text = self.dataArray[indexPath.row][@"name"];
    cell.adress.text = [NSString stringWithFormat:@"位置：%@",self.dataArray[indexPath.row][@"address"]];
    cell.introduce.text = [NSString stringWithFormat:@"简介：%@",self.dataArray[indexPath.row][@"introduction"]];
   [cell.image sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.row][@"photo"][0][@"photo_src"]]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // NSLog(@"点击的是第%ld个Cell",indexPath.row);
    
}


@end
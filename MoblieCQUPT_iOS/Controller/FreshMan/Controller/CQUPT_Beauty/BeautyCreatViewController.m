//
//  BeautyCreatViewController.m
//  FreshManFeature
//
//  Created by hzl on 16/8/11.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "BeautyCreatViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MediaPlayer/MediaPlayer.h"
#import "BeautyCreatDetailViewController.h"
#define maxScreenHeight [UIScreen mainScreen].bounds.size.height
#define maxScreenWdith [UIScreen mainScreen].bounds.size.width

#import "BeautyCreatTableViewCell.h"


@interface BeautyCreatViewController ()<UITableViewDataSource,UITableViewDelegate,NSURLSessionDataDelegate,UIWebViewDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) UIImage *videoImage;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIWebView *videoView;
@property (nonatomic, copy) NSMutableArray *dataArray;
@property (nonatomic, copy) NSDictionary *dataDict;

@end

@implementation BeautyCreatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self downLoad];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-114) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    _tableView.frame = CGRectMake(0, 114, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-114);
}


- (void)downLoad
{
    dispatch_queue_attr_t q1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/WelcomeFreshman/cquptOriginal"]];
    // 2.创建一个网络请求，分别设置请求方法、请求参数
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *args = [NSString stringWithFormat:@"page=0&size=9"];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    
    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4.根据会话对象，创建一个Task任务
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil)
        {
            self.dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            self.dataArray = [_dataDict objectForKey:@"data"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubview:_tableView];
            [self.tableView reloadData];
        });
    }];
    [sessionDataTask resume];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BeautyCreatTableViewCell *cell = [BeautyCreatTableViewCell cellWithTableView:tableView];
    
    cell.timeLabel.text = _dataArray[indexPath.row][@"time"];
    cell.timeLabel.font = [UIFont systemFontOfSize:13];
    cell.timeLabel.textColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:174/255.0 alpha:1];
    
    cell.introduceLabel.text = _dataArray[indexPath.row][@"introduction"];
    cell.introduceLabel.font = [UIFont systemFontOfSize:13];
    cell.introduceLabel.textColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:174/255.0 alpha:1];
    
    cell.idLabel.text = _dataArray[indexPath.row][@"name"];
    cell.idLabel.font = [UIFont systemFontOfSize:15];
    
    [cell.videoView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.row][@"photo"][0][@"photo_src"]]];
    cell.videoView.layer.cornerRadius = 12;
    cell.videoView.layer.masksToBounds = YES;
    cell.videoView.contentMode = UIViewContentModeScaleAspectFill;
    cell.videoView.layer.masksToBounds = YES;
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.166 * maxScreenHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BeautyCreatDetailViewController *bcdvc = [[BeautyCreatDetailViewController alloc]init];
    
    bcdvc.videoUrlStr = _dataArray[indexPath.row][@"video_url"] ?: @"";
    
    [self presentViewController:bcdvc animated:YES completion:nil];
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

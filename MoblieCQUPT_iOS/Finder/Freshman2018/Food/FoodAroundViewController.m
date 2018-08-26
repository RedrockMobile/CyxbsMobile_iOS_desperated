//
//  FoodAroundViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 陈大炮 on 2018/8/26.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "FoodAroundViewController.h"
#import "FoodAroundModel.h"
#import "FoodAroundTableViewCell.h"


@interface FoodAroundViewController ()
<UITableViewDelegate,UITableViewDataSource,clickDelegate>


@property (nonatomic, strong)UITableView *foodTab;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSDictionary *dict;
@property (nonatomic, strong)NSDictionary *datadic;
@property (nonatomic, strong)UIView *Img;     //查看大图的背景
@property (nonatomic, strong)UIImageView *Image;    //查看大图的图片
#define  SCREEN_Width [UIScreen mainScreen].bounds.size.width / 375
@end

@implementation FoodAroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self loadData];
    self.hidesBottomBarWhenPushed = YES;
    self.title = @"周边美食";
    self.view.backgroundColor = [UIColor colorWithHue:0.6111 saturation:0.0122 brightness:0.9647 alpha:1.0];
    
    self.foodTab = [[UITableView alloc]initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65) style:UITableViewStylePlain];
    self.foodTab.delegate = self;
    self.foodTab.dataSource = self;
    self.foodTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.foodTab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_foodTab];
}



- (void)loadData{
    NSLog(@"加载数据啦!");
    NSDictionary *paramter = @{
                               @"index":@"周边美食",
                               @"pagenum":@"1",
                               @"pagesize":@"10"
                               };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSString *urlStr = @"http://wx.yyeke.com/welcome2018/data/get/byindex";
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [manager GET:urlStr parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dict = responseObject;
        NSArray *arr = self.dict[@"array"];
        self.dataArray = [@[] mutableCopy];
        for (NSDictionary *dic in arr) {
            FoodAroundModel *model = [FoodAroundModel BusAndDeleModelWithDict:dic];
            [_dataArray addObject:model];
        }
        [self.foodTab reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"你的网络坏掉了m(._.)m" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"failure --- %@",error);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodAroundTableViewCell *cell = [FoodAroundTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;;
    cell.Model = self.dataArray[indexPath.row];
    cell.Index = indexPath;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodAroundModel *model = self.dataArray[indexPath.row];
    return [FoodAroundTableViewCell cellHeight:model];
}

- (void)clickAtIndex:(NSIndexPath *)indexPath andscriollViewIndex:(NSInteger)index{
    self.navigationController.navigationBar.hidden = YES;
    FoodAroundModel *model = self.dataArray[indexPath.row];
    //创建一个黑色背景
    //初始化一个用来当做背景的View。
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, -65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+65)];
    self.Img = bgView;
    [bgView setBackgroundColor:[UIColor colorWithRed:0/250.0 green:0/250.0 blue:0/250.0 alpha:1.0]];
    //[self.view addSubview:bgView];
    [self.view addSubview:bgView];
    
    //创建显示图像的视图
    //初始化要显示的图片内容的imageView
    UIImageView *browseImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    browseImgView.contentMode = UIViewContentModeScaleAspectFit;
    //要显示的图片，即要放大的图片
    browseImgView.image = model.imgArray[index-1];
    self.Image = browseImgView;
    
    [bgView addSubview:browseImgView];
    
    browseImgView.userInteractionEnabled = YES;
    //添加点击手势（即点击图片后退出全屏）
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
    [browseImgView addGestureRecognizer:tapGesture];
    
    [self shakeToShow:bgView];
    
}

-(void)closeView{
    self.navigationController.navigationBar.hidden = NO;
    [_Img removeFromSuperview];
}

- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    
    if (section == 0) {
        
            headView.backgroundColor = [UIColor redColor];
        UILabel *topLabel = [[UILabel alloc]init];
       
        topLabel.frame = CGRectMake(0, 0, SCREEN_Width * 375, 50 * SCREEN_Width);
        
        
        topLabel.textColor = [UIColor blackColor];
        NSString *str = @"   👍最受好评的top5家美食";
        topLabel.backgroundColor = [UIColor whiteColor];
        topLabel.font = [UIFont systemFontOfSize:13];
        topLabel.text = str;
        
        
        
        
        [headView addSubview:topLabel];
    }
    
    return headView;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

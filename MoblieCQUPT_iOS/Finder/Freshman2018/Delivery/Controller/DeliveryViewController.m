//
//  DeliveryViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

/*
 
 点击图片可以查看大图
 
 */

#import "DeliveryViewController.h"
#import "DeliveryModel.h"
#import "DeliveryTableViewCell.h"
#import <MBProgressHUD.h>



@interface DeliveryViewController ()<UITableViewDelegate,UITableViewDataSource,clickDelegate>
@property (nonatomic, strong) UITableView *deliveryTab;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong)UIView *Img;//查看大图的黑色背景
@property (nonatomic, strong)UIImageView *Image;//查看大图的图片

@end

@implementation DeliveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self AddPanGesture];
    [self loadData];
    self.title = @"快递收发";
    self.view.backgroundColor = [UIColor colorWithHue:0.6111 saturation:0.0122 brightness:0.9647 alpha:1.0];
    self.deliveryTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65) style:UITableViewStylePlain];
    self.deliveryTab.delegate = self;
    self.deliveryTab.dataSource = self;
    self.deliveryTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.deliveryTab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.deliveryTab];
    
}

- (void)AddPanGesture{
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)loadData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载数据中...";
    hud.color = [UIColor colorWithWhite:0.f alpha:0.4f];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSString *urlStr = @"http://wx.yyeke.com/welcome2018/data/get/byindex?index=快递收发&pagenum=1&pagesize=10";
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        NSArray *arr = dict[@"array"];
        self.dataArray = [@[] mutableCopy];
        for (NSDictionary *dic in arr) {
            DeliveryModel *model = [DeliveryModel DeleModelWithDict:dic];
            [_dataArray addObject:model];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.deliveryTab reloadData];
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
    DeliveryTableViewCell *cell = [DeliveryTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;;
    cell.Model = self.dataArray[indexPath.row];
    cell.Index = indexPath;
    cell.delegate = self;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeliveryModel *model = self.dataArray[indexPath.row];
    return [DeliveryTableViewCell cellHeight:model];
}

- (void)clickAtIndex:(NSIndexPath *)indexPath{
    
    self.navigationController.navigationBar.hidden = YES;
    DeliveryModel *model = self.dataArray[indexPath.row];
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
    browseImgView.image = model.imgarr[0];
    self.Image = browseImgView;
    
    [bgView addSubview:browseImgView];
    
    browseImgView.userInteractionEnabled = YES;
    //添加点击手势（即点击图片后退出全屏）
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
    [browseImgView addGestureRecognizer:tapGesture];
    
    [self shakeToShow:bgView];}



-(void)closeView{
    self.navigationController.navigationBar.hidden = NO;
    [_Img removeFromSuperview];
}

//放大过程中出现的缓慢动画
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
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

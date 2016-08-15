//
//  BeautyExcellentStudentViewController.m
//  FreshManFeature
//
//  Created by hzl on 16/8/11.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "BeautyExcellentStudentViewController.h"
#import "BeautyExcellentStudentCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#define maxScreenHeight [UIScreen mainScreen].bounds.size.height
#define maxScreenWdith [UIScreen mainScreen].bounds.size.width

@interface BeautyExcellentStudentViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSMutableArray *dataArray;
@property (nonatomic, copy) NSDictionary *dataDict;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *studentImageView;

@property (nonatomic, strong) UIView *imgView;

@property (nonatomic, strong) UITextView *studentIntroduce;
@property (nonatomic, strong) UILabel *studentNameLabel;

@end

@implementation BeautyExcellentStudentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self downLoad];
//    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
        
        flowLayout.itemSize = CGSizeMake(0.427 * maxScreenWdith,0.340 * maxScreenHeight);
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0.048 * maxScreenWdith, 0.027 * maxScreenHeight, 0.048 * maxScreenWdith, 0.027 * maxScreenHeight);
        
        [_collectionView registerClass:[BeautyExcellentStudentCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}

- (void)downLoad
{
    dispatch_queue_attr_t q1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/WelcomeFreshman/outstandingStudent"]];
    // 2.创建一个网络请求，分别设置请求方法、请求参数
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *args = [NSString stringWithFormat:@"page=0&size=11"];
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
            [self.view addSubview:self.collectionView];
            [self.collectionView reloadData];
            NSLog(@"%@",_dataDict);
        });
    }];
    [sessionDataTask resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    BeautyExcellentStudentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    [cell.studentImageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[indexPath.item][@"photo"][0][@"photo_thumbnail_src"]]];
    cell.studentImageView.layer.cornerRadius = 12;
    cell.studentImageView.layer.masksToBounds = YES;
    cell.studentImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.studentLabel.text = _dataArray[indexPath.item][@"name"];
    
    cell.collegeLabel.text = _dataArray[indexPath.item][@"description"];
    
    [cell sizeToFit];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [_bgView setBackgroundColor:[UIColor colorWithRed:57/255.0 green:57/255.0 blue:57/255.0 alpha:0.7]];
    [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeBigImage)]];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.139 * maxScreenWdith, 0.200 * maxScreenHeight,0.728 * maxScreenWdith, 0.68 * maxScreenHeight)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.cornerRadius = 12;
    backgroundView.layer.masksToBounds = YES;
    
    _studentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.053 * maxScreenWdith, 0.03 * maxScreenHeight, 0.619 * maxScreenWdith, 0.376 * maxScreenHeight)];
    [_studentImageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[indexPath.item][@"photo"][0][@"photo_src"]]];
    
    _studentImageView.layer.cornerRadius = 12;
    _studentImageView.layer.masksToBounds = YES;
    _studentImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _studentNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.053 * maxScreenWdith, 0.426 * maxScreenHeight, 0.619 * maxScreenWdith, 0.022 * maxScreenHeight)];
    _studentNameLabel.text = _dataArray[indexPath.item][@"name"];
    _studentNameLabel.textAlignment =  NSTextAlignmentCenter;
    
    _studentIntroduce = [[UITextView alloc] initWithFrame:CGRectMake(0.053 * maxScreenWdith, 0.47 * maxScreenHeight, 0.619 * maxScreenWdith, 0.19 * maxScreenHeight)];
    _studentIntroduce.editable = NO;
    _studentIntroduce.text = _dataArray[indexPath.item][@"introduction"];
    _studentNameLabel.textAlignment = NSTextAlignmentCenter;
    
    [backgroundView addSubview:_studentImageView];
    [backgroundView addSubview:_studentNameLabel];
    [backgroundView addSubview:_studentIntroduce];
    
    [_bgView addSubview:backgroundView];
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:_bgView];
}



- (void)removeBigImage
{
   _bgView.hidden = YES;
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

//
//  BeautyExcellentTeacherVeiewController.m
//  FreshManFeature
//
//  Created by hzl on 16/8/12.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "BeautyExcellentTeacherVeiewController.h"
#import "BeautyExcellentTeacherCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#define maxScreenHeight [UIScreen mainScreen].bounds.size.height
#define maxScreenWdith [UIScreen mainScreen].bounds.size.width


@interface BeautyExcellentTeacherVeiewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSMutableArray *dataArray;
@property (nonatomic, copy) NSDictionary *dataDict;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *teacherImageView;

@property (nonatomic, strong) UIView *imgView;

@property (nonatomic, strong) UITextView *teacherIntroduce;
@property (nonatomic, strong) UILabel *teacherNameLabel;

@end

@implementation BeautyExcellentTeacherVeiewController


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
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-114) collectionViewLayout:flowLayout];
        
        flowLayout.itemSize = CGSizeMake(0.427 * maxScreenWdith,0.340 * maxScreenHeight);
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0.048 * maxScreenWdith, 0.027 * maxScreenHeight, 0.048 * maxScreenWdith, 0.027 * maxScreenHeight);
        
        [_collectionView registerClass:[BeautyExcellentTeacherCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/WelcomeFreshman/outstandingTeacher"]];
    // 2.创建一个网络请求，分别设置请求方法、请求参数
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *args = [NSString stringWithFormat:@"page=0&size=19"];
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
//                NSLog(@"%@",_dataDict);
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
    BeautyExcellentTeacherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell.teacherImageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[indexPath.item][@"photo"][0][@"photo_thumbnail_src"]]];
    cell.teacherImageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.teacherImageView.layer.cornerRadius = 12;
    cell.teacherImageView.layer.masksToBounds = YES;
    
    cell.teacherLabel.text = _dataArray[indexPath.item][@"name"];
    
    cell.collegeLabel.text = _dataArray[indexPath.item][@"college"];
    
    [cell sizeToFit];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [_bgView setBackgroundColor:[UIColor colorWithRed:57/255.0 green:57/255.0 blue:57/255.0 alpha:0.7]];
    [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeBigImage)]];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.139 * maxScreenWdith, 0.200 * maxScreenHeight,0.728 * maxScreenWdith, 0.56 * maxScreenHeight)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.cornerRadius = 12;
    backgroundView.layer.masksToBounds = YES;
    
    _teacherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.053 * maxScreenWdith, 0.03 * maxScreenHeight, 0.619 * maxScreenWdith, 0.376 * maxScreenHeight)];
    [_teacherImageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[indexPath.item][@"photo"][0][@"photo_src"]]];
  
    _teacherImageView.layer.cornerRadius = 12;
    _teacherImageView.layer.masksToBounds = YES;
    _teacherImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _teacherNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.053 * maxScreenWdith, 0.436 * maxScreenHeight, 0.619 * maxScreenWdith, 0.022 * maxScreenHeight)];
    _teacherNameLabel.textAlignment = NSTextAlignmentCenter;
    _teacherNameLabel.text = _dataArray[indexPath.item][@"name"];

    
    _teacherIntroduce = [[UITextView alloc] initWithFrame:CGRectMake(0.053 * maxScreenWdith, 0.48 * maxScreenHeight, 0.619 * maxScreenWdith, 0.10 * maxScreenHeight)];
    _teacherIntroduce.editable = NO;
    _teacherIntroduce.text = _dataArray[indexPath.item][@"college"];
    
    [backgroundView addSubview:_teacherImageView];
    [backgroundView addSubview:_teacherNameLabel];
    [backgroundView addSubview:_teacherIntroduce];
    
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

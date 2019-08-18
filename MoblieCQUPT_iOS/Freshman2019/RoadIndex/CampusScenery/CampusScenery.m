//
//  CampusScenery.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/3.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "CampusScenery.h"
#import "SchoolMapView.h"
#import "SchoolPicView.h"
#import "SchoolPicCollectionViewCell.h"
#import "CampusSceneryModel.h"
#import <Photos/Photos.h>
@interface CampusScenery ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(strong, nonatomic)SchoolMapView *schoolMapView;
@property(strong, nonatomic)SchoolPicView *schoolPicView;
@property(strong, nonatomic)NSMutableArray<NSURL *> *imgUrlArray;
@property(strong, nonatomic)NSMutableArray<NSString *> *imgNameArray;
@property(strong, nonatomic)CampusSceneryModel *model;
@end

@implementation CampusScenery

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"校园风采";
    self.view.backgroundColor = [UIColor colorWithHexString:@"eff7ff"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(initView)
                                                 name:@"CampusSceneryDataLoadSuccess" object:nil];
    [self initModel];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)initModel{
    self.model = [[CampusSceneryModel alloc]init];
    [self.model getCampusSceneryData];
}
-(void)initView{
    [self setDataFromModel];
    [self setSchoolMapView];
    [self setSchoolPicView];
}
-(void)setSchoolMapView{
    self.schoolMapView = [[SchoolMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 285)];
    [self.schoolMapView.mapView setImageWithURL:self.model.schoolMapUrl placeholder:[UIImage imageNamed:@"SchoolPicNodataImg"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToWatch:)];
    [self.schoolMapView.mapView addGestureRecognizer:tap];
    [self.view addSubview:self.schoolMapView];
}
-(void)setSchoolPicView{
//    self.schoolPicView = [[SchoolPicView alloc]initWithFrame:CGRectMake(0, 285, self.view.width, self.view.height - 285 - TOTAL_TOP_HEIGHT - SCREEN_HEIGHT * 0.06 - TABBARHEIGHT)];
    self.schoolPicView = [[SchoolPicView alloc]initWithFrame:CGRectMake(0, 285, self.view.width, self.view.height - 285)];
    self.schoolPicView.schoolPicCollectionView.delegate = self;
    self.schoolPicView.schoolPicCollectionView.dataSource = self;
    
    [self.view addSubview:self.schoolPicView];
    [self.schoolPicView.schoolPicCollectionView registerClass:[SchoolPicCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
}
-(void)setDataFromModel{
    self.imgUrlArray = self.model.schoolPicUrlArray;
    self.imgNameArray = self.model.schoolPicNameArray;
//    self.imgNameArray = [@[@"八十万",@"八十万",@"八十万",@"八十万",@"八十万",@"八十万",@"八十万"] mutableCopy];
//    for(int i = 0;i < 6;i++){
//
//        [self.imgUrlArray addObject:[UIImage imageNamed:@"SchoolPicNodataImg"]];
//    }
//    for (NSDictionary *dic in self.model.schoolPicArray) {
//        [self.imgNameArray addObject:[dic objectForKey:@"name"]];
//        NSString *photoName = [dic objectForKey:@"photo"];
//        
//        NSString *urlString = [NSString stringWithFormat:@"%@%@",@"http://129.28.185.138:8080/zsqy/image/",photoName];
//        NSURL *url = [NSURL URLWithString:urlString];
//        //        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//        //        UIImage *image = [UIImage imageWithData:imgData];// 拿到image
//        [self.imgUrlArray addObject:url];
//    }

    
}
#pragma mark collectionView代理方法
//返回section个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 23;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SchoolPicCollectionViewCell *cell = (SchoolPicCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.titlelabel.text = self.imgNameArray[indexPath.item];
    cell.imageView.tag = indexPath.item + 1;
//    [cell.imageView setImage:self.imgUrlArray[indexPath.item]];
    
    [cell.imageView setImageWithURL:self.imgUrlArray[indexPath.item] placeholder:[UIImage imageNamed:@"SchoolPicNodataImg"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToWatch:)];
    [cell.imageView addGestureRecognizer:tap];
    
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = (self.view.width - 30)/2;
    CGSize size = CGSizeMake(width, width*0.8);
    return size;
    
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 5, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


-(void)tapToWatch:(UITapGestureRecognizer *)tap{
    //初始化全屏view
    
    if ([[UIApplication sharedApplication].keyWindow viewWithTag:999]) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:999] removeFromSuperview];
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor blackColor];
    //设置view的tag
    view.tag = 999;
    //添加手势
    UITapGestureRecognizer *tapToBackGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToBack)];
    [view addGestureRecognizer:tapToBackGesture];
    //往全屏view上添加内容
    
   
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2 - 100, SCREEN_WIDTH, 200)];
    [view addSubview:imgView];
    NSInteger index = tap.view.tag;
    UIImageView *originalImgView = tap.view;
    if(index == 0){
        [imgView setImage:originalImgView.image];
        
    }else{
        [imgView setImage:originalImgView.image];
        UILabel *indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 30, 50, 15)];
        indexLabel.text = [NSString stringWithFormat:@"%ld/%ld",index,self.imgUrlArray.count];
        indexLabel.textColor = [UIColor whiteColor];
        [view addSubview:indexLabel];
        
    }
    UIButton *downloadBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30, SCREEN_HEIGHT - 30, 15, 15)];
    downloadBtn.tag = index;
    [downloadBtn setImage:[UIImage imageNamed:@"DownloadBtn"] forState:UIControlStateNormal];
    [downloadBtn addTarget:self action:@selector(downloadMap:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:downloadBtn];
    
    
    
    //显示全屏view
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:view];
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
    //[self shakeToShow:view];
    
}



- (void)tapToBack {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *view = [window viewWithTag:999];
    [view removeFromSuperview];
}

- (void)downloadMap:(UIButton *)sender{
    
    UIImage *img;
    NSInteger index = sender.tag;
    if(index == 0){
        NSData *imgData = [NSData dataWithContentsOfURL:self.model.schoolMapUrl];
        img = [UIImage imageWithData:imgData];//
    }else{
        NSData *imgData = [NSData dataWithContentsOfURL:self.imgUrlArray[index-1]];
        img = [UIImage imageWithData:imgData];// 拿到image
        
        
    }
    UIImageWriteToSavedPhotosAlbum(img, self,  @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [self tapToBack];
    NSString *alertString;
    if (error) {
        alertString = @"图片下载失败";
    } else {
        alertString = @"图片下载成功";
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:alertString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
@end

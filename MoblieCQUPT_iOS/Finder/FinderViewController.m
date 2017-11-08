//
//  FinderViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/25.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "FinderViewController.h"
#import "FinderCollectionViewFlowLayout.h"
#import "FinderCollectionViewCell.h"
#import "LZCarouselModel.h"

@interface FinderViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet FinderCollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSArray <LZCarouselModel *> *array;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) BOOL firstLoad;
@property (nonatomic, assign) BOOL allDownload;
#define N 10000
@end

@implementation FinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstLoad = YES;
    NSArray *placeholderImageArray = @[@"cqupt1.jpg",@"cqupt2.jpg",@"cqupt3.jpg"];
    NSMutableArray *models = [NSMutableArray array];
    for (NSString *str in placeholderImageArray) {
        LZCarouselModel *model = [[LZCarouselModel alloc]init];
        model.picture = [UIImage imageNamed:str];
        [models addObject:model];
    }
    self.array = [self getCarouselModels]?:models;
    [self getNetWorkData];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
//    self.collectionView.collectionViewLayout = [[FinderCollectionViewFlowLayout alloc]init];
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.collectionView addGestureRecognizer:leftSwipeGesture];
    [self.collectionView addGestureRecognizer:rightSwipeGesture];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FinderCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"FinderCollectionViewCell"];
    // 产品的要求 一次滑动只能移动一个
    self.selectedIndex = self.array.count*N/2;
}

- (void)viewDidAppear:(BOOL)animated{
    [self addTimer];
}

- (void)viewDidDisappear:(BOOL)animated{
    [self removeTimer];
}

- (void)viewDidLayoutSubviews{
    if (self.firstLoad) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.firstLoad = NO;
    }
}

- (void)getNetWorkData{
    HttpClient *client = [HttpClient defaultClient];
    
    [client requestWithPath:Carousel_API method:HttpRequestPost parameters:@{@"pic_num": @"3"} prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:dataArray.count];
        dispatch_group_t group = dispatch_group_create();
        self.allDownload = YES;
        for (int i = 0; i<dataArray.count ; i++) {
            array[i] = @"";
            NSDictionary *data = dataArray[i];
            if(self.allDownload){
                dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
                    LZCarouselModel *model = [[LZCarouselModel alloc] initWithData:data];
                    dispatch_queue_t asynchronousQueue = dispatch_queue_create("imageDownloadQueue", NULL);
                    dispatch_async(asynchronousQueue, ^{
                        NSError *error;
                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.picture_url]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (imageData) {
                                model.imageData = imageData;
                                model.picture = [UIImage imageWithData:model.imageData];
                                array[i] = model;
                            }
                            if (error) {
                                NSLog(@"%@",error);
                                self.allDownload = NO;
                            }
                            dispatch_semaphore_signal(sema);
                        });
                    });
                    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
                });
            }
        }
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            if (self.allDownload) {
                BOOL success = YES; //避免数组中的model未被初始化
                for(LZCarouselModel *model in array){
                    if([model isEqual:@""]){
                        success = NO;
                        break;
                    }
                }
                if(success){
                    self.array = array.copy;
                    [self saveCarouselModels:array.copy];
                    [self.collectionView reloadData];
                }
            }
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

- (BOOL)saveCarouselModels:(NSArray *)array{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *infoFilePath = [path stringByAppendingPathComponent:@"CarouselPhoto"];
    return [NSKeyedArchiver archiveRootObject:array toFile:infoFilePath];
}

- (NSArray *)getCarouselModels{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *infoFilePath = [path stringByAppendingPathComponent:@"CarouselPhoto"];
    NSString *picFilePath = [path stringByAppendingPathComponent:@"CarouselPicture"];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:picFilePath error:&error];
    if (error) {
        NSLog(@"%@",error);
    } // 删除原来错误的轮播
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:infoFilePath]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LZCarouselModel *model = self.array[indexPath.row%self.array.count];
    if (!model.picture_goto_url) {
        return;
    }
    BaseViewController *vc = [[BaseViewController alloc]init];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.picture_goto_url]]];
    [vc.view addSubview:webView];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"%ld",(long)indexPath.row);
}

-(void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
}

- (void)changeImage{
    self.selectedIndex = (++self.selectedIndex)%(self.array.count*N);
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

-(void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)swipe:(UISwipeGestureRecognizer *)getsure{
    [self removeTimer];
    if (getsure.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.selectedIndex = (++self.selectedIndex)%(self.array.count*N);
    }
    else if(getsure.direction == UISwipeGestureRecognizerDirectionRight){
        self.selectedIndex = (--self.selectedIndex)%(self.array.count*N);
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self addTimer];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count*N;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (FinderCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FinderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FinderCollectionViewCell" forIndexPath:indexPath];
    cell.contentImageView.image = self.array[indexPath.row%self.array.count].picture;
    return cell;
}


- (IBAction)clickBtn:(UIButton *)sender {
    NSArray *array = @[@"HomePageViewController",@"WebViewController",@"MapViewController",@"ShopViewController",@"QuerLoginViewController",@"LostViewController",@"ShakeViewController"];
    NSString *className = array[sender.tag];
    UIViewController *viewController =  (UIViewController *)[[NSClassFromString(className) alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

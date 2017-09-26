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

@interface FinderViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet FinderCollectionViewFlowLayout *layout;
@property (strong, nonatomic) NSTimer *timer;
@property NSArray *array;
@property NSInteger selectedIndex;
@property BOOL firstLoad;
#define N 1000
@end

@implementation FinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstLoad = YES;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.collectionView addGestureRecognizer:leftSwipeGesture];
    [self.collectionView addGestureRecognizer:rightSwipeGesture];
    // 产品的要求 一次滑动只能移动一个
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FinderCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"FinderCollectionViewCell"];
    self.array = @[@"cqupt1.jpg",@"cqupt2.jpg",@"cqupt3.jpg"];
    self.selectedIndex = self.array.count*N/2;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self addTimer];
}

- (void)viewDidDisappear:(BOOL)animated{
    [self removeTimer];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
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


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.firstLoad) {
        self.layout.itemSize = CGSizeMake(self.collectionView.width-100, self.collectionView.height);
        self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.firstLoad = NO;
    }
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
    cell.contentImageView.image = [UIImage imageNamed:self.array[indexPath.row%self.array.count]];
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

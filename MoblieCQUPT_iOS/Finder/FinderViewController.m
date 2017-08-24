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
@property NSArray *array;
#define N 1000
@end

@implementation FinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"FinderCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"FinderCollectionViewCell"];
    self.array = @[@"cqupt1.jpg",@"cqupt2.jpg",@"cqupt3.jpg"];
   
//    [self.collectionView scrollToItemAtIndexPath:3*N/2 atScrollPosition:UICollectionViewScrollDirectionHorizontal animated:NO];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.layout.itemSize = CGSizeMake(self.collectionView.width-100, self.collectionView.height);
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.array.count*N/2 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];

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

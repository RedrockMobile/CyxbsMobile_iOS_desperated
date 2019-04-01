//
//  SYCFinderViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/9/26.
//  Copyright © 2018 Orange-W. All rights reserved.
//

#import "SYCFinderViewController.h"
#import "SYCPictureDisplay.h"
#import "SYCToolsCell.h"
#import "SYCCustomToolsControl.h"
#import "SYCCustomLayoutModel.h"
#import "LZCarouselModel.h"
#import "SYCToolModel.h"
#import "ExamTotalViewController.h"
#import "WebViewController.h"
#import "BeforeClassViewController.h"
#import "EmptyClassViewController.h"
#import "LZNoCourseViewController.h"
#import "CalendarViewController.h"
#import "QueryLoginViewController.h"
#import "MapViewController.h"
#import "LoginViewController.h"
#import "QuerLoginViewController.h"
#import "HttpClient.h"
#import "MBProgressHUD.h"

@interface SYCFinderViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray<LZCarouselModel *> *carouselDataArray;
@property (nonatomic, strong) SYCPictureDisplay *pictureDisplay;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *inusedTools;
@property (nonatomic, strong) UICollectionView *toolsView;
@property (nonatomic, strong) NSString *filePath;
@property BOOL allDownload;

@end

@implementation SYCFinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _allDownload = NO;
    _filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"carouselDataArray.archiver"];
    _carouselDataArray = [[NSMutableArray alloc] init];
    [self getNetworkData];
    
    self.view.backgroundColor = RGBColor(246, 246, 246, 1.0);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 1.1);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    CGFloat backgroundWidth = SCREEN_WIDTH * 0.93;
    CGFloat backgroundHeight = backgroundWidth * 1;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - backgroundWidth) / 2.0, SCREEN_WIDTH * 0.55 + 70, backgroundWidth, backgroundHeight)];
    
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.masksToBounds = YES;
    backgroundView.layer.cornerRadius = 10.0;
    [self.scrollView addSubview:backgroundView];
    

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(backgroundWidth / 3 - 7, backgroundHeight / 3 - 7);
    self.toolsView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, backgroundWidth, backgroundHeight) collectionViewLayout:layout];
    self.toolsView.backgroundColor = [UIColor whiteColor];
    self.toolsView.delegate = self;
    self.toolsView.dataSource = self;
    [self.toolsView registerClass:[SYCToolsCell class] forCellWithReuseIdentifier:@"SYCToolsCell"];
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(backgroundView.frame.origin.x + 4, backgroundView.frame.origin.y + 4, backgroundView.frame.size.width - 8, backgroundView.frame.size.height - 8)];
    shadowView.backgroundColor = [UIColor whiteColor];
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOpacity = 0.1;
    shadowView.layer.shadowOffset = CGSizeMake(0, 7);
    shadowView.layer.shadowRadius = 5;
    [backgroundView addSubview:self.toolsView];
    [_scrollView addSubview:shadowView];
    [_scrollView sendSubviewToBack:shadowView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showChannel)];
    
    self.inusedTools = [SYCCustomLayoutModel sharedInstance].inuseTools;
}

- (void)loadPicDisplay:(NSArray<LZCarouselModel *> *)picData{
        self.pictureDisplay = [[SYCPictureDisplay alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_WIDTH * 0.55) data:_carouselDataArray];
        [self.scrollView addSubview:self.pictureDisplay];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.inusedTools.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SYCToolsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYCToolsCell" forIndexPath:indexPath];
    SYCToolModel *tool = self.inusedTools[[indexPath row]];
    cell.image = [UIImage imageNamed:tool.imageName];
    cell.title = tool.title;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SYCToolModel *tool = self.inusedTools[[indexPath row]];
    if ([tool.className isEqual: @"ExamTotalViewController"]) {
        if (![UserDefaultTool getStuNum]) {
            [self tint:self];
            return;
        }
    }
    UIViewController *viewController =  (UIViewController *)[[NSClassFromString(tool.className) alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    viewController.title = tool.title;
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)showChannel{
    [[SYCCustomToolsControl shareControl] showChannelViewWithInUseTitles:self.inusedTools unUseTitles:[SYCCustomLayoutModel sharedInstance].unuseTools finish:^(NSArray *inUseTitles, NSArray *unUseTitles) {
        self.inusedTools = inUseTitles;
        [SYCCustomLayoutModel sharedInstance].inuseTools = [inUseTitles copy];
        [SYCCustomLayoutModel sharedInstance].unuseTools = [unUseTitles copy];
        [[SYCCustomLayoutModel sharedInstance] save];
        [self.toolsView reloadData];
    }];
}

- (void)tint:(UIViewController *)controller{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"是否登录？" message:@"登录后才能查看更多信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:nil];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *LVC = [[LoginViewController alloc] init];
        LVC.loginSuccessHandler = ^(BOOL success) {
            if (success) {
            }
        };
        [weakSelf presentViewController:LVC animated:YES completion:nil];
    }];
    [alertC addAction:cancel];
    [alertC addAction:confirm];
    [self presentViewController:alertC animated:YES completion:nil];
}


- (void)getNetworkData{
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:@"https://wx.idsbllp.cn/app/api/pictureCarousel.php" method:HttpRequestPost parameters:@{@"pic_num":@3} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dataArray = [responseObject objectForKey:@"data"];
        for (NSDictionary *picData in dataArray) {
            LZCarouselModel *model = [[LZCarouselModel alloc] init];
            model.picture_url = [picData objectForKey:@"picture_url"];
            model.picture_goto_url = [picData objectForKey:@"picture_goto_url"];
            model.keyword = [picData objectForKey:@"keyword"];
            [_carouselDataArray addObject:model];
        }
        [self loadPicDisplay:_carouselDataArray];
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"获取轮播图图片失败");
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

@end

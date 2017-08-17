//
//  MilitaryTrainingVideoViewController.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2017/8/13.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "MilitaryTrainingVideoViewController.h"
#import "MilitarySongCell.h"
#import "MTVideo1.h"
#import <Masonry.h>
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height

@interface MilitaryTrainingVideoViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *photosTitleArray;
@property (strong, nonatomic) NSMutableArray *photoUrlStrArray;
@property (strong, nonatomic) NSArray *videoTitleArray;
@property (strong, nonatomic) NSArray *songsArray;
@property (strong, nonatomic) NSArray *songersArray;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *blackView;
@property (strong, nonatomic) NSMutableArray *videosPhotosUrlStrArray;
@property (strong, nonatomic) NSMutableArray *videosUrlStrArray;

@end

@implementation MilitaryTrainingVideoViewController

- (void)getPhotosData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    
    [manager GET:@"http://hongyan.cqupt.edu.cn/welcome/2017/api/apiForGuide.php?RequestType=MilitaryTrainingPhoto" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseobject) {
        NSDictionary *dic = responseobject;
        for (int i = 0; i < [dic[@"Data"][@"title"] count]; i++) {
            self.photoUrlStrArray[i] = dic[@"Data"][@"url"][i];
            self.photosTitleArray[i] = dic[@"Data"][@"title"][i];
        }
        [self layoutPhotos];
        
    }failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"请求失败,error:%@", error);
    }];
    
}

- (void)getVideosData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    
    [manager GET:@"http://hongyan.cqupt.edu.cn/welcome/2017/api/apiForGuide.php?RequestType=MilitaryTrainingVideo" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseobject) {
        NSDictionary *dic = responseobject;
        for (int i = 0; i < [dic[@"Data"] count]; i++) {
            self.videosPhotosUrlStrArray[i] = dic[@"Data"][i][@"cover"];
            self.videosUrlStrArray[i] = dic[@"Data"][i][@"url"];
        }
        [self layoutVideos];
        
    }failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"请求失败,error:%@", error);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoTitleArray = @[@"重邮2016级学生军训回顾", @"重邮2016级学生军训纪实"];
    self.songsArray = @[@"强军战歌", @"咱当兵的人", @"团结就是力量", @"军中绿花", @"战友还记得吗", @"一二三四歌", @"75厘米", @"打靶归来", @"精忠报国", @"我的老班长", @"保卫黄河", @"国际歌"];
    self.songersArray = @[@"阎维文", @"刘斌",@"霍勇", @"小曾", @"小曾", @"阎维文", @"小曾", @"阎维文", @"屠洪刚", @"小曾", @"瞿弦和", @"张穆庭"];
    self.photoUrlStrArray = [[NSMutableArray alloc] init];
    self.photosTitleArray = [[NSMutableArray alloc] init];
    self.videosUrlStrArray = [[NSMutableArray alloc] init];
    self.videosPhotosUrlStrArray = [[NSMutableArray alloc] init];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if ([UIScreen mainScreen].bounds.size.width <= 330) {
        self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 170);
    }
    else {
        self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 145);
    }
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self getPhotosData];
    [self getVideosData];
    //    [self layoutVideos];
    [self layoutSongs];
}
- (void)layoutPhotos {
    UIView *photosRootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 177 / 667.0 * KHEIGHT)];
    [self.scrollView addSubview:photosRootView];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 6)];
    grayView.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
    [photosRootView addSubview:grayView];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(13, 24, 3, 16)];
    blueView.backgroundColor = [UIColor colorWithRed:88/255.0 green:177/255.0 blue:252/255.0 alpha:1];
    blueView.layer.cornerRadius = 2;
    [photosRootView addSubview:blueView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 24, 100, 16)];
    titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.text = @"军训图片";
    [photosRootView addSubview:titleLabel];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, KWIDTH, 177 / 667.0 * KHEIGHT - 40)];
    scrollView.contentSize = CGSizeMake(self.photoUrlStrArray.count * 94 / 667.0 * KHEIGHT - 5 + 28, 89 / 177.0 * 177 / 667.0 * KHEIGHT);
    [photosRootView addSubview:scrollView];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
    NSString *encodedString = @"";
    double distance = 0;
    for (int i = 0; i < 6; i++) {
        if (i == 0) {
            distance = 14;
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(distance, 13, 89 / 667.0 * KHEIGHT, 89 / 667.0 * KHEIGHT)];
            encodedString = [self.photoUrlStrArray[i] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            [image sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"占位图"]];
            image.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapImageGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enlargePhotos:)];
            [image addGestureRecognizer:tapImageGesture];
            [scrollView addSubview:image];
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(14 + (89 / 667.0 * KHEIGHT + 5) * i, 89 / 667.0 * KHEIGHT + 13 + 8, 100, 13)];
            nameLabel.centerX = image.centerX;
            nameLabel.numberOfLines = 0;
            if ([UIScreen mainScreen].bounds.size.width <= 330) {
                nameLabel.font = [UIFont systemFontOfSize:10];
            }
            else {
                nameLabel.font = [UIFont systemFontOfSize:13];
            }
            nameLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            nameLabel.text = self.photosTitleArray[i];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            [scrollView addSubview:nameLabel];
            image.tag = i;
            
        } else {
            distance = 5;
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(14 + (89 / 667.0 * KHEIGHT + 5) * i, 13, 89 / 667.0 * KHEIGHT, 89 / 667.0 * KHEIGHT)];
            encodedString = [self.photoUrlStrArray[i] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            image.tag = i;
            [image sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"占位图"]];
            image.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapImageGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enlargePhotos:)];
            [image addGestureRecognizer:tapImageGesture];
            [scrollView addSubview:image];
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(14 + (89 / 667.0 * KHEIGHT + 5) * i, 89 / 667.0 * KHEIGHT + 13 + 8, 100, 13)];
            nameLabel.centerX = image.centerX;
            nameLabel.numberOfLines = 0;
            if ([UIScreen mainScreen].bounds.size.width <= 330) {
                nameLabel.font = [UIFont systemFontOfSize:10];
            }
            else {
                nameLabel.font = [UIFont systemFontOfSize:13];
            }
            nameLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            nameLabel.text = self.photosTitleArray[i];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            [scrollView addSubview:nameLabel];
        }
    }
}

- (void)layoutVideos {
    UIView *videosRootView = [[UIView alloc] initWithFrame:CGRectMake(0, 177 / 667.0 * KHEIGHT, KWIDTH, 194 / 667.0 * KHEIGHT)];
    [self.scrollView addSubview:videosRootView];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 6)];
    grayView.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
    [videosRootView addSubview:grayView];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(13, 24, 3, 16)];
    blueView.backgroundColor = [UIColor colorWithRed:88/255.0 green:177/255.0 blue:252/255.0 alpha:1];
    blueView.layer.cornerRadius = 2;
    [videosRootView addSubview:blueView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 24, 100, 16)];
    titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.text = @"军训视频";
    [videosRootView addSubview:titleLabel];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(14, 52, 375/2.0-3-14, 106/667.0 * KHEIGHT)];
    NSString *encodeString = [self.videosPhotosUrlStrArray[0] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [imageView1 sd_setImageWithURL:[NSURL URLWithString:encodeString] placeholderImage:[UIImage imageNamed:@"占位图"]];
    imageView1.userInteractionEnabled = YES;
    imageView1.tag = 1;
    [videosRootView addSubview:imageView1];
    UIImageView *pauseImageView1 = [[UIImageView alloc] init];
    [imageView1 addSubview:pauseImageView1];
    pauseImageView1.image = [UIImage imageNamed:@"pause"];
    [pauseImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView1.mas_left).offset((KWIDTH/2.0 -3 - 14) / 2.0 - 15);
        make.top.equalTo(imageView1.mas_top).offset(106/667.0*KHEIGHT/2.0 - 15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(14 + 375/2.0-3-14 + 6, 52, 375/2.0-3-14, 106/667.0 * KHEIGHT)];
    NSString *encodeString2 = [self.videosPhotosUrlStrArray[1] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [imageView2 sd_setImageWithURL:[NSURL URLWithString:encodeString2] placeholderImage:[UIImage imageNamed:@"占位图"]];
    imageView2.userInteractionEnabled = YES;
    imageView2.tag = 2;
    [videosRootView addSubview:imageView2];
    UIImageView *pauseImageView2 = [[UIImageView alloc] init];
    [imageView2 addSubview:pauseImageView2];
    pauseImageView2.image = [UIImage imageNamed:@"pause"];
    [pauseImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView2.mas_left).offset((KWIDTH/2.0 -3 - 14) / 2.0 - 15);
        make.top.equalTo(imageView2.mas_top).offset(106/667.0*KHEIGHT/2.0 - 15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 52 + 106/667.0 * KHEIGHT + 8, 150, 13)];
    nameLabel.centerX = imageView1.centerX;
    nameLabel.numberOfLines = 0;
    if ([UIScreen mainScreen].bounds.size.width <= 330) {
        nameLabel.font = [UIFont systemFontOfSize:10];
    }
    else {
        nameLabel.font = [UIFont systemFontOfSize:13];
    }
    nameLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    nameLabel.text = @"重邮2016级学生军训回顾";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [videosRootView addSubview:nameLabel];
    
    
    UILabel *nameLabe2 = [[UILabel alloc] initWithFrame:CGRectMake(14 + 375/2.0-3-14 + 6, 52 + 106/667.0 * KHEIGHT + 8, 150, 13)];
    nameLabe2.centerX = imageView2.centerX;
    nameLabe2.numberOfLines = 0;
    if ([UIScreen mainScreen].bounds.size.width <= 330) {
        nameLabe2.font = [UIFont systemFontOfSize:10];
    }
    else {
        nameLabe2.font = [UIFont systemFontOfSize:13];
    }
    nameLabe2.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    nameLabe2.text = @"重邮2016级学生军训纪实";
    nameLabe2.textAlignment = NSTextAlignmentCenter;
    [videosRootView addSubview:nameLabe2];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadVideo:)];
    [imageView1 addGestureRecognizer:tapGesture];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadVideo:)];
    [imageView2 addGestureRecognizer:tapGesture2];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(videosRootView.mas_left).offset(13);
        make.top.mas_equalTo(titleLabel.mas_top);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(16);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(videosRootView.mas_top).offset(24);
        make.height.mas_equalTo(blueView.height);
        make.left.equalTo(blueView.mas_right).offset(9);
        make.right.equalTo(@0);
    }];
    
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(imageView2.mas_left).offset(-10);
        make.top.equalTo(titleLabel.mas_bottom).offset(13);
        make.bottom.equalTo(nameLabel.mas_top).offset(-8);
    }];
    
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(titleLabel.mas_bottom).offset(13);
        make.bottom.equalTo(nameLabel.mas_top).offset(-8);
        make.width.equalTo(imageView1.mas_width);
        make.height.mas_equalTo(imageView1.height);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(imageView1);
        make.bottom.equalTo(videosRootView.mas_bottom).offset(-10);
        make.height.equalTo(@13);
    }];
    
    [nameLabe2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(imageView2);
        make.height.equalTo(@13);
        
        make.bottom.equalTo(videosRootView.mas_bottom).offset(-10);
    }];
    
    
    
}

- (void)layoutSongs {
    //    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 177 / 667.0 * KHEIGHT + 194 / 667.0 * KHEIGHT, KWIDTH, KHEIGHT - (177 / 667.0 * KHEIGHT + 194 / 667.0 * KHEIGHT) - 47 - 64)];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 177 / 667.0 * KHEIGHT + 194 / 667.0 * KHEIGHT, KWIDTH, 600)];
    self.tableView = tableView;
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionHeaderHeight = 0;
    _tableView.sectionFooterHeight = 0;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.scrollView addSubview:tableView];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 45)];
    headerView.backgroundColor = [UIColor whiteColor];
    tableView.tableHeaderView = headerView;
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 6)];
    grayView.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
    [headerView addSubview:grayView];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(13, 24, 3, 16)];
    blueView.backgroundColor = [UIColor colorWithRed:88/255.0 green:177/255.0 blue:252/255.0 alpha:1];
    blueView.layer.cornerRadius = 2;
    [headerView addSubview:blueView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 24, 100, 16)];
    titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.text = @"军歌推荐";
    [headerView addSubview:titleLabel];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowInSection:(NSInteger)section {
    return 37;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"MilitarySong";
    MilitarySongCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MilitarySongCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.number1.font = cell.number2.font = [UIFont systemFontOfSize:12];
    cell.number1.textColor = cell.number2.textColor = [UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1];
    
    if ([UIScreen mainScreen].bounds.size.width <= 330) {
        cell.song1.font = cell.song2.font = [UIFont systemFontOfSize:10];
        cell.songer1.font = cell.songer2.font = [UIFont systemFontOfSize:8];
    }
    else {
        cell.song1.font = cell.song2.font = [UIFont systemFontOfSize:13];
        cell.songer1.font = cell.songer2.font = [UIFont systemFontOfSize:11];
    }
    cell.song1.textColor = cell.song2.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    cell.song1.text = self.songsArray[indexPath.row * 2];
    cell.song2.text = self.songsArray[indexPath.row * 2 + 1];
    
    
    cell.songer1.textColor = cell.songer2.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    cell.songer1.text = self.songersArray[indexPath.row * 2];
    cell.songer2.text = self.songersArray[indexPath.row * 2 + 1];
    
    if (indexPath.row < 4) {
        cell.number1.text = [NSString stringWithFormat:@"0%ld", indexPath.row*2 + 1];
        cell.number2.text = [NSString stringWithFormat:@"0%ld", indexPath.row*2 + 2];
    }
    else if (indexPath.row == 4) {
        cell.number1.text = [NSString stringWithFormat:@"0%ld", indexPath.row*2 + 1];
        cell.number2.text = [NSString stringWithFormat:@"%ld", indexPath.row*2 + 2];
    } else {
        cell.number1.text = [NSString stringWithFormat:@"%ld", indexPath.row*2 + 1];
        cell.number2.text = [NSString stringWithFormat:@"%ld", indexPath.row*2 + 2];
    }
    
    
    return cell;
}

- (void)loadVideo:(UITapGestureRecognizer *)sender {
    if (sender.view.tag == 1) {
        [self.view.superview.viewController.navigationController pushViewController:[[MTVideo1 alloc] initWithVideoUrlStr:self.videosUrlStrArray[0]] animated:YES];
    } else if (sender.view.tag == 2) {
        [self.view.superview.viewController.navigationController pushViewController:[[MTVideo1 alloc] initWithVideoUrlStr:self.videosUrlStrArray[1]] animated:YES];
    }
}

- (void)enlargePhotos:(UIGestureRecognizer *)sender {
    UIView *view = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    self.blackView = view;
    view.tag = 999;
    view.backgroundColor = [UIColor blackColor];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:view];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2.0 - 251/667.0 * [UIScreen mainScreen].bounds.size.height / 2.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - ([UIScreen mainScreen].bounds.size.height / 2.0 - 251/667.0 * [UIScreen mainScreen].bounds.size.height / 2.0))];
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 6, 251/667.0 * [UIScreen mainScreen].bounds.size.height + 80);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * sender.view.tag, 0)];
    
    [view addSubview:scrollView];
    
    for (int i = 0; i < 6; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, 251/667.0 * [UIScreen mainScreen].bounds.size.height)];
        
        NSString *encodedString = [self.photoUrlStrArray[i] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:encodedString]];
        [scrollView addSubview:imageView];
        
        UILabel *descritionLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width + ([UIScreen mainScreen].bounds.size.width / 2.0 - 36), 251/667.0 * [UIScreen mainScreen].bounds.size.height + 25, 72, 15)];
        descritionLabel.font = [UIFont systemFontOfSize:13];
        descritionLabel.text = self.photosTitleArray[i];
        descritionLabel.textAlignment = NSTextAlignmentCenter;
        descritionLabel.textColor = [UIColor whiteColor];
        [scrollView addSubview:descritionLabel];
    }
    
    
    UILabel *numberOfPhotos = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0 - 20, 31, 40, 20)];
    numberOfPhotos.textColor = [UIColor whiteColor];
    numberOfPhotos.tag = 111;
    numberOfPhotos.font = [UIFont systemFontOfSize:17];
    [view addSubview:numberOfPhotos];
    
    [self scrollViewDidScroll:scrollView];
    
    //返回手势
    UITapGestureRecognizer *tapToBackGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToBack)];
    [view addGestureRecognizer:tapToBackGesture];
}

- (void)tapToBack {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *view = [window viewWithTag:999];
    [view removeFromSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int i = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    UILabel *label = [self.blackView viewWithTag:111];
    label.text = [NSString stringWithFormat:@"%d/6", i + 1];
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

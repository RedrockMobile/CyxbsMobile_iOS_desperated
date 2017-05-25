//
//  TopicSearchViewController.m
//  TopicSearch
//
//  Created by hzl on 2017/5/21.
//  Copyright © 2017年 hzl. All rights reserved.
//

#import "TopicSearchViewController.h"
#import "TopicSearchCollectionViewCell.h"
#import "TopicRequest.h"
#import "MJRefresh.h"


#define font(R) (R)*([UIScreen mainScreen].bounds.size.width)/375.0
#define autoSizeScaleX [UIScreen mainScreen].bounds.size.width/375.0
#define autoSizeScaleY [UIScreen mainScreen].bounds.size.height/667.0

CG_INLINE CGRect
CHANGE_CGRectMake(CGFloat x, CGFloat y,CGFloat width,CGFloat height){
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}


@interface TopicSearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, assign) NSInteger pageCount;

@property (nonatomic, assign) NSInteger oldDataCount;

@property (nonatomic, assign) CGFloat marginTop;

@end

@implementation TopicSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self setupRefresh];
    [self dataRefresh];
}

- (NSString *)searchText{
    if (!_searchText) {
        _searchText = [[NSString alloc] init];
    }
    return _searchText;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CHANGE_CGRectMake(0, 0, 375, 667) collectionViewLayout:flowLayout];

        flowLayout.itemSize = CGSizeMake(165 * autoSizeScaleX, 138 * autoSizeScaleY);
        
        flowLayout.sectionInset = UIEdgeInsetsMake(12.5, 12.5, 12.5, 12.5);
        
        [_collectionView registerClass:[TopicSearchCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}

- (void)setupRefresh{
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerrefreshing)];
}

#pragma mark - 网络请求相关

- (void)startTimer{
    NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(
                      endRefresh) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)endRefresh{
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView.mj_header endRefreshing];
}

- (void)headerRefreshing{
    [self startTimer];
    TopicRequest *tReq = [[TopicRequest alloc] init];
    if (self.isMyJoin) {
        if (self.searchText.length) {
            [tReq requestMyJoinTopicDataWithSize:@"10" page:@"0" stuNum:@"2015212247" idNum:@"273918" searchText:self.searchText];
            tReq.myJoinBlk = ^(NSDictionary *dic){
                [_data removeAllObjects];
                [_data addObjectsFromArray:dic[@"data"]];
                _oldDataCount = _data.count;
                [_collectionView reloadData];
                [_collectionView.mj_header endRefreshing];
            };
        }else{
            [tReq requestMyJoinTopicDataWithSize:@"10" page:@"0" stuNum:@"2015212247" idNum:@"273918" searchText:nil];
            tReq.myJoinBlk = ^(NSDictionary *dic){
                _data = [[NSMutableArray alloc] init];
                [_data addObjectsFromArray:dic[@"data"]];
                _oldDataCount = _data.count;
                [_collectionView reloadData];
                [_collectionView.mj_header endRefreshing];
            };
        }
    }else{
        if (self.searchText.length) {
            [tReq requestTopicDataWithSize:@"10" page:@"0" searchText:self.searchText];
            tReq.topicBlk = ^(NSDictionary *dic){
                _data  =[[NSMutableArray alloc] init];
                [_data addObjectsFromArray:dic[@"data"]];
                _oldDataCount = _data.count;
                [_collectionView reloadData];
                [_collectionView.mj_header endRefreshing];
            };
        }else{
            [tReq requestTopicDataWithSize:@"10" page:@"0" searchText:nil];
            tReq.topicBlk = ^(NSDictionary *dic){
                _data  =[[NSMutableArray alloc] init];
                [_data addObjectsFromArray:dic[@"data"]];
                _oldDataCount = _data.count;
                [_collectionView reloadData];
                [_collectionView.mj_header endRefreshing];
            };
        }
    }
    _pageCount = 0;
//    [_collectionView.mj_header endRefreshing];
}

- (void)footerrefreshing{
    [self startTimer];
    _pageCount += 1;
    TopicRequest *tReq = [[TopicRequest alloc] init];
    if (self.isMyJoin) {
        if (self.searchText.length) {
            [tReq requestMyJoinTopicDataWithSize:@"10" page:[NSString stringWithFormat:@"%ld",(long)_pageCount] stuNum:@"2015212247" idNum:@"273918" searchText:self.searchText];
            tReq.myJoinBlk = ^(NSDictionary *dic){
                [_data addObjectsFromArray:dic[@"data"]];
                [self.collectionView reloadData];
                if (_data.count==_oldDataCount) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.collectionView.mj_footer endRefreshing];
                }
            };
        }else{
            [tReq requestMyJoinTopicDataWithSize:@"10" page:[NSString stringWithFormat:@"%ld",(long)_pageCount] stuNum:@"2015212247" idNum:@"273918" searchText:nil];
            tReq.myJoinBlk = ^(NSDictionary *dic){
                [_data addObjectsFromArray:dic[@"data"]];
                [self.collectionView reloadData];
                if (_data.count==_oldDataCount) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.collectionView.mj_footer endRefreshing];
                }
            };
        }
    }else{
        if (self.searchText.length) {
            [tReq requestTopicDataWithSize:@"10" page:[NSString stringWithFormat:@"%ld",(long)_pageCount] searchText:self.searchText];
            tReq.topicBlk = ^(NSDictionary *jsonDic){
                [_data addObjectsFromArray:jsonDic[@"data"]];
                [self.collectionView reloadData];
                if (_data.count == _oldDataCount) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.collectionView.mj_footer endRefreshing];
                }
            };
            
        }else{
            [tReq requestTopicDataWithSize:@"10" page:[NSString stringWithFormat:@"%ld",(long)_pageCount] searchText:nil];
            tReq.topicBlk = ^(NSDictionary *jsonDic){
                [_data addObjectsFromArray:jsonDic[@"data"]];
                [self.collectionView reloadData];
                if (_data.count == _oldDataCount) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.collectionView.mj_footer endRefreshing];
                }
            };
        }
    }
//    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
}

- (void)searchDataRefresh{
    TopicRequest *tReq = [[TopicRequest alloc] init];
    [[self.collectionView.subviews lastObject] removeFromSuperview];
    if (self.isMyJoin) {
        [tReq requestMyJoinTopicDataWithSize:@"10" page:@"0" stuNum:@"2015212247" idNum:@"273918" searchText:self.searchText];
        tReq.myJoinBlk = ^(NSDictionary *dic){
            [_data removeAllObjects];
            [_data addObjectsFromArray:dic[@"data"]];
            _oldDataCount = _data.count;
            [_collectionView reloadData];
            if (_data.count==0) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noTopicIcon.png"]];
                imageView.frame = CHANGE_CGRectMake(50, 100, 467,379);
                [self.collectionView addSubview:imageView];
            }
        };
    }else{
        [tReq requestTopicDataWithSize:@"10" page:@"0" searchText:self.searchText];
        tReq.topicBlk = ^(NSDictionary *dic){
            [_data removeAllObjects];
            [_data addObjectsFromArray:dic[@"data"]];
            _oldDataCount = _data.count;
            [_collectionView reloadData];
            if (_data.count==0) {
                  UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noTopicIcon.png"]];
                imageView.frame = CHANGE_CGRectMake(50, 100, 467,379);
                [self.collectionView addSubview:imageView];
            }
        };
    }
    self.pageCount = 0;
}

- (void)dataRefresh{
    TopicRequest *tReq = [[TopicRequest alloc] init];
    if (self.isMyJoin) {
        [tReq requestMyJoinTopicDataWithSize:@"10" page:@"0" stuNum:@"2015212247" idNum:@"273918" searchText:nil];
        tReq.myJoinBlk = ^(NSDictionary *dic){
            _data = [[NSMutableArray alloc] init];
            [_data addObjectsFromArray:dic[@"data"]];
            _oldDataCount = _data.count;
            [_collectionView reloadData];
        };
    }else{
        [tReq requestTopicDataWithSize:@"10" page:@"0" searchText:nil];
        tReq.topicBlk = ^(NSDictionary *dic){
            _data  =[[NSMutableArray alloc] init];
            [_data addObjectsFromArray:dic[@"data"]];
            _oldDataCount = _data.count;
            [_collectionView reloadData];
        };
    }
    self.pageCount = 0;
}

#pragma mark - collectionView相关
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   //在这里设置好控制器后调用block
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TopicRequest *tReq = [[TopicRequest alloc] init];
    static NSString *identify = @"cell";
    TopicSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [tReq requestImageForImageView:cell.bgImageView withUrlStr:_data[indexPath.item][@"img_small_src"]];
    cell.titleLabel.text = [NSString stringWithFormat:@"#%@#",_data[indexPath.item][@"keyword"]];
    cell.attendNumLabel.text = [NSString stringWithFormat:@"%@人参与",_data[indexPath.item][@"join_num"]];
    return cell;
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

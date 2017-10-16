//
//  EmptyClassViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/10/5.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "EmptyClassViewController.h"
#import "EmptyClassView.h"
#import "BaseViewController.h"

@interface EmptyClassViewController ()<UIScrollViewDelegate>
//选择栏
@property (strong, nonatomic) EmptyClassView *views;
//数据项
@property (strong, nonatomic) NSDictionary *FinalData;
@property (strong, nonatomic) NSArray *sameArray;
@property (strong, nonatomic) NSMutableArray<UIView *>
 *viewArry;
@property (strong, nonatomic) NSDictionary *dataDic;
@property (strong, nonatomic) UIScrollView *scrollView;
//记录scrollview位置
@property (nonatomic, assign) NSInteger lastcontentOffset;
@end

@implementation EmptyClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _views = [[EmptyClassView alloc] initWithFrame:CGRectMake(0,0, SCREENWIDTH, 181)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:_views];
    [self.views.handleBtn addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    //选择项完成收到通知
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _views.bottom + 10, SCREENWIDTH, SCREENHEIGHT)];
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT + _views.height);
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.decelerationRate = 0;
    [_scrollView flashScrollIndicators];
    [self.view addSubview:_scrollView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(readyToLoad:) name:@"checkReady" object:nil];
    UISwipeGestureRecognizer * recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.view addGestureRecognizer:recognizer];
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:recognizer];
  
}
//滑动监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"selected"]&&object == _views.handleBtn) {
        [self moveTheView:_views.handleBtn.selected];
    }
}
//滑动动画
- (void)moveTheView:(BOOL)selected{
    if (selected == NO) {
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint point = self.view.center;
            point.y -=  181;
            self.view.center = point;
        }];
    }
    else{
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint point = self.view.center;
            point.y +=  181;
            self.view.center = point;
        }];
    }
}
#pragma marks 数据处理
//开始处理数据
-(void)readyToLoad:(NSNotification *)notification{
    _dataDic = notification.object;
    NSArray *dataArry = _dataDic[@"sectionNum"];
    if (dataArry.count == 0) {
        for (UIView *view in _viewArry) {
            [view removeAllSubviews];
        }
        _viewArry = nil;
        _viewArry = [NSMutableArray array];
    }
    else{
        if(!_viewArry){
            _viewArry = [NSMutableArray array];
        }
        else{
            for (UIView *view in _viewArry) {
                [view removeFromSuperview];
            }
            _viewArry = nil;
            _viewArry = [NSMutableArray array];
        }
        if (dataArry.count > 1) {
            [self loadSameData:(NSDictionary *)_dataDic];
        }
        else{
            [NetWork NetRequestPOSTWithRequestURL:EMPTYCLASSAPI WithParameter:_dataDic WithReturnValeuBlock:^(id returnValue) {
                _FinalData = [self handleData:returnValue[@"data"]];
                [self setUpDataView:_FinalData];
            } WithFailureBlock:^{
                [[NSNotificationCenter defaultCenter]postNotificationName:@"data" object:nil];
            }];
        }
  }
}
//多个选择时
-(void)loadSameData:(NSDictionary *)dic{
    NSArray *dataArry = [NSArray array];
    _sameArray = [NSArray array];
    dataArry = dic[@"sectionNum"];
    for (int i = 0; i < dataArry.count; i ++) {
        NSMutableDictionary *dataDic = dic.mutableCopy;
        dataDic[@"sectionNum"] = dataArry[i];
        [NetWork NetRequestPOSTWithRequestURL:EMPTYCLASSAPI WithParameter:dataDic WithReturnValeuBlock:^(id returnValue) {
            [self settingSameArray:returnValue[@"data"]];
            if (i == dataArry.count - 1) {
                _FinalData = [self handleData:_sameArray];
                [self setUpDataView:_FinalData];
            }
        } WithFailureBlock:^{

        }];

    }
}
-(void)settingSameArray:(NSArray *)sameArray{
    if(_sameArray.count == 0){
        _sameArray = sameArray;
    }
    else{
        NSMutableSet *set1 = [NSMutableSet setWithArray:sameArray];
        NSMutableSet *set2 = [NSMutableSet setWithArray:_sameArray];
        [set1 intersectSet:set2];
        NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
        _sameArray = [set1 sortedArrayUsingDescriptors:sortDesc];
    }
}
//加载View
- (void)setUpDataView:(NSDictionary *)dic{
    NSMutableArray * allkeys = [dic allKeys].mutableCopy;
    [allkeys sortUsingSelector:@selector(compare:)];
    for (int i = 0; i < allkeys.count; i++)
    {
        NSString * key = [allkeys objectAtIndex:i];
        UIView *dataView;
        NSArray *dicArry = dic[key];
        CGFloat highOfView = (dicArry.count / 4 ) * 30 + 58;
        if (dicArry.count != 0) {
            dataView = [self dataView:dic[key] With:key];
        }
        else{
            continue;
        }
        if (_viewArry.count == 0) {
            dataView.frame = CGRectMake(0, 31, SCREENWIDTH, highOfView);
        }
        else{
            dataView.frame = CGRectMake(0, _viewArry[_viewArry.count - 1].bottom, SCREENWIDTH, highOfView);
        }
        [_viewArry addObject:dataView];
        [self.scrollView addSubview:dataView];
    }
}

#pragma marks 数据处理
- (UIView *)dataView:(NSArray *)arry With:(NSString *)key{
    UIView *dataView = [[UIView alloc]init];
    NSArray *floorArry = @[@"一楼",@"二楼",@"三楼",@"四楼",@"五楼"];
    NSArray *eightFloorArry = @[@"一栋",@"二栋",@"三栋",@"四东",@"五栋"];
    UIImageView *besidesView = [[UIImageView alloc]initWithFrame:CGRectMake(31, 31, 2, 13)];
    besidesView.image = [UIImage imageNamed:@"ImageBesidesTheEmptyClass"];
    [dataView addSubview:besidesView];
    UILabel *floorLab = [[UILabel alloc]initWithFrame:CGRectMake(besidesView.right + 8, besidesView.centerY - 8.5, 29, 17)];
    floorLab.font = [UIFont systemFontOfSize:14];
    if([_dataDic[@"buildNum"] isEqualToString:@"8"]){
         floorLab.text = eightFloorArry[key.intValue - 1];
    }
    else{
        floorLab.text = floorArry[key.intValue - 1];
    }
    [floorLab sizeToFit];
    [dataView addSubview:floorLab];
    NSMutableArray<UILabel *> *labArry = [NSMutableArray array];
    for (int i = 0; i < arry.count ; i++) {
        CGRect rect;
        if (i % 4 == 0) {
            if (i == 0){
                rect = CGRectMake(floorLab.right + 29, besidesView.centerY - 8.5, 0, 0);
            }
            else{
                rect = CGRectMake(floorLab.right + 29, besidesView.centerY - 8.5 + (labArry[0].bottom - 21) * (i / 4), 0, 0);
            }
        }
        else{
            rect =  CGRectMake(labArry[i % 4 - 1].right + 29, besidesView.centerY - 8.5 + (labArry[0].bottom - 21) * (i / 4), 0, 0);
        }
        UILabel *lab = [[UILabel alloc]init];
        lab.font = [UIFont fontWithName:@"Helvetica"  size:16];
        lab.frame = rect;
        lab.text = arry[i];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:arry[i]];
        NSRange range;
        if([_dataDic[@"buildNum"] isEqualToString:@"8"]){
            range = NSMakeRange(3, 1);
        }
        else{
            range = NSMakeRange(2, 2);
        }
        [noteStr addAttribute:NSForegroundColorAttributeName value: [UIColor colorWithRed:97/255.0 green:151/255.0 blue:248/255.0 alpha:1/1.0] range:range];
        [lab setAttributedText:noteStr];
        [lab sizeToFit];
        [labArry addObject:lab];
        [dataView addSubview:lab];
    }
    return dataView;
}

- (NSDictionary *)handleData:(NSArray *)array {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *array1 = @[@"1",@"2",@"3",@"4",@"5"];
    for (int i = 0; i < array1.count; i ++) {
        NSMutableArray *newArray = [NSMutableArray array];
        for (int j = 0; j < array.count; j++) {
            NSString *string = [array[j] substringWithRange:NSMakeRange(1, 1)];
            if ([string isEqualToString:array1[i]]) {
                [newArray addObject:array[j]];
            }
        }
        [dic setObject:newArray forKey:array1[i]];
    }
    return dic;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionUp&&_views.handleBtn.selected) {
        _views.handleBtn.selected = !_views.handleBtn.selected;
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown&&!_views.handleBtn.selected) {
        _views.handleBtn.selected = !_views.handleBtn.selected;
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if(targetContentOffset->y > 20&&scrollView.contentOffset.y <20){
        [UIView animateWithDuration:1 animations:^{
            targetContentOffset->y = 20;
        }];
    }
    else{
        [UIView animateWithDuration:1 animations:^{
            targetContentOffset->y = (targetContentOffset->y - scrollView.contentOffset.y) / 5 + scrollView.contentOffset.y;
        }];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentOffset = scrollView.contentOffset.y;
    CGFloat offset = contentOffset - self.lastcontentOffset;
    self.lastcontentOffset = contentOffset;
    if (offset > 0 && contentOffset > 0&&_views.handleBtn.selected) {
        _views.handleBtn.selected = !_views.handleBtn.selected;
    }
    if (contentOffset == 0&&!_views.handleBtn.selected) {
         _views.handleBtn.selected = !_views.handleBtn.selected;
    }
}

-(void)dealloc{
    [self.views.handleBtn removeObserver:self forKeyPath:@"selected" context:nil];
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

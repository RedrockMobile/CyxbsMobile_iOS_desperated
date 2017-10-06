//
//  TopicViewController.m
//  TopicSearch
//
//  Created by hzl on 2017/5/22.
//  Copyright © 2017年 hzl. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicSearchViewController.h"
#import "SegmentView.h"
#import "DetailTopicViewController.h"

#define font(R) (R)*([UIScreen mainScreen].bounds.size.width)/375.0
CG_INLINE CGRect
CHANGE_CGRectMake(CGFloat x, CGFloat y,CGFloat width,CGFloat height){
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}

@interface TopicViewController ()<UISearchBarDelegate,SegmentViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) SegmentView *segementView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) TopicSearchViewController *joinVC;

@property (nonatomic, strong) TopicSearchViewController *allVC;

@property NSInteger currentIndex;
@end

@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSearchBar];
    [self addSegemenView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [self hideKeyBoard];
    }];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

- (void)addSearchBar{
    UIView *bgView = [[UIView alloc] initWithFrame:CHANGE_CGRectMake(0, 0, 375, HEADERHEIGHT)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CHANGE_CGRectMake(50, 30, 300, 30)];
    self.searchBar.searchBarStyle = UISearchBarStyleProminent;

    self.searchBar.tintColor = [UIColor whiteColor];
    self.searchBar.placeholder = @"搜索更多话题";
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
//    [bgView addSubview:self.searchBar];
    
    [self.view addSubview:bgView];
}


- (void)addSegemenView{
    self.joinVC = [[TopicSearchViewController alloc] init];
    self.joinVC.isMyJoin = YES;
    self.joinVC.title = @"我参与的";
    __weak typeof(self) weakSelf = self;
    self.joinVC.pushBlk = ^(DetailTopicViewController *dtVC){
        [weakSelf.navigationController pushViewController:dtVC animated:YES];
    };
    
    self.allVC = [[TopicSearchViewController alloc] init];
    self.allVC.isMyJoin = NO;
    self.allVC.title = @"全部话题";
    self.allVC.pushBlk = ^(DetailTopicViewController *dtVC){
        [weakSelf.navigationController pushViewController:dtVC animated:YES];
    };
    
    self.segementView = [[SegmentView alloc] initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT) andControllers:@[self.joinVC,self.allVC]];
    self.segementView.eventDelegate = self;
    self.currentIndex = 0;
    [self.view addSubview:self.segementView];
}

- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index{
    [self hideKeyBoard];
    self.currentIndex = index;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (self.currentIndex==0) {
        self.joinVC.searchText = searchBar.text;
        [self.joinVC searchDataRefresh];
    }
    if (self.currentIndex==1) {
        self.allVC.searchText = searchBar.text;
        [self.allVC searchDataRefresh];
    }
    [self hideKeyBoard];
}


- (UIImage *) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)hideKeyBoard{
    [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UISearchBar class]])
    {
        return NO;
    }
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return NO;
    }
    return YES;
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

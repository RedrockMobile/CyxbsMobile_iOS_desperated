//
//  TopicViewController.m
//  TopicSearch
//
//  Created by hzl on 2017/5/22.
//  Copyright © 2017年 hzl. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicSearchViewController.h"
#import "SegementView.h"

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

@interface TopicViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) SegementView *segementView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UIButton *popBtn;

@property (nonatomic, strong) TopicSearchViewController *joinVC;

@property (nonatomic, strong) TopicSearchViewController *allVC;

@end

@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleSearch)]];
    
    [self addSearchBar];
    [self addSegemenView];
}

- (void)cancleSearch{
    [self.searchDisplayController setActive:NO animated:YES];
}

- (void)addSearchBar{
    UIView *bgView = [[UIView alloc] initWithFrame:CHANGE_CGRectMake(0, 0, 375, 64)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CHANGE_CGRectMake(50, 30, 300, 30)];
    UIImage* searchBarBg = [self GetImageWithColor:[UIColor clearColor] andHeight:32.0f];

    [self.searchBar setBackgroundImage:searchBarBg];

//    [self.searchBar setBackgroundColor:[UIColor clearColor]];
    [self.searchBar setTintColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]];

//    [self.searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
    self.searchBar.placeholder = @"搜索更多话题";
    self.searchBar.delegate = self;

    self.popBtn = [[UIButton alloc] initWithFrame:CHANGE_CGRectMake(10, 35, 20, 20)];
    self.popBtn.adjustsImageWhenHighlighted = NO;
    self.popBtn.backgroundColor = [UIColor clearColor];
    [self.popBtn setBackgroundImage:[UIImage imageNamed:@"arrowIcon.png"] forState:UIControlStateNormal];
    [self.popBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchDown];
    
    [bgView addSubview:self.searchBar];
    [bgView addSubview:self.popBtn];
    
    [self.view addSubview:bgView];
}

- (void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addSegemenView{
    TopicSearchViewController *joinVC = [[TopicSearchViewController alloc] init];
    joinVC.isMyJoin = YES;
    joinVC.title = @"我参与的";
//进行push操作
//    joinVC.pushBlk
    
    TopicSearchViewController *allVC = [[TopicSearchViewController alloc] init];
    allVC.isMyJoin = NO;
    allVC.title = @"全部话题";
//    allVC.pushBlk
    
    self.segementView = [[SegementView alloc] initWithFrame:CHANGE_CGRectMake(0, 64, 375, 667) withTitle:@[joinVC,allVC]];
    
    [self.view addSubview:self.segementView];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (self.segementView.currentIndex==0) {
        self.joinVC.searchText = searchBar.text;
        [self.joinVC searchDataRefresh];
    }
    if (self.segementView.currentIndex==1) {
        self.allVC.searchText = searchBar.text;
        [self.allVC searchDataRefresh];
    }
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

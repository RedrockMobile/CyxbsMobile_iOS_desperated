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

@interface TopicViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) SegementView *segementView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) TopicSearchViewController *joinVC;

@property (nonatomic, strong) TopicSearchViewController *allVC;

@end

@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSearchBar];
    [self addSegemenView];
}

- (void)addSearchBar{
    UIView *bgView = [[UIView alloc] initWithFrame:CHANGE_CGRectMake(0, 0, 375, 64)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CHANGE_CGRectMake(50, 30, 300, 30)];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;

    self.searchBar.tintColor = [UIColor blueColor];
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
    
    self.segementView = [[SegementView alloc] initWithFrame:CHANGE_CGRectMake(0, 64, 375, 667) withTitle:@[self.joinVC,self.allVC]];
    
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
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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

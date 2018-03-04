//
//  YouWenAddViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/1.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenAddViewController.h"
#import "ReportTextView.h"
@interface YouWenAddViewController ()
@property (strong, nonatomic) NSMutableArray *imageView;
@property (strong, nonatomic) ReportTextView *titleTextView;
@property (strong, nonatomic) ReportTextView *detailTextView;
@property (strong, nonatomic) UIButton *addImageButton;
@end

@implementation YouWenAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setView];
    [self setWriteView];
}

- (void)setView{
    self.navigationController.navigationItem.title = @"求助";
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)setWriteView{
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 3 * 2 - 64)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    _titleTextView = [[ReportTextView alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 30) andState:OnlyWordNum];
    _titleTextView.limitNum = 20;
    _detailTextView = [[ReportTextView alloc] initWithFrame:CGRectMake(10, 40, ScreenWidth - 20, whiteView.height - _titleTextView.bottom - 10) andState:OnlyWordNum];
    _detailTextView.limitNum = 200;
    UIView *blackLine = [[UIView alloc] initWithFrame:CGRectMake(10, _titleTextView.bottom, ScreenWidth - 20, 1)];
    blackLine.backgroundColor = [UIColor blackColor];

    [whiteView addSubview:_titleTextView];
    [whiteView addSubview:_detailTextView];
    [whiteView addSubview:blackLine];
}

- (void)setImageView{
    
}

- (UIButton *)addImageButton{
    if (!_addImageButton){
        _addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_addImageButton addTarget:self action:@selector(selectedImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageButton;
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

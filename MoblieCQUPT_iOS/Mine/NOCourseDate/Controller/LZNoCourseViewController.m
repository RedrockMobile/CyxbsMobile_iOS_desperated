//
//  LZNoCourseViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/21.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZNoCourseViewController.h"
#import "LZPersonAddView.h"
#import "LZSearchView.h"
@interface LZNoCourseViewController ()
@property (nonatomic, strong) LZSearchView *searchView;
@end

@implementation LZNoCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchView = [[LZSearchView alloc]init];
    _searchView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    

    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated{
    [self.view.window addSubview:self.searchView];
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo((SCREENHEIGHT-HEADERHEIGHT)*0.3);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (LZSearchView *)searchView{
//    if (_searchView == nil) {
//           }
//    return _searchView;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

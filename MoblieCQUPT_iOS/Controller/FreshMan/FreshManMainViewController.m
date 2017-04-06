//
//  FreshManMainViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/8/15.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "FreshManMainViewController.h"
#import "FreshManGuideViewController.h"
#import "BeautyViewController.h"
#import "DataViewController.h"

@interface FreshManMainViewController ()

@end


@implementation FreshManMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"2016新生专题网";
    NSArray *pic = @[@"新生攻略.png",@"大数据.png",@"重邮风采.png"];
    CGFloat  kImageViewHeight = (ScreenHeight - 124)/3;
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 79+i*(kImageViewHeight+15), ScreenWidth-30, kImageViewHeight)];
        imageView.image = [UIImage imageNamed:pic[i]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [self.view addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clcikImageView:)];
        [imageView addGestureRecognizer:tap];
    }

    // Do any additional setup after loading the view.
}

- (void)clcikImageView:(UITapGestureRecognizer *)gesture {
    UIImageView *imageView = (UIImageView *)gesture.view;
    
    if (imageView.tag == 0) {
        FreshManGuideViewController *fmgvc = [[FreshManGuideViewController alloc]init];
        [self.navigationController pushViewController:fmgvc animated:YES];
    }else if (imageView.tag == 1) {
        DataViewController *dvc = [[DataViewController alloc] init];
        [self.navigationController pushViewController:dvc animated:YES];
    }else if (imageView.tag == 2) {
        BeautyViewController *bvc = [[BeautyViewController alloc]init];
        [self.navigationController pushViewController:bvc animated:YES];
    }

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

//
//  draftsViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/25.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "draftsViewController.h"

@interface draftsViewController ()

@end

@implementation draftsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *emptyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drafts"]];
    emptyImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:emptyImage];
    
    [emptyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
    }];
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

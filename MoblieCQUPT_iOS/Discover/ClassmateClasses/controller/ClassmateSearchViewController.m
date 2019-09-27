//
//  ClassmateSearchViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/9/27.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "ClassmateSearchViewController.h"
#import "ClassmateSearchView.h"
#import "ClassmatesList.h"
#import "ClassmatesSearchResultViewController.h"

@interface ClassmateSearchViewController () <ClassmateSearchViewDelegate>

@property (nonatomic, weak) ClassmateSearchView *contentView;

@end

@implementation ClassmateSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    
    ClassmateSearchView *contentView = [[ClassmateSearchView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    self.contentView = contentView;
    contentView.delegate = self;
}

#pragma mark - 同学课表搜索界面代理方法
- (void)didClickedSearchButton {
    [self.view endEditing:YES];
    
    if ([self.contentView.searchTextField.text isEqualToString:@""]) {
        MBProgressHUD *noInput = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        noInput.mode = MBProgressHUDModeText;
        noInput.labelText = @"输入为空";
        [noInput hide:YES afterDelay:1];
        return;
    }
    
    __block MBProgressHUD *loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    loading.mode = MBProgressHUDModeIndeterminate;
    loading.labelText = @"加载中";
    
    ClassmatesList *classmates = [[ClassmatesList alloc] init];
    [classmates getListWithName:self.contentView.searchTextField.text success:^(ClassmatesList * _Nonnull classmatesList) {
        [loading hide:YES];
        if (classmatesList.classmatesArray.count == 0) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"无结果";
            [hud hide:YES afterDelay:1];
            return;
        }
        ClassmatesSearchResultViewController *vc = [[ClassmatesSearchResultViewController alloc] initWithClassmatesList:classmatesList];
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [loading hide:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"加载失败";
        [hud hide:YES afterDelay:1];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

//
//  MBCommunityHandle.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/14.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "MBCommunityHandle.h"

@implementation MBCommunityHandle
#pragma mark - 上传点赞

+ (ClickSupportBtnBlock)clickSupportBtn:(UIViewController *)viewController{
    __weak typeof(self) weakSelf = self;
    return ^(UIButton *imageBtn,UIButton *labelBtn,MBCommunity_ViewModel *viewModel) {
        MBCommunityModel *model = viewModel.model;
        NSString *stuNum = [UserDefaultTool getStuNum];
        NSInteger currentSupportNum = [labelBtn.titleLabel.text integerValue];
        if (stuNum==nil) {
//            [self noLogin:viewController];
            [self noLogin:viewController handler:nil];
        }
        else{
            if (imageBtn.selected && labelBtn.selected) {
                currentSupportNum--;
                [weakSelf uploadSupport:viewModel withType:1];
                NSLog(@"点击取消赞");
                
            }else {
                currentSupportNum++;
                [weakSelf uploadSupport:viewModel withType:0];
                NSLog(@"点击赞");
            }
            model.is_my_like = !model.is_my_like;
            model.like_num = @(currentSupportNum);
            imageBtn.selected = !imageBtn.selected;
            labelBtn.selected = !labelBtn.selected;
            [labelBtn setTitle:[NSString stringWithFormat:@"%ld",currentSupportNum] forState:UIControlStateNormal];
        }
    };
}

+ (void)uploadSupport:(MBCommunity_ViewModel *)viewModel withType:(NSInteger)type {
    //type == 0 赞 , type == 1 取消赞
    MBCommunityModel *model = viewModel.model;
    NSString *url = ADDSUPPORT_API;
    if (type == 1) {
        url = CANCELSUPPOTRT_API;
    }
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    NSNumber *article_id = model.article_id;
    NSNumber *type_id = model.type_id;
    NSDictionary *parameter = @{@"stuNum":stuNum,
                                @"idNum":idNum,
                                @"article_id":article_id,
                                @"type_id":type_id};
    [NetWork NetRequestPOSTWithRequestURL:url WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        
    } WithFailureBlock:^{
        NSLog(@"请求赞出错");
    }];
}

+ (void) noLogin:(UIViewController *)viewController handler:(LoginSuccessHandler)handler{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"是否登录？" message:@"没有完善信息呢,无法完成相应操作" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *LVC = [[LoginViewController alloc] init];
        LVC.loginSuccessHandler = handler;
        [viewController presentViewController:LVC animated:YES completion:nil];
    }];
    [alertC addAction:cancel];
    [alertC addAction:confirm];
    [viewController presentViewController:alertC animated:YES completion:nil];
}
@end

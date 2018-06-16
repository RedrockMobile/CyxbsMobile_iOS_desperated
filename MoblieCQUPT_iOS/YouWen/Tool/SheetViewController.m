//
//  SheetViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/15.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SheetViewController.h"
#define URL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/addItemInDraft"
@interface SheetViewController ()

@end

@implementation SheetViewController
+ (UIAlertController *)draftsAlert{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    return controller;
}

- (void)saveDraft{
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:URL method:HttpRequestPost parameters:@{@"stunum":[UserDefaultTool getStuNum],@"idnum":[UserDefaultTool getIdNum],@"type":_style,@"content":_content,@"target_id":_target_ID} prepareExecute:nil
                   progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                       NSString *info = responseObject
                       [@"info"];
                       if ([info isEqualToString:@"success"]) {
                           NSNotification *notification =[NSNotification notificationWithName: @"saveDraft" object:nil userInfo:@{@"state":@"SUCCESS"}];
                           [[NSNotificationCenter defaultCenter] postNotification:notification];
                       }
                       else {
                           NSNotification *notification =[NSNotification notificationWithName: @"saveDraft" object:nil userInfo:@{@"state":@"FAIL"}];
                           [[NSNotificationCenter defaultCenter] postNotification:notification];
                       }
                       
                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                       NSNotification *notification =[NSNotification notificationWithName: @"saveDraft" object:nil userInfo:@{@"state":@"FAIL"}];
                       [[NSNotificationCenter defaultCenter] postNotification:notification];
                   }];
}

- (void)back{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self saveDraft];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:nil];
    
    //把action添加到actionSheet里
    [self addAction:action1];
    [self addAction:action2];
    
    
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

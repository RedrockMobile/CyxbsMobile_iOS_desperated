//
//  SheetViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/15.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SheetAlertController.h"
#define URL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/addItemInDraft"
@interface SheetAlertController ()

@end

@implementation SheetAlertController
+ (instancetype)draftsAlert{
    SheetAlertController *controller = [SheetAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    return controller;
}

- (void)saveDraft{
    HttpClient *client = [HttpClient defaultClient];
    NSDictionary *dic;
    if ([self.style isEqualToString:@"question"]) {
        dic = @{@"stunum":[UserDefaultTool getStuNum],@"idnum":[UserDefaultTool getIdNum],@"type":_style,@"content":_content};
    }
    else {
        dic = @{@"stunum":[UserDefaultTool getStuNum],@"idnum":[UserDefaultTool getIdNum],@"type":_style,@"content":_content,@"target_id":_target_ID};
    }
    [client requestWithPath:URL method:HttpRequestPost parameters:dic prepareExecute:nil
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
- (void)send{
    NSNotification *notification =[NSNotification notificationWithName: @"saveDraft" object:nil userInfo:@{@"state":@"SENDING"}];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)back{
    NSNotification *notification =[NSNotification notificationWithName: @"saveDraft" object:nil userInfo:@{@"state":@"BACK"}];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self saveDraft];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"不保存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self back];
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //把action添加到actionSheet里
    [self addAction:action1];
    [self addAction:action2];
    [self addAction:action3];
    
    
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

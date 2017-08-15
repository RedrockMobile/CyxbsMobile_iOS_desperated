//
//  LoginViewController.m
//  MobileLogin
//
//  Created by GQuEen on 15/8/13.
//  Copyright (c) 2015年 GegeChen. All rights reserved.
//

#import "LoginViewController.h"
#import "NetWork.h"
#import "LoginEntry.h"
#import "VerifyMyInfoViewController.h"
#import "UserDefaultTool.h"
#import <MBProgressHUD.h>


#define Base_Login @"http://hongyan.cqupt.edu.cn/api/verify"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIView *whiteView;

@property (strong, nonatomic) MBProgressHUD *loadHud;
@end

@implementation LoginViewController
typedef NS_ENUM(NSInteger,LZLoginState){
    LZLackPassword,
    LZLackAccount,
    LZAccountOrPasswordWrong,
    LZNetWrong
};
- (void)viewDidLoad {
    [super viewDidLoad];

    self.whiteView.layer.cornerRadius = 3;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)login:(UIButton *)sender {
    _loadHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _loadHud.labelText = @"正在登录";
    if (_passwordField.text.length == 0) {
        [self alertAnimation:LZLackAccount];
    }else if (_accountField.text.length == 0) {
        [self alertAnimation:LZLackPassword];
    }
    else{
        NSDictionary *parameter = @{@"stuNum":_accountField.text,@"idNum":_passwordField.text};
        [NetWork NetRequestPOSTWithRequestURL:Base_Login
                                WithParameter:parameter
                         WithReturnValeuBlock:^(id returnValue){
                             if (![returnValue[@"info"] isEqualToString:@"success"]) {
                                 [self alertAnimation:LZAccountOrPasswordWrong];
                             }else {
                                 //账号信息存本地
                                 [LoginEntry loginWithParamter:returnValue[@"data"]];
                                 //个人消息验证
                                 [self verifyUserInfo];
                             }
                         } WithFailureBlock:^{
                             [self alertAnimation:LZNetWrong];
                             NSLog(@"请求失败");
                         }];
    }
}

- (void)verifyUserInfo {
    [NetWork NetRequestPOSTWithRequestURL:SEARCH_API WithParameter:@{@"stuNum":[UserDefaultTool getStuNum],@"idNum":[UserDefaultTool getIdNum]} WithReturnValeuBlock:^(id returnValue) {
        if (![returnValue[@"data"] isKindOfClass:[NSNull class]]) {
            [UserDefaultTool saveParameter:returnValue[@"data"]];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            if (self.loginSuccessHandler) {
                self.loginSuccessHandler(YES);
            }
        }else {
            //没有完善信息,跳转到完善个人的界面
            VerifyMyInfoViewController *verifyMyInfoVC = [[VerifyMyInfoViewController alloc] init];
            verifyMyInfoVC.verifySuccessHandler = ^(BOOL success) {
                if (self.loginSuccessHandler) {
                    self.loginSuccessHandler(success);
                }
            
            };
            [self presentViewController:verifyMyInfoVC animated:YES completion:nil];
        }
        
    } WithFailureBlock:^{
        
    }];
}

             
- (void)alertAnimation:(LZLoginState)state {
    [_loadHud hide:YES];
    _loadHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _loadHud.mode = MBProgressHUDModeText;
    switch (state) {
        case LZAccountOrPasswordWrong:
            _loadHud.labelText = @"请检查账号密码输入是否正确";
            break;
        case LZLackAccount:
            _loadHud.labelText = @"请输入账号";
            break;
        case LZLackPassword:
            _loadHud.labelText = @"请输入密码";
            break;
        case LZNetWrong:
            _loadHud.labelText = @"网络连接失败,请检查网络";
            break;
        default:
            _loadHud.labelText = @"未知情况 请反馈给开发人员";
            break;
    }
    [_loadHud hide:YES afterDelay:1.5];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_accountField resignFirstResponder];
    [_passwordField resignFirstResponder];
}

@end

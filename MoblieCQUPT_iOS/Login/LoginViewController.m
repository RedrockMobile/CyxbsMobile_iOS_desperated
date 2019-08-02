//
//  LoginViewController.m
//  MobileLogin
//
//  Created by GQuEen on 15/8/13.
//  Copyright (c) 2015年 GegeChen. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginEntry.h"
#import "MyInfoViewController.h"
#import "MyInfoModel.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) MBProgressHUD *loadHud;

typedef NS_ENUM(NSInteger,LZLoginState){
    LZLoginStateLackPassword,
    LZLoginStateLackAccount,
    LZLoginStateAccountOrPasswordWrong,
    LZLoginStateNetWorkWrong
};
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.whiteView.layer.cornerRadius = 3;
    self.loginBtn.layer.cornerRadius = 3;
    self.loginBtn.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)login:(UIButton *)sender {
    self.loadHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.loadHud.labelText = @"正在登录";
    if (self.accountField.text.length == 0) {
        [self alertAnimation:LZLoginStateLackAccount];
    }else if (self.passwordField.text.length == 0) {
        [self alertAnimation:LZLoginStateLackPassword];
    }
    else{
        NSDictionary *parameter = @{@"stuNum":_accountField.text,@"idNum":_passwordField.text};
        HttpClient *client = [HttpClient defaultClient];
        [client requestWithPath:LOGIN_API method:HttpRequestPost parameters:parameter prepareExecute:^{
            
        } progress:^(NSProgress *progress) {
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            if (![responseObject[@"info"] isEqualToString:@"success"]) {
                [self alertAnimation:LZLoginStateAccountOrPasswordWrong];
            }else {
                [LoginEntry loginWithParamter:responseObject[@"data"]];
                [self verifyUserInfo];
                [MobClick profileSignInWithPUID:[UserDefaultTool getStuNum]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self alertAnimation:LZLoginStateNetWorkWrong];
            NSLog(@"请求失败");
        }];
    }
}

- (void)verifyUserInfo {
    HttpClient *client = [HttpClient defaultClient];
    NSDictionary *parameters = @{@"stuNum":[UserDefaultTool getStuNum],@"idNum":[UserDefaultTool getIdNum]};
    [client requestWithPath:YOUWEN_USER_INFO_API method:HttpRequestPost parameters:parameters prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            MyInfoModel *model = [[MyInfoModel alloc]initWithDic:responseObject[@"data"]];
            [model saveMyInfo];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            //没有完善信息,跳转到完善个人的界面
            MyInfoViewController *verifyMyInfoVC = [[MyInfoViewController alloc] init];
            [self presentViewController:verifyMyInfoVC animated:YES completion:nil];
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
        if (self.loginSuccessHandler) {
            self.loginSuccessHandler(YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self alertAnimation:LZLoginStateNetWorkWrong];
        NSLog(@"请求失败");
    }];
}

- (void)alertAnimation:(LZLoginState)state {
    self.loadHud.mode = MBProgressHUDModeText;
    switch (state) {
        case LZLoginStateAccountOrPasswordWrong:
            self.loadHud.labelText = @"请检查账号密码输入是否正确";
            break;
        case LZLoginStateLackAccount:
            self.loadHud.labelText = @"请输入账号";
            break;
        case LZLoginStateLackPassword:
            self.loadHud.labelText = @"请输入密码";
            break;
        case LZLoginStateNetWorkWrong:
            self.loadHud.labelText = @"网络连接失败,请检查网络";
            break;
        default:
            self.loadHud.labelText = @"未知情况 请反馈给开发人员";
            break;
    }
    [self.loadHud hide:YES afterDelay:1.5];
    if (self.loginSuccessHandler) {
        self.loginSuccessHandler(NO);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.accountField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

@end

//
//  LoginViewController.m
//  MobileLogin
//
//  Created by GQuEen on 15/8/13.
//  Copyright (c) 2015年 GegeChen. All rights reserved.
//

#import "LoginViewController.h"
#import "NetWork.h"
#import "CourseViewController.h"
#import "LoginEntry.h"
#import "MBProgressHUD.h"
#import "VerifyMyInfoViewController.h"

#define Base_Login @"http://hongyan.cqupt.edu.cn/api/verify"


@interface LoginViewController ()
@property (strong, nonatomic)NSDictionary *dataDic;
@property (strong, nonatomic)UITextField *nameField;
@property (strong, nonatomic)UITextField *passwordField;
@property (strong, nonatomic)UIButton *loginButton;

@property (strong, nonatomic) MBProgressHUD *loadHub;
@property (strong, nonatomic) MBProgressHUD *AlertHub;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    UIView *nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    nav.backgroundColor = MAIN_COLOR;
    [self.view addSubview:nav];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    titleLabel.text = @"登录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.center = CGPointMake(ScreenWidth/2, nav.frame.size.height/2+10);
    [nav addSubview:titleLabel];
    
    UIView *textFieldView = [[UIView alloc]initWithFrame:CGRectMake(0, 89, ScreenWidth, 100)];
    textFieldView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textFieldView];
    
    UIImageView *nameImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 17, 20)];
    nameImage.image = [UIImage imageNamed:@"iconfont-name.png"];
    [textFieldView addSubview:nameImage];
    
    _nameField = [[UITextField alloc]initWithFrame:CGRectMake(55, 15, ScreenWidth*8/10, 20)];
    _nameField.font = [UIFont systemFontOfSize:15];
    _nameField.placeholder = @"学号";
    _nameField.tintColor = MAIN_COLOR;
    _nameField.keyboardType = UIKeyboardTypeNumberPad;
    _nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameField.delegate = self;
    [textFieldView addSubview:_nameField];
    
    UIImageView *passwordImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 65, 17, 20)];
    passwordImage.image = [UIImage imageNamed:@"iconfont-password.png"];
    [textFieldView addSubview:passwordImage];
    
    _passwordField = [[UITextField alloc]initWithFrame:CGRectMake(55, 65, ScreenWidth*8/10, 20)];
    _passwordField.font = [UIFont systemFontOfSize:15];
    _passwordField.placeholder = @"身份证后六位";
    _passwordField.tintColor = MAIN_COLOR;
    _passwordField.secureTextEntry = YES;
    _passwordField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordField.delegate = self;
    [textFieldView addSubview:_passwordField];
    
    UIView *underLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    underLine.center = CGPointMake(ScreenWidth/2+21, textFieldView.frame.size.height/2);
    underLine.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [textFieldView addSubview:underLine];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake(20, 210, ScreenWidth-40, 50);
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _loginButton.backgroundColor = MAIN_COLOR;
    _loginButton.layer.cornerRadius = 5.0;
    [_loginButton addTarget:self action:@selector(loginButton:) forControlEvents:UIControlEventTouchUpInside];
    [_loginButton addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_loginButton];
}

- (void)touchDown {
    _loginButton.alpha = 0.5;
}

- (void)loginButton:(UIButton *)sender {
    _loadHub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _loadHub.labelText = @"正在登陆";
    [_loadHub showAnimated:NO whileExecutingBlock:^{
        [UIView animateWithDuration:1.5 animations:^{
            [sender setTitle:@"登录中" forState:UIControlStateNormal];
        } completion:nil];
        sleep(1);
        _loginButton.enabled = NO;
    } completionBlock:^{
        if (_nameField.text.length == 10 && _passwordField.text.length == 6) {
            NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
            [parameter setObject:_nameField.text forKey:@"stuNum"];
            [parameter setObject:_passwordField.text forKey:@"idNum"];
            __weak typeof(self) weakSelf = self;
            [NetWork NetRequestPOSTWithRequestURL:Base_Login
                                    WithParameter:parameter
                             WithReturnValeuBlock:^(id returnValue) {
                                 weakSelf.dataDic = returnValue;
                                 if (![_dataDic[@"info"] isEqualToString:@"success"]) {
                                     if([_dataDic[@"info"] isEqualToString:@"authentication error"]) {
                                         [weakSelf alertAnimation:1];
                                     }else if ([_dataDic[@"info"] isEqualToString:@"student id error"]) {
                                          [weakSelf alertAnimation:2];
                                     }
                                 }else {
                                     //账号信息存本地
                                     NSDictionary *dic = @{@"name":_nameField.text};
                                     [LoginEntry loginWithId:_nameField.text passworld:_passwordField.text withDictionaryParam:dic];
                                     
                                     //个人消息验证
                                     [weakSelf verifyUserInfo];
                                 }
                             } WithFailureBlock:^{
                                 [weakSelf alertAnimation:5];
                                 NSLog(@"请求失败");
                             }];
            
        }else if (_nameField.text.length == 10 && _passwordField.text.length == 0) {
            [self alertAnimation:4];
        }else if (_nameField.text.length == 0 && _passwordField.text.length == 6) {
            [self alertAnimation:3];
        }else {
            [self alertAnimation:0];
        }
    }];
}

- (void)verifyUserInfo {
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    
    [NetWork NetRequestPOSTWithRequestURL:SEARCH_API WithParameter:@{@"stuNum":stuNum,@"idNum":idNum} WithReturnValeuBlock:^(id returnValue) {
        
        //如果返回的data 内容不是nil 则跳转到主界面
        //否则 跳转到 完善个人信息界面
        NSLog(@"result :%@", returnValue);
        if (![returnValue[@"data"] isKindOfClass:[NSNull class]]) {
            //完善个人信息 把id 作为user_id 存在本地 以便发布内容时使用
            NSString *user_id = returnValue[@"data"][@"id"] ?: @"";
            NSString *nickname = returnValue[@"data"][@"nickname"] ?: @"";
            NSString *photo_src = returnValue[@"data"][@"photo_src"] ?: @"";
            [LoginEntry saveByUserdefaultWithUserID:user_id];
            [LoginEntry saveByUserdefaultWithNickname:nickname];
            [LoginEntry saveByUserdefaultWithPhoto_src:photo_src];
            NSLog(@"%@,%@,%@",user_id,nickname,photo_src);
            //跳转到 主界面
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            id view = [storyBoard instantiateViewControllerWithIdentifier:@"MainNavigation"];
            [self presentViewController:view animated:YES completion:nil];
        }else {
            //没有完善信息,跳转到完善个人的界面
            VerifyMyInfoViewController *verifyMyInfoVC = [[VerifyMyInfoViewController alloc] init];
            [self presentViewController:verifyMyInfoVC animated:YES completion:nil];
        }
        
    } WithFailureBlock:^{
        
    }];
}

- (void)alertAnimation:(NSInteger)style {
    [_loadHub removeFromSuperview];
    _AlertHub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _AlertHub.mode = MBProgressHUDModeText;
    
    if (style == 0) {
        _AlertHub.labelText = @"请检查账号密码输入是否正确";
    }else if (style == 1) {
        _AlertHub.labelText = @"输入的密码有问题,请重新输入";
    }else if (style == 2) {
        _AlertHub.labelText = @"输入的学号有问题,请重新输入";
    }else if (style == 3) {
        _AlertHub.labelText = @"请输入账号";
    }else if (style == 4) {
        _AlertHub.labelText = @"请输入密码";
    }else if (style == 5) {
        _AlertHub.labelText = @"网络连接失败,请检查网络";
    }
    [_AlertHub hide:YES afterDelay:1.5];
    [UIView animateWithDuration:0.8 animations:^{
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            _loginButton.alpha = 1;
        } completion:^(BOOL finished) {
            _loginButton.enabled = YES;
        }];
    }];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_nameField resignFirstResponder];
    [_passwordField resignFirstResponder];
}

@end

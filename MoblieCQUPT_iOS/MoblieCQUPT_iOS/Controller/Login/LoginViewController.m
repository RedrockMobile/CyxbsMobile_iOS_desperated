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
#import "ProgressHUD.h"

#define Base_Login @"http://hongyan.cqupt.edu.cn/api/verify"

@interface LoginViewController ()
@property (strong, nonatomic)NSDictionary *dataDic;
@property (strong, nonatomic)UITextField *nameField;
@property (strong, nonatomic)UITextField *passwordField;
@property (strong, nonatomic)UIButton *loginButton;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordField];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake(20, 210, ScreenWidth-40, 50);
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    _loginButton.backgroundColor = MAIN_COLOR;
    _loginButton.layer.cornerRadius = 5.0;
    _loginButton.enabled = NO;
    [_loginButton addTarget:self action:@selector(loginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
}

- (void)textChange {
    if (_nameField.text.length == 10 && _passwordField.text.length == 6) {
        _loginButton.enabled = YES;
    }else {
        _loginButton.enabled = NO;
    }
}


- (void)loginButton:(UIButton *)sender {
    sender.enabled = NO;
    [UIView animateWithDuration:1.5 animations:^{
        [sender setTitle:@"登录中" forState:UIControlStateNormal];
    } completion:nil];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:_nameField.text forKey:@"stuNum"];
    [parameter setObject:_passwordField.text forKey:@"idNum"];
    [NetWork NetRequestPOSTWithRequestURL:Base_Login
                            WithParameter:parameter
                     WithReturnValeuBlock:^(id returnValue) {
                         self.dataDic = returnValue;
                         if (![_dataDic[@"info"] isEqualToString:@"success"]) {
                             [ProgressHUD showError:@"账号或密码输入错误,请重新输入"];
                             [UIView animateWithDuration:0.8 animations:^{
                                 [sender setTitle:@"登录" forState:UIControlStateNormal];
                             } completion:nil];
                             sender.enabled = YES;
                         }else {
                             NSDictionary *dic = @{@"name":_dataDic[@"data"][@"name"]};
                             [LoginEntry loginWithId:_nameField.text passworld:_passwordField.text withDictionaryParam:dic];
//                             NSLog(@"%@",dic);
                             UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                             id view = [storyBoard instantiateViewControllerWithIdentifier:@"MainNavigation"];
                             [self presentViewController:view animated:YES completion:nil];
                         }
                     } WithFailureBlock:^{
                         sender.enabled = YES;
                         [ProgressHUD showError:@"请检查你的网络连接"];
                         [UIView animateWithDuration:0.8 animations:^{
                             [sender setTitle:@"登录" forState:UIControlStateNormal];
                         } completion:nil];
                         NSLog(@"请求失败");
                     }];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_nameField resignFirstResponder];
    [_passwordField resignFirstResponder];
}

@end

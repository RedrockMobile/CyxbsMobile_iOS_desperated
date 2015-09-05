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

#define Base_Login @"http://hongyan.cqupt.edu.cn/api/verify"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *namgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UIView *backView;


@property (strong, nonatomic)NSDictionary *dataDic;

@property (strong, nonatomic)UIView *view1;
@property (strong, nonatomic)UIView *view2;
- (IBAction)login:(UIButton *)sender;

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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    _nameField.placeholder = @"账号/学号";
    [_nameField setValue:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7] forKeyPath:@"_placeholderLabel.textColor"];
    _nameField.borderStyle = UITextBorderStyleNone;
    _nameField.tag = 1;
    _nameField.tintColor = [UIColor colorWithRed:255/255.0 green:152/255.0 blue:0/255.0 alpha:1];
    _nameField.textColor = [UIColor whiteColor];
    _nameField.font = [UIFont systemFontOfSize:16];
    _nameField.keyboardType = UIKeyboardTypeNumberPad;
    _nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameField.delegate = self;
    
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(_nameField.frame.origin.x, _nameField.frame.origin.y+_nameField.frame.size.height/3*2.3, _nameField.frame.size.width-15, 1)];
    _view1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7];
    [self.backView addSubview:_view1];
    
    
    _passwordField.placeholder = @"密码/身份证后6位";
    [_passwordField setValue:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7] forKeyPath:@"_placeholderLabel.textColor"];
    _passwordField.borderStyle = UITextBorderStyleNone;
    _passwordField.tag = 2;
    _passwordField.tintColor = [UIColor colorWithRed:255/255.0 green:152/255.0 blue:0/255.0 alpha:1];
    _passwordField.textColor = [UIColor whiteColor];
    _passwordField.font = [UIFont systemFontOfSize:16];
    _passwordField.secureTextEntry = YES;
    _passwordField.keyboardType = UIKeyboardTypeNumberPad;
    _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordField.delegate = self;
    
    _view2 = [[UIView alloc]initWithFrame:CGRectMake(_passwordField.frame.origin.x, _passwordField.frame.origin.y+_passwordField.frame.size.height/3*2.2, _passwordField.frame.size.width-15, 1)];
    _view2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7];
    [self.backView addSubview:_view2];
    
    
    _loginButton.layer.cornerRadius = 5.0;
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor colorWithRed:0/255.0 green:255/255.0 blue:255/255.0 alpha:1] forState:UIControlStateHighlighted];
    _loginButton.backgroundColor = [UIColor grayColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordField];
}

- (void)textChange {
    if (_nameField.text.length == 10 && _passwordField.text.length == 6) {
        _loginButton.enabled = YES;
        [UIView animateWithDuration:0.8 animations:^{
            _loginButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:152/255.0 blue:0/255.0 alpha:1];
            [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } completion:nil];
    }else {
        _loginButton.enabled = NO;
        [UIView animateWithDuration:0.8 animations:^{
            _loginButton.backgroundColor = [UIColor grayColor];
            [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } completion:nil];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        [self commonAnimation:1];
    }else {
        [self commonAnimation:2];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self commonAnimation:0];
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self commonAnimation:0];
}


//封装动画 特效方法
- (void)commonAnimation:(int) tag{
    _view1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    _view2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [_nameField setValue:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0  alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordField setValue:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    if(tag != 1 && tag != 2){
        [_nameField resignFirstResponder];
        [_passwordField resignFirstResponder];
        _view1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7];
        _view2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7];
        [UIView animateWithDuration:0.3 animations:^{
            CGAffineTransform tmp = CGAffineTransformMakeScale(1, 1);
            self.titleImage.transform = CGAffineTransformTranslate(tmp,0, 0);
            
        } completion:nil];
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.center = [UIApplication sharedApplication].keyWindow.center;
        } completion:nil];
         [_nameField setValue:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7] forKeyPath:@"_placeholderLabel.textColor"];
         [_passwordField setValue:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7] forKeyPath:@"_placeholderLabel.textColor"];
    }
    if(tag != 1) {
        [_nameField resignFirstResponder];
        [_nameField setValue:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7] forKeyPath:@"_placeholderLabel.textColor"];
        _view1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7];
    }else if(tag != 2){
        [_passwordField resignFirstResponder];
        [_passwordField setValue:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7] forKeyPath:@"_placeholderLabel.textColor"];
         _view2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7];
    }
    
    if (tag == 1 || tag == 2) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.center = CGPointMake(self.view.center.x, ScreenHeight/2-85);
        } completion:nil];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGAffineTransform tmp = CGAffineTransformMakeTranslation(0, 80);
            self.titleImage.transform = CGAffineTransformScale(tmp, 0.8, 0.8);
        } completion:nil];
    }
    
}

- (IBAction)login:(UIButton *)sender {
    [self commonAnimation:0];
    [UIView animateWithDuration:1.5 animations:^{
        sender.backgroundColor = [UIColor colorWithRed:3/255.0 green:169/25.0 blue:244/255.0 alpha:1];
        [sender setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        [sender setTitle:@"登录中" forState:UIControlStateNormal];
        
    } completion:nil];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:_nameField.text forKey:@"stuNum"];
    [parameter setObject:_passwordField.text forKey:@"idNum"];
    [NetWork NetRequestPOSTWithRequestURL:Base_Login WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        self.dataDic = returnValue;
        if (![_dataDic[@"info"] isEqualToString:@"success"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"账号或密码输入错误,请重新输入" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
        }else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"欢迎登录 %@ 同学",_dataDic[@"data"][@"name"]] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
            NSDate *futureTime = [NSDate dateWithTimeIntervalSinceNow:60*60*24*15];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:_nameField.text forKey:@"stuNum"];
            [userDefaults setObject:_passwordField.text forKey:@"idNum"];
            [userDefaults setObject:futureTime forKey:@"time"];
            [userDefaults setObject:_dataDic[@"data"][@"name"] forKey:@"name"];
            [userDefaults synchronize];
            
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            id view = [storyBoard instantiateViewControllerWithIdentifier:@"MainViewController"];
            [self presentViewController:view animated:YES completion:nil];
        }
    } WithFailureBlock:^{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请检查你的网络连接" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
        [UIView animateWithDuration:1.5 animations:^{
            sender.backgroundColor = MAIN_COLOR;
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [sender setTitle:@"登录" forState:UIControlStateNormal];
            
        } completion:nil];
        NSLog(@"请求失败");
    }];
    
}
@end

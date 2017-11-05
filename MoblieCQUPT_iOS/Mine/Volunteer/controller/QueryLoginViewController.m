//
//  QueryLoginViewController.m
//  MoblieCQUPT_iOS
//
//  Created by MaggieTang on 05/10/2017.
//  Copyright © 2017 Orange-W. All rights reserved.
//

#import "QueryLoginViewController.h"
#import "BaseViewController.h"
#import "QueryViewController.h"
#import "QueryModel.h"
#import "QueryDataModel.h"
#import <AFNetworking.h>
@interface QueryLoginViewController ()
@property (nonatomic,strong) UIImageView *accountImageView;
@property (nonatomic,strong) UIImageView *passwordImageView;
@property (nonatomic,strong) UITextField *passwordField;
@property (nonatomic,strong) UITextField *accountField;
@property (nonatomic,copy) NSString *hour;
@property (nonatomic,copy) NSMutableArray *mutableArray;

@end


@implementation QueryLoginViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   self.navigationController.navigationBar.hidden = YES;
   [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
   self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
   self.navigationItem.title =@"完善信息";
     __weak typeof (self) weakSelf = self;
   UIView *bgView = [[UIView alloc]init];
   bgView.backgroundColor = [UIColor redColor];
   [self.view addSubview:bgView];
   [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(weakSelf.view);
      make.size.mas_equalTo(CGSizeMake(200, 200));
   }];
   UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
   imageView.image = [UIImage imageNamed:@"志愿时长"];
   [self.view addSubview:imageView];
   //设置返回按钮
   UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(16,37,10,16)];
   [back addTarget:self action:@selector(buttonAction1) forControlEvents:UIControlEventTouchUpInside];
   [back setBackgroundImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
   [self.view addSubview:back];
   //设置bartitle
   int padding1 = 150;
   UILabel *tilte = [[UILabel alloc]initWithFrame:CGRectMake(padding1, 35, MAIN_SCREEN_W-2*padding1, 18)];
   tilte.text = @"完善信息";
   tilte.font = [UIFont systemFontOfSize:18];
   tilte.textAlignment = NSTextAlignmentCenter;
   tilte.textColor = [UIColor whiteColor];
   [self.view addSubview:tilte];

   //设置保存按钮
   UIButton *save = [[UIButton alloc]init];
   [save addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
   [save setBackgroundImage:[UIImage imageNamed:@"login_icon"] forState:UIControlStateNormal];
   [save setTitle:@"保 存" forState:UIControlStateNormal];
   save.titleEdgeInsets = UIEdgeInsetsMake(0, save.imageView.frame.size.width, 0, 0);
   [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   [self.view addSubview:save];
   [save mas_makeConstraints:^(MASConstraintMaker *make){
      make.size.mas_equalTo(CGSizeMake(330, 40));
      make.centerX.equalTo(weakSelf.view);
      make.top.height.offset(480);
   }];
   
   //设置textfield
   int padding = 40;
   self.accountField=[self createTextFielfFrame:CGRectMake(76, 335, MAIN_SCREEN_W-padding*2-36, 30) font:[UIFont systemFontOfSize:15] placeholder:@"请输入暖青汇账号"];
   //user.text=@"13419693608";
   self.accountField.keyboardType=UIKeyboardTypeNumberPad;
   self.accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
   UIView *accountLine = [[UIView alloc]initWithFrame:CGRectMake(padding, 367, MAIN_SCREEN_W-padding*2, 2)];
   accountLine.backgroundColor = [UIColor grayColor];
   accountLine.alpha = 0.2;
   [self.view addSubview:accountLine];

   
   self.passwordField=[self createTextFielfFrame:CGRectMake(76, 395, MAIN_SCREEN_W-padding*2-36, 30) font:[UIFont systemFontOfSize:15] placeholder:@"请输入密码" ];
   self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
   self.passwordField.secureTextEntry=YES;
   UIView *passwordLine = [[UIView alloc]initWithFrame:CGRectMake(36, 428, MAIN_SCREEN_W-padding*2, 2)];
   passwordLine.backgroundColor = [UIColor grayColor];
   passwordLine.alpha = 0.2;
   [self.view addSubview:passwordLine];
   
   //设置图标的imageview
   UIImage *accountImage = [UIImage imageNamed:@"login_number"];
   self.accountImageView = [[UIImageView alloc]initWithImage:accountImage];
   self.accountImageView.frame = CGRectMake(padding, 339, 19, 20);
   //accountImageView.contentMode = UIViewContentModeScaleToFill;
   
   
   UIImage *passwordImage = [UIImage imageNamed:@"login_password"];
   self.passwordImageView = [[UIImageView alloc]initWithImage:passwordImage];
   self.passwordImageView.frame = CGRectMake(padding, 399, 19, 20);
   //passwordImageView.contentMode = UIViewContentModeScaleToFill;

   
   [self.view addSubview:self.accountField];
   [self.view addSubview:self.passwordField];
   
   [self.view addSubview:self.accountImageView];
   [self.view addSubview:self.passwordImageView];

   
   
}
-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder{
   UITextField *textField=[[UITextField alloc]initWithFrame:frame];
   textField.font=font;
   textField.textColor=[UIColor grayColor];
   textField.borderStyle=UITextBorderStyleNone;
   textField.placeholder=placeholder;
   return textField;
}

- (void)buttonAction{
   NSUserDefaults *defaultsA = [NSUserDefaults standardUserDefaults];
   [defaultsA setObject:self.accountField.text forKey:@"account"];
   NSUserDefaults *defaultsP = [NSUserDefaults standardUserDefaults];
   [defaultsP setObject:self.passwordField.text forKey:@"password"];
   NSString *account = self.accountField.text;
   NSString *password = self.passwordField.text;
   NSDictionary *parameters = @{@"account":account,@"password":password};
   NSString *urlString = @"https://redrock.team/servicerecord/login";
   HttpClient *client = [HttpClient defaultClient];
   [client requestWithPath:urlString method:HttpRequestPost parameters:parameters prepareExecute:^{
      
   } progress:^(NSProgress *progress) {
      
   } success:^(NSURLSessionDataTask *task, id responseObject) {
      NSLog(@"请求成功%@",responseObject);
      NSString *status = responseObject[@"status"];
      
      if([status isEqual:@"200"]){
         [UserDefaultTool saveValue:responseObject[@"data"]  forKey:@"totalarray"];
         QueryViewController *queryView = [[QueryViewController alloc]init];
         
         [self.navigationController pushViewController:queryView animated:true];}
      else{
         UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"您的账号或密码错误" message:@"" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleCancel handler:nil];
         [alertC addAction:cancel];
         [self presentViewController:alertC animated:YES completion:nil];
      }
      
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
      NSLog(@"请求失败%@",error);
      UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"您的网络状态不好哟" message:@"" preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"再试试" style:UIAlertActionStyleCancel handler:nil];
      [alertC addAction:cancel];
      [self presentViewController:alertC animated:YES completion:nil];
   }];
}

- (void)buttonAction1{
   [self.navigationController popViewControllerAnimated:true];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   [self.accountField resignFirstResponder];
   [self.passwordField resignFirstResponder];
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

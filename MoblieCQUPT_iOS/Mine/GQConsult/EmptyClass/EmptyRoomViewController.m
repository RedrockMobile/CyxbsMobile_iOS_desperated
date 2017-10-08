//
//  EmptyRoomViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/3.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "EmptyRoomViewController.h"
#import "MBProgressHUD.h"
#import "ExamPickView.h"
#import "UITextField+Empty.h"
#import "EmptyRoomTableViewController.h"
#import "XGEmptyRoomModels.h"
@interface EmptyRoomViewController ()<UITextFieldDelegate>
@property (strong, nonatomic)UITextField *textField1;
@property (strong, nonatomic)UITextField *textField2;
@property (strong, nonatomic)UIButton *confirmBtn;
@property (assign, nonatomic)NSString *textField1IsTap;
@property (assign, nonatomic)NSString *textField2IsTap;

@property (strong, nonatomic) MBProgressHUD *HUD;

@property (strong, nonatomic)NSArray *buildNum;
@property (strong, nonatomic)NSArray *sectionNum;
@end

@implementation EmptyRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKCOLOR;
    _textField1 = [[UITextField alloc]initWithPlaceHolder:@"     请选择教学楼" andFrame:CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height, SCREENWIDTH, 50)];
    _textField1.tag = 1;
    _textField1.delegate = self;
    [self.view addSubview:_textField1];
    _textField2 = [[UITextField alloc]initWithPlaceHolder:@"     请选择时间" andFrame:CGRectMake(0, _textField1.bottom + 2, SCREENWIDTH, 50)];
    _textField2.tag = 2;
    _textField2.delegate = self;
    [self.view addSubview:_textField2];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:@"value" object:nil];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(15, _textField2.bottom + (20 * SCREENWIDTH / 375), SCREENWIDTH - 30 * SCREENWIDTH / 375, 50 * SCREENWIDTH / 375);
    [_confirmBtn addTarget:self action:@selector(confirmThing) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setImage:[UIImage imageNamed:@"findBtn"] forState:UIControlStateNormal];
    [self.view addSubview:_confirmBtn];
    
    
    
        // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//textField的协议事件
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    ExamPickView *views = [[ExamPickView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT + 250)];
    
    if (textField.tag == 1) {
        _buildNum = @[@"二教", @"三教", @"四教", @"五教", @"八教"];
        views.nameArray = _buildNum;
        
    }
    else{
        _sectionNum = @[@"一二节", @"三四节", @"五六节", @"七八节", @"九十节", @"十十一节"];
        views.nameArray = _sectionNum;
    }
    [views show];
    return NO;
}
//通知
-(void)getValue:(NSNotification *)notification
{
    if ([notification.object containsString:@"教"]) {
        _textField1.text =[NSString
                           stringWithFormat:@"     %@", notification.object];
        _textField1IsTap = notification.object;
    }
    else{
        _textField2.text = [NSString
                            stringWithFormat:@"     %@", notification.object];
        _textField2IsTap = notification.object;
    }
}
-(void)confirmThing{
    if (_textField1IsTap&& _textField2IsTap) {

        NSString *build = [NSString stringWithFormat:@"%lu", (unsigned long)[_buildNum indexOfObject:_textField1IsTap]];
        NSString *section =[NSString stringWithFormat:@"%lu", (unsigned long)[_sectionNum indexOfObject:_textField2IsTap]];
        [self showEmptyRoomInWhere:build WhatsTime:section];
        _textField1.text = nil;
        _textField2.text = nil;
    }
    else{
        //初始化警告框
        UIAlertController*alert = [UIAlertController
                            alertControllerWithTitle: @"提示"
                                   message: @"请正确填写信息"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction
                          actionWithTitle:@"确定"
                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
        }]];
        [self presentViewController:alert
                           animated:YES completion:nil];
    }
}
- (void)showEmptyRoomInWhere:(NSString *)buildNum WhatsTime:(NSString *)sectionNum{
    XGEmptyRoomModels *room = [[XGEmptyRoomModels alloc]init];
    room.sectionNum = @"1";
    room.buildNum = @"2";
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.labelText = @"正在查询...";
    [room loadEmptyData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getData:) name:@"data" object:nil];
    
    
}
- (void)getData:(NSNotification *)notificatio{
    if (notificatio.object) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        EmptyRoomTableViewController *tableViews = [[EmptyRoomTableViewController alloc]init];
        tableViews.EmptyData = notificatio.object;
        [self.navigationController pushViewController:tableViews animated:YES];

    }
    else{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"加载失败";
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1];
        
    }
    
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

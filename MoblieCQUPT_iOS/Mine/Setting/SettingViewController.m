//
//  SettingViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/5/5.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "SettingViewController.h"
#import "SuggestionViewController.h"
#import "SuggestionViewController.h"
#import "XBSAboutViewController.h"
#import "LoginEntry.h"
#import "LoginViewController.h"
//#import "LessonRemindNotification.h"

@interface SettingViewController()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *cellArray;
@property (strong, nonatomic) UIView *codeView;
@property (nonatomic, strong) UIImageView *codeImageView;
@property (nonatomic, strong) UIWindow *alertWindow;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, MAIN_SCREEN_W, MAIN_SCREEN_H) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [quitBtn setImage:[UIImage imageNamed:@"backColor"] forState:UIControlStateNormal];
    quitBtn.frame = CGRectMake(self.view.centerX - (SCREENWIDTH - 40) / 2, self.view.centerY - 40, SCREENWIDTH - 40, 50  * SCREENWIDTH / 375);
    [quitBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:quitBtn];
    _cellArray = @[@{@"cell":@"在课表上没课的地方显示备忘内容"},
                   @{@"cell":@"意见与反馈", @"controller":@"SuggestionViewController"},
                   @{@"cell":@"关于", @"controller":@"XBSAboutViewController"},
                   @{@"cell":@"分享"},
                   @{@"cell":@"退出当前账号"}

                   ];
}

#pragma mark - TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 47;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UILabel *textLabel = [[UILabel alloc] init];
    [textLabel sizeToFit];
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
            switchview.onTintColor = [UIColor colorWithRed:120/255.0 green:142/255.0 blue:250/255.0 alpha:1.0];
            [switchview addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
            if ([userDefault objectForKey:@"switchState"] == nil) {
                [userDefault setObject:[NSNumber numberWithBool:switchview.on] forKey:@"switchState"];
                
            }
            switchview.on = [[userDefault objectForKey:@"switchState"] boolValue];
            cell.accessoryView = switchview;
        }
    }
    
        textLabel.text = _cellArray[indexPath.row][@"cell"];
        textLabel.frame = CGRectMake(16, 16, 0, 0);
        textLabel.font = kFont;
        textLabel.textColor = kDetailTextColor;
        textLabel.textAlignment = NSTextAlignmentLeft;
        [textLabel sizeToFit];
        [cell.contentView addSubview:textLabel];
    return cell;
}
- (void)quit{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登出帐号"
                                                                   message:@"所有的个人信息将清除,你确定要登出此帐号吗?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              [self logOut];
                                                          }];
    [alert addAction:defaultAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 3) {
        [self displayCode];
    }
    else{
        NSString *className =  _cellArray[indexPath.row][@"controller"];
        UIViewController *viewController =  (UIViewController *)[[NSClassFromString(className) alloc] init];
        viewController.navigationItem.title = _cellArray[indexPath.row][@"cell"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)switchValueChanged:(UISwitch *)sender
{

}

- (void)logOut {
    //    NSLog(@"log out");
    //    LoginViewController *login = [[LoginViewController alloc]init];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    id view = [storyBoard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [LoginEntry loginOut];
//    [LoginEntry loginoutWithParamArrayString:@[@"lessonResponse", @"nowWeek", @"user_id", @"id", @"stuname", @"introduction", @"username", @"nickname", @"gender", @"photo_thumbnail_src", @"photo_src", @"updated_time", @"phone", @"qq",@"switchState"]];
//    NSFileManager *manager=[NSFileManager defaultManager];
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSString *remindPath = [path stringByAppendingPathComponent:@"remind.plist"];
//    NSString *failurePath = [path stringByAppendingPathComponent:@"failure.plist"];
//    NSError *error;
//    if ([manager removeItemAtPath:remindPath error:&error]) {
//        NSLog(@"%@",error);
//    }
//    if ([manager removeItemAtPath:failurePath error:&error]) {
//        NSLog(@"%@",error);
//    }
    [self.navigationController presentViewController:view animated:YES completion:nil];
    //    [self dismissViewControllerAnimated:YES completion:^{
    //
    //    }];
    //    [self.navigationController presentViewController:login animated:YES completion:^{
    //        [LoginEntry loginoutWithParamArrayString:@[@"dataArray", @"weekDataArray", @"nowWeek", @"user_id", @"id", @"stuname", @"introduction", @"username", @"nickname", @"gender", @"photo_thumbnail_src", @"photo_src", @"updated_time", @"phone", @"qq"]];
    //    }];
    
}
- (void)displayCode{
    self.codeView = [[UIView alloc]initWithFrame:self.view.frame];
    self.codeView.backgroundColor = [UIColor colorWithRed:189/255.0  green:189/255.0 blue:189/255.0 alpha:0.5];
    self.codeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"QRcode"]];
    self.codeImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.codeImageView.size = CGSizeMake(SCREENWIDTH - 50, SCREENHEIGHT - 300);
    self.codeImageView.center = self.codeView.center;
    [self.codeView addSubview:self.codeImageView];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    self.codeView.userInteractionEnabled = YES;
    self.codeImageView.userInteractionEnabled = YES;
    [self.codeView addGestureRecognizer:tapRecognizer];
    [self.codeImageView addGestureRecognizer:longPressGestureRecognizer];
    [self.view.window addSubview:self.codeView];
}


- (void)tap{
    [_codeView removeFromSuperview];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress{
    // 手势的状态
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存图片" message:@"您要保存当前图片到相册中吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(self.codeImageView.image, self, @selector(image:didFinshSavingWithError:contextInfo:), nil);
        [alertController dismissViewControllerAnimated:YES completion:^{
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
        }];
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [self.codeView removeFromSuperview];
        [self presentViewController:alertController animated:YES completion:nil];
     }
}
                               
- (void) image:(UIImage *)image didFinshSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *mes = nil;
    if (error != nil) {
        mes = @"保存图片失败";
    } else {
        mes = @"保存图片成功";
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = mes;
    [hud hide:YES afterDelay:1];
    
}

@end

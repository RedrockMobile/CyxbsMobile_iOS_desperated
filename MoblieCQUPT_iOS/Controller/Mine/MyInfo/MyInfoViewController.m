//
//  MyInfoViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/4/21.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoModel.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+AFNetworking.h"
#import "UITextField+Custom.h"
#import "LoginEntry.h"
#import "MBProgressHUD.h"

@interface MyInfoViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MyInfoModel *MyInfoModel;
@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UITextField *nicknameTextField;
@property (strong, nonatomic) UITextField *introductionTextField;
@property (strong, nonatomic) UITextField *qqTextField;
@property (strong, nonatomic) UITextField *phoneTextField;

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(refreshMyInfo)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"myInfoModel"];
    _MyInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"_MyInfoModel :%@", _MyInfoModel);
}

- (void)viewWillAppear:(BOOL)animated {
}

//更新数据，上传服务器
- (void)refreshMyInfo {
    //获取已登录用户的账户信息
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Person/setInfo"
                            WithParameter:@{@"stuNum":stuNum, @"idNum":idNum, @"nickname":_nicknameTextField.text, @"introduction":_introductionTextField.text, @"qq":_qqTextField.text, @"phone":_phoneTextField.text}
                     WithReturnValeuBlock:^(id returnValue) {
                         NSString *status = [returnValue objectForKey:@"status"];
                         if ([status isEqualToString:@"200"]) {
                             MBProgressHUD *uploadProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                             uploadProgress.mode = MBProgressHUDModeText;
                             uploadProgress.labelText = @"上传成功";
                             [uploadProgress hide:YES afterDelay:1];
                         }
    } WithFailureBlock:^{
        UILabel *faileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        faileLable.text = @"哎呀！网络开小差了 T^T";
        faileLable.textColor = [UIColor blackColor];
        faileLable.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        faileLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:faileLable];
        [_tableView removeFromSuperview];
    }];

}

//归档个人信息并上传
- (void)viewWillDisappear:(BOOL)animated {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_MyInfoModel];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"myInfoModel"];
    NSLog(@"_MyInfoModel :%@", _MyInfoModel);
}

#pragma mark - TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 15.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 83;
    }
    return 43;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //设置每个cell的名字
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = kFont;
    textLabel.textColor = kDetailTextColor;
    
    NSArray *titles = @[@"头像修改", @"昵称", @"简介", @"QQ", @"电话"];
    
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:identifer];
    }
    
    if (indexPath.section == 0) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userinfo"];

        [cell.contentView addSubview:self.avatar];
        
        textLabel.text = titles[indexPath.section];
        textLabel.frame = CGRectMake(20, 35, 0, 0);
        [textLabel sizeToFit];
        [cell.contentView addSubview:textLabel];
        
    } else if (indexPath.section == 1) {
        textLabel.text = titles[indexPath.row+1];
        textLabel.frame = CGRectMake(20, 15, 0, 0);
        [textLabel sizeToFit];
        [cell.contentView addSubview:textLabel];
        
        if (indexPath.row == 0) {
            _nicknameTextField = [[UITextField alloc] initWithPlaceholder:@"请输入昵称" andCell:cell];
            _nicknameTextField.delegate = self;
            [cell.contentView addSubview:_nicknameTextField];
        } else if (indexPath.row == 1) {
            _introductionTextField = [[UITextField alloc] initWithPlaceholder:@"请输入个性签名" andCell:cell];
            _introductionTextField.delegate = self;
            [cell.contentView addSubview:_introductionTextField];
        }
        
    } else if (indexPath.section == 2) {
        textLabel.text = titles[indexPath.row+3];
        textLabel.frame = CGRectMake(20, 15, 0, 0);
        [textLabel sizeToFit];
        [cell.contentView addSubview:textLabel];
        
        if (indexPath.row == 0) {
            _qqTextField = [[UITextField alloc] initWithPlaceholder:@"写下QQ,方便交流" andCell:cell];
            _qqTextField.delegate = self;
            [cell.contentView addSubview:_qqTextField];
        } else {
            _phoneTextField = [[UITextField alloc] initWithPlaceholder:@"留下电话，交个朋友" andCell:cell];
            _phoneTextField.delegate = self;
            [cell.contentView addSubview:_phoneTextField];
        }
    }
    
    return cell;
}

//初始化头像
- (UIImageView *)avatar {
    
    _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_W-50-40, 18, 50, 50)];
    _avatar.userInteractionEnabled = YES;
    [_avatar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeaderImage)]];
    _avatar.layer.masksToBounds = YES;
    _avatar.layer.cornerRadius = _avatar.frame.size.width/2;
    
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"avatar"];
//    if (![UIImage imageWithContentsOfFile:path]) {
//        _avatar.image = [UIImage imageNamed:@"new_icon_menu_5.png"];
//    } else {
//        _avatar.image = [UIImage imageWithContentsOfFile:path];
//    }
    
    if (!_MyInfoModel.thumbnailAvatar) {
        _avatar.image = [UIImage imageNamed:@"new_icon_menu_5.png"];
    } else {
        _avatar = _MyInfoModel.thumbnailAvatar;
    }
    return _avatar;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"introductionChanged" object:textField.text];
}

#pragma mark - 更改头像
- (void)changeHeaderImage {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.allowsEditing = YES;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo {
    _avatar.image = image;
    
    //头像上传
//    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
//    [NetWork uploadImageWithUrl:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/home/photo/upload" WithParameter:@{@"stuNum":stuNum} WithUploadImage:image WithReturnValueBlock:^(id returnValue) {
//        NSLog(@"returValue :%@", returnValue);
//    } WithFailureBlock:^{
//        NSLog(@"头像上传失败");
//    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"avatarChanged" object:image];
    
    //数据持久化
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"avatar"];
//    [UIImagePNGRepresentation(_avatar.image) writeToFile:path atomically:YES];
    _MyInfoModel.thumbnailAvatar = imageView;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end

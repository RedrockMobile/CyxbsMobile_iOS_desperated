//
//  MyInfoViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/4/21.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MyInfoViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+AFNetworking.h"
#import "UITextField+Custom.h"
#import "LoginEntry.h"
#import "MBProgressHUD.h"


@interface MyInfoViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UITextField *nicknameTextField;
@property (strong, nonatomic) UITextField *introductionTextField;
@property (strong, nonatomic) UITextField *qqTextField;
@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) NSMutableDictionary *data;

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

    //网络请求头像和简介
        //获取已登录用户的账户信息
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Person/search" WithParameter:@{@"stuNum":stuNum, @"idNum":idNum} WithReturnValeuBlock:^(id returnValue) {
        
        if ([returnValue objectForKey:@"data"]) {
            if (!_data) {
                _data = [[NSMutableDictionary alloc] init];
                [_data setDictionary:[returnValue objectForKey:@"data"]];
            } else {
                [_data removeAllObjects];
                [_data setDictionary:[returnValue objectForKey:@"data"]];
            }
            NSLog(@"_data :%@", _data);
            
            //更新信息
            if ([_data[@"photo_thumbnail_src"] isEqualToString:@""]) {
                [_avatar setImage:[UIImage imageNamed:@"headImage.png"]];
            } else {
                [_avatar sd_setImageWithURL:[NSURL URLWithString:_data[@"photo_thumbnail_src"]]];
            }
            
            if (![_data[@"nickname"] isEqualToString:@""]) {
                _nicknameTextField.text = _data[@"nickname"];
            }
            
            if (![_data[@"introduction"] isEqualToString:@""]) {
                _introductionTextField.text = _data[@"introduction"];
            }
            
            if (![_data[@"qq"] isEqualToString:@""]) {
                _qqTextField.text = _data[@"qq"];
            }
            
            if (![_data[@"phone"] isEqualToString:@""]) {
                _phoneTextField.text = _data[@"phone"];
            }
        }
        
    } WithFailureBlock:^{
        
    }];

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
                         NSString *status = [returnValue objectForKey:@"info"];
                         if ([status isEqualToString:@"success"]) {
                             MBProgressHUD *uploadProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                             uploadProgress.mode = MBProgressHUDModeText;
                             uploadProgress.labelText = @"上传成功";
                             [uploadProgress hide:YES afterDelay:1];
                         } else if ([status isEqualToString:@"failed"]) {
                             MBProgressHUD *uploadProgress1 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                             uploadProgress1.mode = MBProgressHUDModeText;
                             uploadProgress1.labelText = @"非法关键字，请重新输入";
                             [uploadProgress1 hide:YES afterDelay:1];
                         }
    } WithFailureBlock:^{
    
    }];
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
    [_avatar setImage:[UIImage imageNamed:@"headImage.png"]];
    [_avatar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeaderImage)]];
    _avatar.layer.masksToBounds = YES;
    _avatar.layer.cornerRadius = _avatar.frame.size.width/2;
    
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"avatar"];
//    if (![UIImage imageWithContentsOfFile:path]) {
//        _avatar.image = [UIImage imageNamed:@"new_icon_menu_5.png"];
//    } else {
//        _avatar.image = [UIImage imageWithContentsOfFile:path];
//    }
    
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
    //上传头像
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    MOHImageParamModel *model = [[MOHImageParamModel alloc] init];
    model.paramName = @"fold";
    model.uploadImage = image;
    [NetWork uploadImageWithUrl:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/home/photo/upload"
                    imageParams:@[model]
                    otherParams:@{@"stunum":stuNum}
               imageQualityRate:0.5
                   successBlock:^(id returnValue) {
                       
                   } failureBlock:^{
                       
                   }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end

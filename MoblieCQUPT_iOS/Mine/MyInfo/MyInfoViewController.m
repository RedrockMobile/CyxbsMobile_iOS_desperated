//
//  MyInfoViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/4/21.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MyInfoViewController.h"
#import "UITextField+Custom.h"
#import "MyInfoModel.h"

@interface MyInfoViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UITextField *nicknameTextField;
@property (strong, nonatomic) UITextField *introductionTextField;
@property (strong, nonatomic) UITextField *qqTextField;
@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) MyInfoModel *model;
@property (strong, nonatomic) UIImage *image;
@property (copy, nonatomic) NSDictionary *parameters;
typedef NS_ENUM(NSInteger,XBSUploadState){
    XBSUploadStateSuccess,
    XBSUploadStateNetWorkWrong,
    XBSUploadStateParameterWrong,
};
@property XBSUploadState imageUploadState;
@property XBSUploadState infoUploadState;

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [MyInfoModel getMyInfo];
    self.image = self.model.photo_thumbnail_src;
    [self.view addSubview:self.tableView];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(uploadData)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
//        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}

- (UIImageView *)avatar {
    if (!_avatar) {
        _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_W-50-40, 18, 50, 50)];
        _avatar.userInteractionEnabled = YES;
        //    [_avatar setImage:[UIImage imageNamed:@"headImage.png"]];
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = _avatar.frame.size.width/2;
    }
    return _avatar;
}

- (void)uploadData{
    dispatch_group_t group = dispatch_group_create();
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    self.parameters = @{@"stuNum":stuNum, @"idNum":idNum, @"nickname":_nicknameTextField.text, @"introduction":_introductionTextField.text, @"qq":_qqTextField.text, @"phone":_phoneTextField.text};
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self refreshMyInfo];
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (![self.model.photo_thumbnail_src isEqual:self.image]) {
            [self uploadImage];
        }
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        MBProgressHUD *uploadProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        uploadProgress.mode = MBProgressHUDModeText;
        if (self.imageUploadState == XBSUploadStateNetWorkWrong || self.infoUploadState == XBSUploadStateNetWorkWrong) {
            uploadProgress.labelText = @"网络错误";
            [uploadProgress hide:YES afterDelay:1];
            return;
        }
        if (self.infoUploadState == XBSUploadStateParameterWrong) {
            uploadProgress.labelText = @"参数错误";
            [uploadProgress hide:YES afterDelay:1];
            return;
        }
        uploadProgress.labelText = @"上传成功";
        self.model.nickname = self.nicknameTextField.text;
        self.model.introduction = self.introductionTextField.text;
        self.model.qq = self.qqTextField.text;
        self.model.phone = self.phoneTextField.text;
        self.model.photo_thumbnail_src = self.image;
        [self.model saveMyInfo];
        [self.navigationController popViewControllerAnimated:YES];
    });
}



//更新数据，上传服务器
- (void)refreshMyInfo {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:SETINFO_API method:HttpRequestPost parameters:self.parameters prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *status = responseObject[@"info"];
        if ([status isEqualToString:@"success"]) {
            self.infoUploadState = XBSUploadStateSuccess;
        } else if ([status isEqualToString:@"failed"]) {
            self.infoUploadState = XBSUploadStateParameterWrong;
        }
        dispatch_semaphore_signal(sema);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.infoUploadState = XBSUploadStateNetWorkWrong;
        dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

- (void)uploadImage{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSString *stuNum = [UserDefaultTool getStuNum];
    MOHImageParamModel *model = [[MOHImageParamModel alloc] init];
    model.paramName = @"fold";
    model.uploadImage = self.image;
    [NetWork uploadImageWithUrl:UPLOAD_IMAGE_API
                    imageParams:@[model]
                    otherParams:@{@"stunum":stuNum}
               imageQualityRate:1
                   successBlock:^(id returnValue) {
                       self.imageUploadState = XBSUploadStateSuccess;
                       dispatch_semaphore_signal(sema);
                   } failureBlock:^{
                       self.imageUploadState = XBSUploadStateNetWorkWrong;
                       dispatch_semaphore_signal(sema);
                   }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

#pragma mark - TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 4;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 15.f;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 83.f/667*SCREENHEIGHT;
    }
    return 43.f/667*SCREENHEIGHT;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //设置每个cell的名字
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = kFont;
    textLabel.textColor = kDetailTextColor;
    NSArray *titles = @[@"头像", @"昵称", @"简介", @"QQ", @"电话"];
    static NSString *const identifer = @"cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:identifer];
    }
    if (indexPath.section == 0) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userinfo"];
        [cell.contentView addSubview:self.avatar];
        self.avatar.image = self.model.photo_thumbnail_src;
        textLabel.text = titles[indexPath.section];
        textLabel.frame = CGRectMake(20, 35, 0, 0);
        [textLabel sizeToFit];
        [cell.contentView addSubview:textLabel];
    } else if (indexPath.section == 1) {
        textLabel.text = titles[indexPath.row+1];
        textLabel.frame = CGRectMake(20, 15, 0, 0);
        [textLabel sizeToFit];
        [cell.contentView addSubview:textLabel];
        UIImageView *point = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backPoint"]];
        point.frame = CGRectMake(SCREENWIDTH - 20, cell.size.height / 2 - textLabel.size.height / 2, textLabel.size.height / 2, textLabel.size.height);
        [cell.contentView addSubview:point];
        if (indexPath.row == 0) {
            self.nicknameTextField = [UITextField initWithPlaceholder:@"请输入昵称" andCell:cell];
            self.nicknameTextField.delegate = self;
            self.nicknameTextField.text = self.model.nickname;
            [cell.contentView addSubview:_nicknameTextField];
        } else if (indexPath.row == 1) {
            _introductionTextField = [UITextField initWithPlaceholder:@"请输入个性签名" andCell:cell];
            _introductionTextField.delegate = self;
            _introductionTextField.text = self.model.introduction;
            [cell.contentView addSubview:_introductionTextField];
        }
        else if (indexPath.row == 2) {
            _qqTextField = [UITextField initWithPlaceholder:@"写下QQ,方便交流" andCell:cell];
            _qqTextField.delegate = self;
            _qqTextField.text = self.model.qq;
            [cell.contentView addSubview:_qqTextField];
        } else {
            _phoneTextField = [UITextField initWithPlaceholder:@"留下电话，交个朋友" andCell:cell];
            _phoneTextField.delegate = self;
            _phoneTextField.text = self.model.phone;
            [cell.contentView addSubview:_phoneTextField];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - 更改头像
- (void)changeHeaderImage {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.allowsEditing = YES;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if ([image isKindOfClass:[UIImage class]]) {
        self.avatar.image = image;
        self.image = image;
    }
    else{
        NSLog(@"Something went wrong");
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark - TextFieldDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self changeHeaderImage];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   return [textField resignFirstResponder];
}

@end

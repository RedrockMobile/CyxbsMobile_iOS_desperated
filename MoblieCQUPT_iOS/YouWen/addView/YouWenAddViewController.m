//
//  YouWenAddViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/1.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenAddViewController.h"

#import <Masonry.h>
#import "YouWenTimeView.h"
#import "YouWenSoreView.h"
#import "YouWenResultView.h"
#import "TransparentView.h"
#import "YouWenSubjectView.h"
#import "YouWenAddModel.h"
#import "NSString+Emoji.h"
#import "SheetAlertController.h"
#import "UIViewController+BackButtonHandler.h"

#define PHOTOSIZE 109
@interface YouWenAddViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, getInformation, MBProgressHUDDelegate, YouWenAddDelegate, BackButtonHandlerProtocol>

@property (strong, nonatomic) ReportTextView *titleTextView;
@property (strong, nonatomic) ReportTextView *detailTextView;
@property (copy, nonatomic) NSString *style;
@property (strong, nonatomic) UIView *whiteView;
@property (strong, nonatomic) UIView *bottomView;
@property (copy, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) UIButton *addImageButton;
@property (strong, nonatomic) UIScrollView *imageView;
@property (strong, nonatomic) NSMutableArray *anotherInf;


@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *sore;
@property (copy, nonatomic) NSString *is_anonymous;
@property (copy, nonatomic) NSString *subject;
@property (strong, nonatomic) TransparentView *photoView;
@end

@implementation YouWenAddViewController

-(instancetype)initWithStyle:(NSString *)style{
    if (self = [super init]) {
        [self setView];
        self.edgesForExtendedLayout = UIRectEdgeNone;
        _titleStr = [NSString string];
        _detailStr = [NSString string];
        _imageArray = [NSArray array].mutableCopy;
        _time = [[NSString alloc] init];
        _sore = [[NSString alloc] init];
        _is_anonymous = @"0";
        _subject = [NSString string];
        self.navigationItem.title = @"求助";
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(confirmInf)];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timeArrive:) name:@"timeNotifi" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(soreArrive:) name:@"soreNotifi" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subjectArrive:) name:@"subjectNotifi" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postTheNew) name:@"finalNotifi" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(draft:) name:@"saveDraft" object:nil];
        _style = [[NSString alloc] initWithString:style];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)viewWillAppear:(BOOL)animated{
    [self.view removeAllSubviews];
    [self setWriteView];
    [self setBottomView];
    [self setImageView];
    [self LayOut];
    
}

- (BOOL)navigationShouldPopOnBackButton{
    if (_detailTextView.text.length ||_titleTextView.text.length ) {
        SheetAlertController *controller = [SheetAlertController draftsAlert];
        controller.style = @"question";
        controller.contentStr = _detailTextView.text;
        controller.kind = self.style;
        controller.titleStr = _titleTextView.text;
        [self presentViewController:controller
                           animated:YES
                         completion:nil];
        return NO;
    }
    return YES;
}

- (void)setView{
    self.navigationController.navigationItem.title = @"求助";
    self.view.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
}

- (void)setWriteView{
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_whiteView];
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(327).multipliedBy(SCREEN_HEIGHT / 667);
    }];
    [_whiteView.superview layoutIfNeeded];
    
    _titleTextView = [[ReportTextView alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 30) andState:OnlyWordNum];
    _titleTextView.limitNum = 20;
    _titleTextView.placeHolder.text = @"请输入标题";
    if (_titleStr.length) {
        _titleTextView.text = _titleStr;
    }
    UIView *blackLine = [[UIView alloc] initWithFrame:CGRectMake(15, _titleTextView.bottom, SCREEN_WIDTH - 30, 1)];
    blackLine.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    _detailTextView = [[ReportTextView alloc] initWithFrame:CGRectMake(15, blackLine.bottom + 11, SCREEN_WIDTH - 30, _whiteView.height - blackLine.bottom - 11) andState:OnlyWordNum];
    _detailTextView.limitNum = 200;
    self.detailTextView.placeHolder.text = @"详细描述你的问题和需求，表达越清楚，越容易获得帮助哦！";
    if (_detailStr.length) {
        _detailTextView.text = _detailStr;
    }
    _detailTextView.inputAccessoryView = [self addToolBar];
    _titleTextView.inputAccessoryView = [self addToolBar];

    [_whiteView addSubview:_titleTextView];
    [_whiteView addSubview:_detailTextView];
    [_whiteView addSubview:blackLine];
}

- (void)setImageView{
    _imageView = [[UIScrollView alloc]init];
    _imageView.contentSize = CGSizeMake(SCREEN_WIDTH, _imageArray.count / 3 * PHOTOSIZE + 216 - 60);
    _imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_imageView];
    CGRect final;
    for (int i = 0; i < _imageArray.count; i ++) {
        UIImageView *imView = [[UIImageView alloc]init];
        imView.layer.cornerRadius = 4.0;
        imView.layer.masksToBounds = YES;
        if (!i % 3) {
            imView.frame =  CGRectMake(15, 17 + i / 3 * (PHOTOSIZE + 10), PHOTOSIZE, PHOTOSIZE);
        }
        else {
            imView.frame =  CGRectMake(15 + i % 3 * (PHOTOSIZE + 10), 17 + i / 3 * (PHOTOSIZE + 10), PHOTOSIZE, PHOTOSIZE);
        }
        imView.image = _imageArray[i];
        [_imageView addSubview:imView];
        if (i == _imageArray.count - 1) {
            final = imView.frame;
        }
    }
    if (!_imageArray.count % 3) {
        self.addImageButton.frame = CGRectMake(15, _imageArray.count / 3 * (PHOTOSIZE + 10) + 17, PHOTOSIZE, PHOTOSIZE);
    }
    else {
        self.addImageButton.frame =  CGRectMake(15 + _imageArray.count % 3 * (PHOTOSIZE + 10), 17 + _imageArray.count / 3 * (PHOTOSIZE + 10), PHOTOSIZE, PHOTOSIZE);
    }
    [_imageView addSubview: self.addImageButton];
}

- (void)setBottomView{
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoButton setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(selectImage)
          forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:photoButton];
    
    UIButton *topicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [topicButton setImage:[UIImage imageNamed:@"topic"] forState:UIControlStateNormal];
    [topicButton addTarget:self action:@selector(addTopic) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:topicButton];
    
    UIButton *anonymityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [anonymityButton setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    [anonymityButton setImage:[UIImage imageNamed:@"anonymity"] forState:UIControlStateSelected];
    [anonymityButton addTarget:self action:@selector(anonymityState:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:anonymityButton];
    
    [topicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bottomView).mas_offset(15);
        make.top.mas_equalTo(_bottomView).mas_offset(13);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    [photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topicButton.mas_right).
        mas_offset(37);
        make.top.mas_equalTo(_bottomView).mas_offset(13);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(24);
    }];
    
    [anonymityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_bottomView).mas_offset(-15);
        make.top.mas_equalTo(_bottomView).mas_offset(16);
        make.width.mas_equalTo(88);
        make.height.mas_equalTo(18);
    }];
}

- (void)LayOut{
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [_bottomView.superview layoutIfNeeded];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.whiteView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(-1);
    }];
    

}

- (void)addTopic{
    YouWenSubjectView *subjectView = [[YouWenSubjectView alloc] initTheWhiteViewHeight:300];
    [subjectView addDetail];
    [[UIApplication sharedApplication].keyWindow addSubview:subjectView];
}

- (UIButton *)addImageButton{
    if (!_addImageButton){
        _addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageButton setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        [_addImageButton addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageButton;
}

- (void)confirmInf{
    //textview当字数为0时返回nil
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (_titleTextView.text.length == 0 || _detailTextView.text.length == 0) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"注意" message:@"还没有完善信息哦" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定"
                      style:UIAlertActionStyleDefault
                    handler:nil]];
        [self presentViewController:alertCon
                           animated:YES
                         completion:nil];
    }
    else{
        [self nextView];
    }
}

- (void)nextView{
    _anotherInf = [NSMutableArray array];
    if (_time.length < 16){
        YouWenTimeView *nextView = [[YouWenTimeView alloc] initTheWhiteViewHeight:ZOOM(211)];
        [nextView addDetail];
        [[UIApplication sharedApplication].keyWindow addSubview:nextView];
    }
    else if([_sore isEqualToString:@"0"]){
        YouWenSoreView *nextView = [[YouWenSoreView alloc] initTheWhiteViewHeight:ZOOM(211)];
        [nextView addDetail];
        [[UIApplication sharedApplication].keyWindow addSubview:nextView];
    }
    else{
        YouWenResultView *resultView = [[YouWenResultView alloc] initTheWhiteViewHeight:ZOOM(211)];
        resultView.time = _time;
        resultView.sore = _sore;
        [resultView addDetail];
        [[UIApplication sharedApplication].keyWindow addSubview:resultView];
    }
}
- (void)timeArrive:(NSNotification *)noti{
    _time = noti.object[@"time"];
    if (_time.length < 16) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"注意" message:@"请选择日期" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定"
                      style:UIAlertActionStyleDefault
                    handler:nil]];
        [self presentViewController:alertCon
                           animated:YES
                         completion:nil];
    }
    else{
        YouWenSoreView *nextView = [[YouWenSoreView alloc] initTheWhiteViewHeight:ZOOM(211)];
        [nextView addDetail];
        [[UIApplication sharedApplication].keyWindow addSubview:nextView];
    }
}

- (void)subjectArrive:(NSNotification *)noti{
    _subject = noti.object[@"subject"];
    if (_subject.length != 0){
        [_titleTextView addTopic:_subject];
    }
    
}
- (void)draft:(NSNotification *)noti{
    NSString *state = noti.userInfo[@"state"];
    if ([state isEqualToString:@"SENDING"]) {
        _hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
        _hud.dimBackground = YES;
        _hud.removeFromSuperViewOnHide=YES;
        _hud.labelText = @"上传中";
        _hud.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:_hud];
        [_hud show:YES];
    }
    if ([state isEqualToString:@"SUCCESS"]){
        _hud.labelText = @"上传成功";
        [_hud hide:YES afterDelay:2];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([state isEqualToString:@"FAIL"]) {
        _hud.labelText = @"上传失败";
        [_hud hide:YES afterDelay:2];
    }
    
    if ([state isEqualToString:@"BACK"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)soreArrive:(NSNotification *)noti{
    _sore = noti.object[@"sore"];
    if ([_sore isEqualToString:@"0"]) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"注意" message:@"请选择积分" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定"
            style:UIAlertActionStyleDefault
                                                   handler:nil]];
        [self presentViewController:alertCon
                           animated:YES
                         completion:nil];
    }
    else{
        YouWenResultView *resultView = [[YouWenResultView alloc] initTheWhiteViewHeight:ZOOM(211)];
        resultView.time = _time;
        resultView.sore = _sore;
        [resultView addDetail];
        [[UIApplication sharedApplication].keyWindow addSubview:resultView];
    }
}

- (void)postTheNew{

    NSString *title = [_titleTextView.text stringByReplacingEmojiUnicodeWithCheatCodes];
    NSString *detail = [_detailTextView.text stringByReplacingEmojiUnicodeWithCheatCodes];
    
    
    NSDictionary *dic = @{@"title":title, @"description":detail,@"is_anonymous":_is_anonymous,@"kind":_style,@"tags":_subject,@"reward":_sore,@"disappear_time":_time};
    
    YouWenAddModel *model = [[YouWenAddModel alloc] initWithInformation:dic andImage:_imageArray];
    model.delegate = self;
    [model postTheNewInformation];
    _hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    _hud.dimBackground = YES;
    _hud.removeFromSuperViewOnHide=YES;
    _hud.labelText = @"上传中";
    _hud.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:_hud];
    [_hud show:YES];
}

- (void)missionComplete{
    [_hud hide:YES];
    [_hud removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
//照片
- (void)selectImage{
    _photoView = [[TransparentView alloc] initTheWhiteViewHeight:150];
    UIButton *pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pictureBtn setTitle:@"从相册中选择" forState:UIControlStateNormal];
    [pictureBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [pictureBtn addTarget:self action:@selector(selectPicture) forControlEvents:UIControlEventTouchUpInside];
    pictureBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    [_photoView.whiteView addSubview:pictureBtn];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [photoBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    photoBtn.frame = CGRectMake(0, 50, SCREEN_WIDTH, 50);
    [_photoView.whiteView addSubview:photoBtn];
    _titleStr = _titleTextView.text;
    _detailStr = _detailTextView.text;
    [[UIApplication sharedApplication].keyWindow addSubview:_photoView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(0, 100, SCREEN_WIDTH, 50);
    [_photoView.whiteView addSubview:cancelButton];
}
- (void)selectPicture{
    [_photoView removeFromSuperview];
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)takePhoto{
    [_photoView removeFromSuperview];
    
    if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else {
        UIAlertController * alertController = [UIAlertController
      alertControllerWithTitle:@"温馨提示"
                       message:@"当前设备不支持拍照"
                preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                         style:UIAlertActionStyleDefault
                      handler:nil]];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
}

- (void)cancel{
    [_photoView removeFromSuperview];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if ([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
            [self.imageArray appendObject:info[UIImagePickerControllerOriginalImage]];
        }
    }else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        [self.imageArray appendObject: info[UIImagePickerControllerEditedImage]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];  
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)anonymityState:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        _is_anonymous = @"0";
    }
    else{
        _is_anonymous = @"1";
    }
}


/**
 键盘上用于回收键盘的ToolBar

 @return ToolBar
 */
- (UIToolbar *)addToolBar{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    toolBar.tintColor = [UIColor blackColor];
    toolBar.backgroundColor = [UIColor lightGrayColor];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolBar.items = @[doneItem];
    return toolBar;
}

- (void)textFieldDone{
    [self.view endEditing:YES];
}

@end

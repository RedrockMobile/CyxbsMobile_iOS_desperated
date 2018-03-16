//
//  YouWenAddViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/1.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenAddViewController.h"
#import "ReportTextView.h"
#import <Masonry.h>
#import "YouWenTimeView.h"
#import "YouWenSoreView.h"
#import "YouWenResultView.h"
#import "TransparentView.h"
#define PHOTOSIZE (ScreenWidth - 30) / 3

@interface YouWenAddViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, getInformation>
@property (copy, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) ReportTextView *titleTextView;
@property (strong, nonatomic) ReportTextView *detailTextView;
@property (strong, nonatomic) UIButton *addImageButton;
@property (strong, nonatomic) UIScrollView *imageView;
@property (strong, nonatomic) NSMutableArray *anotherInf;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *sore;
@property (strong, nonatomic) TransparentView *photoView;
@end

@implementation YouWenAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setView];
    _imageArray = [NSArray array].mutableCopy;
    _time = [[NSString alloc] init];
    _sore = [[NSString alloc] init];
    self.navigationItem.title = @"求助";
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(nextView)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timeArrive:) name:@"timeNotifi" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(soreArrive:) name:@"soreNotifi" object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.view removeAllSubviews];
    [self setWriteView];
    [self setImageView];
    [self setBottomView];
}
- (void)setView{
    self.navigationController.navigationItem.title = @"求助";
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)setWriteView{
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, (ScreenHeight - 64) / 3 * 2)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    _titleTextView = [[ReportTextView alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 30) andState:OnlyWordNum];
    _titleTextView.limitNum = 20;
    _titleTextView.placeHolder.text = @"请输入标题";
    _detailTextView = [[ReportTextView alloc] initWithFrame:CGRectMake(10, 40, ScreenWidth - 20, whiteView.height - _titleTextView.bottom - 10) andState:OnlyWordNum];
    _detailTextView.limitNum = 200;
    _detailTextView.placeHolder.text = @"详细描述你的问题和需求，表达越清楚，越容易获得帮助哦！";
    UIView *blackLine = [[UIView alloc] initWithFrame:CGRectMake(10, _titleTextView.bottom, ScreenWidth - 20, 1)];
    blackLine.backgroundColor = [UIColor blackColor];

    [whiteView addSubview:_titleTextView];
    [whiteView addSubview:_detailTextView];
    [whiteView addSubview:blackLine];
}

- (void)setImageView{
    _imageView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, (ScreenHeight - 64) / 3 * 2  + 5, ScreenWidth, (ScreenHeight - 64)/ 3 - 35)];
    _imageView.contentSize = CGSizeMake(ScreenWidth, _imageArray.count / 3 * PHOTOSIZE + ((ScreenHeight - 64)/ 3 - 10));
    _imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_imageView];
    CGRect final;
    for (int i = 0; i < _imageArray.count; i ++) {
        UIImageView *imView = [[UIImageView alloc]init];
        imView.layer.cornerRadius = 2.0;
        imView.layer.masksToBounds = YES;
        if (!i % 3) {
            imView.frame =  CGRectMake(10, i / 3 * (PHOTOSIZE + 5) + 20, PHOTOSIZE, PHOTOSIZE);
        }
        else {
            imView.frame =  CGRectMake(10 + i % 3 * (PHOTOSIZE + 5), 10 + i / 3 * (PHOTOSIZE + 5), PHOTOSIZE, PHOTOSIZE);
        }
        imView.image = _imageArray[i];
        [_imageView addSubview:imView];
        if (i == _imageArray.count - 1) {
            final = imView.frame;
        }
    }
    if (!_imageArray.count % 3) {
        self.addImageButton.frame = CGRectMake(10, _imageArray.count / 3 * (PHOTOSIZE + 5) + 10, PHOTOSIZE, PHOTOSIZE);
    }
    else {
        self.addImageButton.frame =  CGRectMake(10 + _imageArray.count % 3 * (PHOTOSIZE + 5), 10 + _imageArray.count / 3 * (PHOTOSIZE + 5), PHOTOSIZE, PHOTOSIZE);
    }
    [_imageView addSubview: self.addImageButton];
}

- (void)setBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _imageView.bottom +  1, ScreenWidth, 29)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoButton setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(selectImage)
          forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:photoButton];
    
    UIButton *topicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [topicButton setImage:[UIImage imageNamed:@"topic"] forState:UIControlStateNormal];
    [topicButton addTarget:self action:@selector(addTopic) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:topicButton];
    
    UIButton *anonymityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [anonymityButton setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    [anonymityButton setImage:[UIImage imageNamed:@"anonymity"] forState:UIControlStateSelected];
    [anonymityButton addTarget:self action:@selector(anonymityState) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:anonymityButton];
    
    [topicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView).mas_offset(10);
        make.top.mas_equalTo(bottomView).mas_offset(5);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topicButton.mas_right).
        mas_offset(50);
        make.top.mas_equalTo(bottomView).mas_offset(5);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [anonymityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bottomView).mas_offset(-10);
        make.top.mas_equalTo(bottomView).mas_offset(5);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(20);
    }];
}
- (UIButton *)addImageButton{
    if (!_addImageButton){
        _addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageButton setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        [_addImageButton addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageButton;
}
- (void)nextView{
    _anotherInf = [NSMutableArray array];
    _anotherInf = [NSMutableArray array];
    if (!_time.length){
        YouWenTimeView *nextView = [[YouWenTimeView alloc] initTheWhiteViewHeight:300];
        [nextView addDetail];
        [[UIApplication sharedApplication].keyWindow addSubview:nextView];
    }
    else{
        YouWenSoreView *nextView = [[YouWenSoreView alloc] initTheWhiteViewHeight:300];
        [nextView addDetail];
        [[UIApplication sharedApplication].keyWindow addSubview:nextView];
    }
}
- (void)timeArrive:(NSNotification *)noti{
    _time = noti.object[@"time"];
    YouWenSoreView *nextView = [[YouWenSoreView alloc] initTheWhiteViewHeight:300];
    [nextView addDetail];
    [[UIApplication sharedApplication].keyWindow addSubview:nextView];
}
- (void)soreArrive:(NSNotification *)noti{
    _sore = noti.object[@"sore"];
    YouWenResultView *resultView = [[YouWenResultView alloc] initTheWhiteViewHeight:300];
    resultView.time = _time;
    resultView.sore = _sore;
    [resultView addDetail];
    [[UIApplication sharedApplication].keyWindow addSubview:resultView];
}
//照片
- (void)selectImage{
    _photoView = [[TransparentView alloc] initTheWhiteViewHeight:100];
    UIButton *pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pictureBtn setTitle:@"从相册中选择" forState:UIControlStateNormal];
    [pictureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [pictureBtn addTarget:self action:@selector(selectPicture) forControlEvents:UIControlEventTouchUpInside];
    pictureBtn.frame = CGRectMake(0, 0, ScreenWidth, 50);
    [_photoView.whiteView addSubview:pictureBtn];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [photoBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    photoBtn.frame = CGRectMake(0, 50, ScreenWidth, 50);
    [_photoView.whiteView addSubview:photoBtn];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_photoView];

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
        NSLog(@"当前设备不支持拍照");
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

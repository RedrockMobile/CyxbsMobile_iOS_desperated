//
//  MBReleaseViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/27.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBReleaseViewController.h"
#import "MBAddPhotoContainerView.h"
#import <GMImagePickerController.h>
#import "MBProgressHUD.h"

@interface MBReleaseViewController ()<MBAddPhotoContainerViewAddEventDelegate,GMImagePickerControllerDelegate,UITextViewDelegate>
{
    GMImagePickerController *_pickView;
}
//@property (strong, nonatomic) UIButton *doneBtn;
//@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, readonly) GMImagePickerController *pickView;
@property (strong, nonatomic) UIView *navigationView;
@property (strong, nonatomic) MBInputView *inputView;

@property (strong, nonatomic) NSMutableArray *uploadPicArray;
@property (strong, nonatomic) NSMutableArray *uploadthumbnailPicArray;
@property (strong, nonatomic) NSMutableArray<MOHImageParamModel *> *imageParamer;

@property (strong, nonatomic) MBProgressHUD *hud;
@end

@implementation MBReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.inputView];
    self.view.backgroundColor = BACK_GRAY_COLOR;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    NSLog(@"%d",height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)uploadPicArray {
    if (!_uploadPicArray) {
        _uploadPicArray = [NSMutableArray array];
    }
    return _uploadPicArray;
}
- (NSMutableArray *)uploadthumbnailPicArray {
    if (!_uploadthumbnailPicArray) {
        _uploadthumbnailPicArray = [NSMutableArray array];
    }
    return _uploadthumbnailPicArray;
}

- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        _navigationView.backgroundColor = MAIN_COLOR;
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        titleLabel.text = @"哔哔叨叨";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:17];
        [titleLabel sizeToFit];
        titleLabel.center = CGPointMake(ScreenWidth/2, 42);
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [doneBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [cancelBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        
        doneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [doneBtn sizeToFit];
        [cancelBtn sizeToFit];
        
        doneBtn.center = CGPointMake(ScreenWidth - 15 - doneBtn.frame.size.width/2, 42);
        cancelBtn.center = CGPointMake(15 + cancelBtn.frame.size.width/2, 42);
        
        [doneBtn addTarget:self action:@selector(clickDone:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
        
        [_navigationView addSubview:doneBtn];
        [_navigationView addSubview:cancelBtn];
        
        [_navigationView addSubview:titleLabel];
    }
    
    return _navigationView;
}

- (MBInputView *)inputView {
    if (!_inputView) {
        _inputView = [[MBInputView alloc]initWithFrame:CGRectMake(0, 74, ScreenWidth, 250) withInptuViewStyle:MBInputViewStyleWithPhoto];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.textView.backgroundColor = [UIColor clearColor];
        _inputView.textView.placeholder = @"和大家一起哔哔叨叨吧";
        _inputView.textView.delegate = self;
        _inputView.container.eventDelegate = self;
        _inputView.textView.keyboardType = UIReturnKeySend;
    }
    return _inputView;
}

- (void)clickPhotoContainerViewAdd {
    NSLog(@"点击添加图片");

    [self showViewController:self.pickView sender:nil];

}

- (void)clickDone:(UIButton *)sender {
    NSLog(@"点击完成 : %@",_inputView.textView.text);
    
    if (![_inputView.textView.text isEqualToString:@""]) {
        _imageParamer = [NSMutableArray array];
        for (int i = 0; i < self.inputView.container.sourcePicArray.count; i ++) {
            UIImage *image = self.inputView.container.sourcePicArray[i];
            MOHImageParamModel *imageModel = [[MOHImageParamModel alloc]init];
            imageModel.uploadImage = image;
            imageModel.paramName = @"fold";
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            CGFloat length = [imageData length]/1000/1024.0;
            if (length > 2.0) {
                imageModel.perproRate = 2.0/length;
            }
            [_imageParamer addObject:imageModel];
        }
        if (_imageParamer.count != 0) {
            [self uploadImageWithImageModel:self.imageParamer[0] withFlag:0];
        }else {
            [self releaseNewArticle];
        }
    }else {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"内容不能为空";
        [_hud hide:YES afterDelay:1.5];
    }
    [_inputView.textView resignFirstResponder];
}

- (void)clickCancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickDeleteImageViewWithTag:(NSInteger)tag {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (GMImagePickerController *)pickView{
    if (self && !_pickView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        view.backgroundColor = MAIN_COLOR;
        
        GMImagePickerController *picker = [[GMImagePickerController alloc] init];
        picker.delegate = self;
        picker.title = @"相册";
        
        [picker.view addSubview:view];
        
        picker.customDoneButtonTitle = @"完成";
        picker.customCancelButtonTitle = @"取消";
        
        picker.colsInPortrait = 3;
        picker.colsInLandscape = 5;
        picker.minimumInteritemSpacing = 2.0;
        
        picker.modalPresentationStyle = UIModalPresentationPopover;
        picker.navigationBarTintColor = [UIColor whiteColor];
        picker.navigationBarBackgroundColor = MAIN_COLOR;
        picker.navigationBarTextColor = [UIColor whiteColor];
        picker.mediaTypes = @[@(PHAssetMediaTypeImage)];
        _pickView = picker;
        
    }

    return _pickView;
}

#pragma mark - GMImagePickerControllerDelegate

- (void)assetsPickerController:(GMImagePickerController *)picker didFinishPickingAssets:(NSArray *)assetArray
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.synchronous = YES;
    NSMutableArray<UIImage *> *picMutable = [NSMutableArray array];
    for (PHAsset *ph in assetArray) {
        [[PHImageManager defaultManager] requestImageDataForAsset:ph options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            
            UIImage *image = [UIImage imageWithData:imageData];
            [picMutable addObject:image];
            
        }];
    }
    _inputView.container.sourcePicArray = picMutable;
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}



- (BOOL)assetsPickerController:(GMImagePickerController *)picker shouldSelectAsset:(PHAsset *)asset {
    NSLog(@"已经选了 %ld 张",picker.selectedAssets.count);
    if (picker.selectedAssets.count >= 9) {
        NSLog(@"大于9张了");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:picker.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"只能选9张图片哦";
        
        [hud hide:YES afterDelay:1];
        return NO;
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"点击发送 : %@",_inputView.textView.text);
    }
    
    return YES;
}


- (void)releaseNewArticle {
    NSLog(@"请求发布");
    NSString *type_id = @"5";
    NSString *title = @"随便试试";
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    NSString *user_id = [LoginEntry getByUserdefaultWithKey:@"user_id"];
    NSString *content = self.inputView.textView.text;
    NSString *thumbnail_src = @"";
    NSString *photo_src = @"";
    
    for (int i = 0; i < _uploadPicArray.count; i ++) {
        if (i == 0) {
            photo_src = [NSString stringWithFormat:@"%@",self.uploadPicArray[i]];
        }else {
            photo_src = [NSString stringWithFormat:@"%@,%@",photo_src,self.uploadPicArray[i]];
        }
        
    }
    for (int i = 0; i < _uploadthumbnailPicArray.count; i ++) {
        if (i == 0) {
            thumbnail_src = [NSString stringWithFormat:@"%@",self.uploadthumbnailPicArray[i]];
        }else {
            thumbnail_src = [NSString stringWithFormat:@"%@,%@",thumbnail_src,self.uploadthumbnailPicArray[i]];
        }
    }
    
    NSDictionary *parameter = @{@"stuNum":stuNum,
                                @"idNum":idNum,
                                @"type_id":type_id,
                                @"title":title,
                                @"user_id":user_id,
                                @"content":content,
                                @"photo_src":photo_src,
                                @"thumbnail_src":thumbnail_src};
    _hud.labelText = @"正在发布...";
    __weak typeof(self) weakSelf = self;
    [NetWork NetRequestPOSTWithRequestURL:ADDARTICLE_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        weakSelf.hud.mode = MBProgressHUDModeText;
        weakSelf.hud.labelText = @"发布成功";
        [weakSelf.hud hide:YES afterDelay:1.5];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } WithFailureBlock:^{
        
    }];
    
}

- (void)uploadImageWithImageModel:(MOHImageParamModel *)imageModel withFlag:(NSInteger)flag {
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = [NSString stringWithFormat:@"正在上传第%ld张图片...",flag+1];
    NSLog(@"请求第%ld",flag+1);
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    __weak typeof(self) weakSelf = self;
    __block NSInteger flagBlock = flag;
    [NetWork uploadImageWithUrl:UPLOADARTICLE_API imageParams:@[imageModel] otherParams:@{@"stunum":stuNum} imageQualityRate:1.0 successBlock:^(id returnValue) {
        [weakSelf.hud hide:YES];
        NSRange range = [returnValue[@"data"][@"photosrc"] rangeOfString:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/Public/photo/"];
        NSRange range1 = [returnValue[@"data"][@"thumbnail_src"] rangeOfString:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/Public/photo/thumbnail/"];
        NSString *photoUrlString = [returnValue[@"data"][@"photosrc"] substringFromIndex:range.length];
        NSString *thumbnailUrlString = [returnValue[@"data"][@"thumbnail_src"] substringFromIndex:range1.length];
        
        [weakSelf.uploadPicArray addObject:photoUrlString];
        [weakSelf.uploadthumbnailPicArray addObject:thumbnailUrlString];
        flagBlock++;
        if (flagBlock < weakSelf.imageParamer.count) {
            [weakSelf uploadImageWithImageModel:weakSelf.imageParamer[flagBlock] withFlag:flagBlock];
        }else {
            [weakSelf.hud hide:YES];
            [weakSelf releaseNewArticle];
        }
    } failureBlock:^{
        weakSelf.hud.mode = MBProgressHUDModeText;
        weakSelf.hud.labelText = @"网络错误";
        [weakSelf.hud hide:YES afterDelay:1.5];
    }];
}


//Optional implementation:
-(void)assetsPickerControllerDidCancel:(GMImagePickerController *)picker
{
    NSLog(@"GMImagePicker: User pressed cancel button");
}
@end

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
#import "TopicViewController.h"

@interface MBReleaseViewController ()<MBAddPhotoContainerViewAddEventDelegate,GMImagePickerControllerDelegate,UITextViewDelegate>

@property (strong, nonatomic) GMImagePickerController *pickView;
@property (strong, nonatomic) MBInputView *inputView;

@property (strong, nonatomic) NSMutableArray *uploadPicArray;
@property (strong, nonatomic) NSMutableArray *uploadthumbnailPicArray;
@property (strong, nonatomic) NSMutableArray<MOHImageParamModel *> *imageParamer;
@property BOOL isTopic;
@property TopicModel *topic;
@property (strong, nonatomic) MBProgressHUD *hud;
@property TopicViewController *topicVC;
@end

@implementation MBReleaseViewController
- (instancetype)initWithTopic:(TopicModel *)topic{
    self = [self init];
    if(self){
        self.isTopic = YES;
        self.topic = topic;
        self.inputView.textView.text = topic.keyword;
        [self textViewDidChange:self.inputView.textView];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.inputView];
    [self initBar];
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

- (void)initBar{
    self.navigationItem.title = @"哔哔叨叨";
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    
//    [doneBtn setTitleColor:FONT_COLOR forState:UIControlStateNormal];
//    [cancelBtn setTitleColor:FONT_COLOR forState:UIControlStateNormal];
//    
//    [doneBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
//    [cancelBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [doneBtn sizeToFit];
    [cancelBtn sizeToFit];
    
    doneBtn.center = CGPointMake(ScreenWidth - 15 - doneBtn.frame.size.width/2, 42);
    cancelBtn.center = CGPointMake(15 + cancelBtn.frame.size.width/2, 42);
    
    [doneBtn addTarget:self action:@selector(clickDone:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:doneBtn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
}

- (MBInputView *)inputView {
    if (!_inputView) {
        _inputView = [[MBInputView alloc]initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight-65) withInptuViewStyle:MBInputViewStyleWithPhoto];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.textView.backgroundColor = [UIColor clearColor];
        _inputView.textView.placeholder = @"点击输入文字";
        _inputView.textView.delegate = self;
        _inputView.container.eventDelegate = self;
        _inputView.textView.keyboardType = UIReturnKeySend;
        [_inputView.addBtn addTarget:self
                              action:@selector(addTopic) forControlEvents:UIControlEventTouchUpInside];
    }
    return _inputView;
}

- (void)clickPhotoContainerViewAdd {
    NSLog(@"点击添加图片");
    [self presentViewController:self.pickView animated:YES completion:^{
        
    }];
}

- (void)clickDone:(UIButton *)sender {
    NSLog(@"点击完成 : %@",_inputView.textView.text);
    
    if (![_inputView.textView.text isEqualToString:@""] && _inputView.textView.text.length < 300) {
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
    }else if (_inputView.textView.text.length > 300) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"内容超过300字了啦 太多啦!";
        [_hud hide:YES afterDelay:1.5];
    }else {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"内容不能为空";
        [_hud hide:YES afterDelay:1.5];
    }
    [_inputView.textView resignFirstResponder];
}

- (void)clickCancel:(UIButton *)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
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
        view.backgroundColor = [UIColor whiteColor];
        
        _pickView = [[GMImagePickerController alloc] init];
        _pickView.delegate = self;
        _pickView.title = @"相册";
        
        [_pickView.view addSubview:view];
        
        _pickView.customDoneButtonTitle = @"完成";
        _pickView.customCancelButtonTitle = @"取消";
        
        _pickView.colsInPortrait = 3;
        _pickView.colsInLandscape = 5;
        _pickView.minimumInteritemSpacing = 2.0;
        
        _pickView.modalPresentationStyle = UIModalPresentationPopover;
        _pickView.navigationBarTintColor = [UIColor colorWithRGB:0x212121];
        _pickView.navigationBarBackgroundColor = [UIColor whiteColor];
        _pickView.navigationBarTextColor = [UIColor colorWithRGB:0x212121];
        _pickView.mediaTypes = @[@(PHAssetMediaTypeImage)];
    }
    
    return _pickView;
}

- (void)addTopic{
    if (!self.topicVC) {
        self.topicVC = [[TopicViewController alloc]init];
        self.topicVC.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:self.topicVC animated:YES];
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


- (void)releaseNewArticle {
    NSLog(@"请求发布");
    NSString *title = @"iOS title";
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
//    NSString *user_id = [UserDefaultTool valueWithKey:@"user_id"];
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
    NSString *API;
    NSMutableDictionary *parameter = @{@"stuNum":stuNum,
                                       @"idNum":idNum,
                                       @"title":title,
                                       @"content":content,
                                       @"photo_src":photo_src,
                                       @"thumbnail_src":thumbnail_src,
                                       }.mutableCopy;
    if (self.isTopic) {
        [parameter setObject:@7 forKey:@"type_id"];
        API = ADDTOPICARTICLE_API;
        [parameter setObject:self.topic.topic_id forKey:@"topic_id"];
    }
    else{
        [parameter setObject:@5 forKey:@"type_id"];
        API = YOUWEN_ADD_QUESTION_API;
    }
    _hud.labelText = @"正在发布...";
    __weak typeof(self) weakSelf = self;
    [NetWork NetRequestPOSTWithRequestURL:API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        [weakSelf.hud hide:YES];
        weakSelf.hud = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
        weakSelf.hud.mode = MBProgressHUDModeText;
        weakSelf.hud.labelText = @"发布成功";
        [weakSelf.hud hide:YES afterDelay:1.5];
        [weakSelf performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5f];
        
    } WithFailureBlock:^{
        weakSelf.hud = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
        weakSelf.hud.mode = MBProgressHUDModeText;
        weakSelf.hud.labelText = @"网络错误";
        [weakSelf.hud hide:YES afterDelay:1.5];
    }];
    
}

- (void)delayMethod {
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
    self.updateBlock();
    
}

- (void)uploadImageWithImageModel:(MOHImageParamModel *)imageModel withFlag:(NSInteger)flag {
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = [NSString stringWithFormat:@"正在上传第%ld张图片...",flag+1];
    NSLog(@"请求第%ld",flag+1);
    NSString *stuNum = [UserDefaultTool getStuNum];
    __weak typeof(self) weakSelf = self;
    __block NSInteger flagBlock = flag;
    [NetWork uploadImageWithUrl:YOUWEN_UPLOAD_PIC_API imageParams:@[imageModel] otherParams:@{@"stunum":stuNum} imageQualityRate:1.0 successBlock:^(id returnValue) {
        [weakSelf.hud hide:YES];
        NSRange range = [returnValue[@"data"][@"photosrc"] rangeOfString:@"https://wx.idsbllp.cn/cyxbsMobile/Public/photo/"];
        NSRange range1 = [returnValue[@"data"][@"thumbnail_src"] rangeOfString:@"https://wx.idsbllp.cn/cyxbsMobile/Public/photo/thumbnail/"];
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
#pragma mark - TextView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.inputView.textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    NSError *error;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:textView.text];
    attributedStr.font = textView.font;
    //正则匹配
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#.+?#"                                options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:textView.text options:0 range:NSMakeRange(0, [textView.text length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            [attributedStr setTextHighlightRange:resultRange color:[UIColor colorWithHexString:@"41a3ff"] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                
            }];
            if([[textView.text substringWithRange:resultRange] isEqualToString:self.topic.keyword]){
                self.isTopic = YES;
            }
            else{
                self.isTopic = NO;
            }
            
        }
        else{
            self.isTopic = NO;
        }
        NSLog(@"%@",error);
    }
    //    NSString *lang = [[[UITextInputMode activeInputModes] firstObject] primaryLanguage];//当前的输入模式
    //    if ([lang isEqualToString:@"zh-Hans"])
    //    {
    //        如果输入有中文，且没有出现文字备选框就对文字更新
    //        出现了备选框就暂不更新
    UITextRange *range = [textView markedTextRange];
    
    UITextPosition *position = [textView positionFromPosition:range.start offset:0];
    if (!position)
    {
        NSRange oldRange = textView.selectedRange;
        textView.attributedText = attributedStr;
        textView.selectedRange = oldRange;
        
    }
    //    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""]) {
        NSLog(@"删除");
    }
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"点击发送 : %@",_inputView.textView.text);
    }
    if ([text isEqualToString:@"#"]) {
        [self addTopic];
        return NO;
    }
    
    return YES;
}


@end

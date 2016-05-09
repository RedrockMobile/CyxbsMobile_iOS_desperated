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

@interface MBReleaseViewController ()<MBAddPhotoContainerViewAddEventDelegate,GMImagePickerControllerDelegate>
{
    GMImagePickerController *_pickView;
}
//@property (strong, nonatomic) UIButton *doneBtn;
//@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, readonly) GMImagePickerController *pickView;
@property (strong, nonatomic) UIView *navigationView;
@property (strong, nonatomic) MBInputView *inputView;


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
        _inputView.container.eventDelegate = self;
    }
    return _inputView;
}

- (void)clickPhotoContainerViewAdd {
    NSLog(@"点击添加图片");
    
    NSArray *pic = @[@"图片1.jpg",@"图片2.jpg",@"图片3.jpg",@"图片4.jpg",@"图片5.jpg"];
    NSMutableArray *picMutable = [NSMutableArray array];
//    [self showViewController:self.pickView sender:nil];
    int row = arc4random()%10;
    for (int i = 0; i < row; i ++) {
        int index = arc4random()%3;
        [picMutable addObject:pic[index]];
    }
    
    _inputView.container.sourcePicArray = [picMutable copy];
}

- (void)clickDone:(UIButton *)sender {
    NSLog(@"点击完成");
}

- (void)clickCancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
        GMImagePickerController *picker = [[GMImagePickerController alloc] init];
        picker.delegate = self;
        picker.title = @"相册";
        
        picker.customDoneButtonTitle = @"完成";
        picker.customCancelButtonTitle = @"取消";
        picker.customNavigationBarPrompt = @"请选择图片";
        
        picker.colsInPortrait = 3;
        picker.colsInLandscape = 5;
        picker.minimumInteritemSpacing = 2.0;
        
        //    picker.allowsMultipleSelection = NO;
        //    picker.confirmSingleSelection = YES;
        //    picker.confirmSingleSelectionPrompt = @"Do you want to select the image you have chosen?";
        
        //    picker.showCameraButton = YES;
        //    picker.autoSelectCameraImages = YES;
        
        picker.modalPresentationStyle = UIModalPresentationPopover;
        
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
    int i=0;
    for (PHAsset *ph in assetArray) {
        i++;
        [[PHImageManager defaultManager] requestImageDataForAsset:ph options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            
            UIImage *image = [UIImage imageWithData:imageData];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = (CGRect){i*20,0,300,500};
            [self.view addSubview:imageView];
            
            NSLog(@"%d",i);
        }];
    }
    NSLog(@"3");
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    

}

- (BOOL)assetsPickerController:(GMImagePickerController *)picker shouldSelectAsset:(PHAsset *)asset {
    NSLog(@"已经选了 %ld 张",picker.selectedAssets.count);
    if (picker.selectedAssets.count > 9) {
        NSLog(@"大于9张了");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"只能获取9张图" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    return YES;
}

//Optional implementation:
-(void)assetsPickerControllerDidCancel:(GMImagePickerController *)picker
{
    NSLog(@"GMImagePicker: User pressed cancel button");
}
@end

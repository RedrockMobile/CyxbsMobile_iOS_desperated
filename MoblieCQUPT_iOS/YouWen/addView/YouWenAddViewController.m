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
#define PHOTOSIZE (ScreenWidth - 30) / 3

@interface YouWenAddViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (copy, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) ReportTextView *titleTextView;
@property (strong, nonatomic) ReportTextView *detailTextView;
@property (strong, nonatomic) UIButton *addImageButton;
@end

@implementation YouWenAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setView];
    _imageArray = [NSArray array].mutableCopy;
}
- (void)viewWillAppear:(BOOL)animated{
    [self.view removeAllSubviews];
    [self setWriteView];
    [self setImageView];
}
- (void)setView{
    self.navigationController.navigationItem.title = @"求助";
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)setWriteView{
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 3 * 2 - 64)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    _titleTextView = [[ReportTextView alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 30) andState:OnlyWordNum];
    _titleTextView.limitNum = 20;
    _detailTextView = [[ReportTextView alloc] initWithFrame:CGRectMake(10, 40, ScreenWidth - 20, whiteView.height - _titleTextView.bottom - 10) andState:OnlyWordNum];
    _detailTextView.limitNum = 200;
    UIView *blackLine = [[UIView alloc] initWithFrame:CGRectMake(10, _titleTextView.bottom, ScreenWidth - 20, 1)];
    blackLine.backgroundColor = [UIColor blackColor];

    [whiteView addSubview:_titleTextView];
    [whiteView addSubview:_detailTextView];
    [whiteView addSubview:blackLine];
}

- (void)setImageView{
    UIScrollView *imageView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScreenHeight / 3 * 2 - 64 + 10, ScreenWidth, ScreenHeight / 3 - 64 - 10)];
    imageView.contentSize = CGSizeMake(ScreenWidth, _imageArray.count / 3 * PHOTOSIZE + (ScreenHeight / 3 - 64 - 10));
    imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView];
    CGRect final;
    for (int i = 0; i < _imageArray.count; i ++) {
        UIImageView *imView = [[UIImageView alloc]init];
        imView.layer.cornerRadius = 2.0;
        imView.layer.masksToBounds = YES;
        if (!i % 3) {
            imView.frame =  CGRectMake(10, i / 3 * (PHOTOSIZE + 5) + 10, PHOTOSIZE, PHOTOSIZE);
        }
        else {
            imView.frame =  CGRectMake(10 + i % 3 * (PHOTOSIZE + 5), 10 + i / 3 * (PHOTOSIZE + 5), PHOTOSIZE, PHOTOSIZE);
        }
        imView.image = _imageArray[i];
        [imageView addSubview:imView];
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
    [imageView addSubview: self.addImageButton];
}

- (UIButton *)addImageButton{
    if (!_addImageButton){
        _addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageButton setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        [_addImageButton addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageButton;
}

- (void)selectImage{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.imageArray appendObject: image];
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

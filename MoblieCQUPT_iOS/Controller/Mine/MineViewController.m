//
//  MineViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/8/30.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#define kHeadImage @"defaultImageNSUrl"
#define kPersonalImage [kHeadImage stringByAppendingString: [LoginEntry getByUserdefaultWithKey:@"stuNum"]]

#import "MineViewController.h"
#import "XBSConsultButtonClicker.h"
#import "SuggestionViewController.h"
#import "XBSAboutViewController.h"
#import "ShakeViewController.h"
#import "QGERestTimeCourseViewController.h"
#import "LoginEntry.h"
#import "LoginViewController.h"
#import "ExamGradeViewController.h"
#import "EmptyClassViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "LoginEntry.h"


@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIButton *myPhoto;
@property (strong, nonatomic) UILabel *loginLabel;
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGFloat currentHeight;
@property (strong, nonatomic) XBSConsultButtonClicker *clicker;
@property (strong, nonatomic) NSMutableArray *cellDictionary;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H-20)];
    _mainScrollView.contentSize = CGSizeMake(MAIN_SCREEN_W, 600);
    _mainScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _mainScrollView.showsVerticalScrollIndicator=NO;
    _mainScrollView.bounces = YES;
    [self.view addSubview:_mainScrollView];
    
    _currentHeight = 65;
    _cellDictionary = [NSMutableArray array];
//    SEL s[4] = {@selector(clickForExamSchedule),@selector(clickForReexamSchedule), @selector(clickForExamGrade),@selector(clickForEmptyClassroom)};
    _cellDictionary = [@[@{},
                         @{@"cell":@"考试安排",@"img":@"考试安排.png",@"action":@"clickForExamSchedule"},
                         @{@"cell":@"补考安排",@"img":@"补考安排.png",@"action":@"clickForExamSchedule"},
                         @{@"cell":@"期末成绩",@"img":@"期末成绩.png",@"controller":@"ExamGradeViewController"},
                         @{@"cell":@"空教室",@"img":@"空教室.png",@"controller":@"EmptyClassViewController"},
                         @{@"cell":@"没课约",@"img":@"校历.png",@"controller":@"QGERestTimeCourseViewController"},
                         @{@"cell":@"校历",@"img":@"校历.png",@"controller":@"CalendarViewController"},
                         @{@"cell":@"反馈信息",@"img":@"反馈信息.png",@"controller":@"SuggestionViewController"},
                         @{@"cell":@"关于",@"img":@"关于.png",@"controller":@"XBSAboutViewController"},
                         @{@"cell":@"退出登录",@"img":@"tuichu_red_blod.png"},
                        ]
                       mutableCopy];
    
    /**button **/
//    self.clicker = [[XBSConsultButtonClicker alloc]init];
    self.clicker.delegate = (MainViewController *)self;

#pragma mark 各种button的查询

    [_mainScrollView addSubview:self.tableView];
    _currentHeight += _tableView.frame.size.height;
}

- (XBSConsultButtonClicker *)clicker{
    if (!_clicker) {
        _clicker = [[XBSConsultButtonClicker alloc]init];
    }
    return _clicker;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _currentHeight, MAIN_SCREEN_W, _mainScrollView.contentSize.height+100) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setAutoresizesSubviews:NO];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    
    return _tableView;
}

- (UIButton *)myPhoto{
    if (!_myPhoto) {
        
        [self getMyPhotoWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W*0.1, MAIN_SCREEN_W*0.1)];
        _myPhoto.center = CGPointMake(MAIN_SCREEN_W/2, MAIN_SCREEN_H*0.1);
        
    }
    return _myPhoto;
}

- (UIButton *)getMyPhotoWithFrame:(CGRect)rect{
    _myPhoto = [[UIButton alloc] initWithFrame:rect];
    ;
    NSString *url = [LoginEntry getByUserdefaultWithKey:kPersonalImage];
    if (url) {
        ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
        [lib assetForURL:[NSURL URLWithString:url] resultBlock:^(ALAsset *asset) {
            UIImage *saveImage = [self fullResolutionImageFromALAsset:asset];
            [_myPhoto setImage:saveImage forState:UIControlStateNormal];
        } failureBlock:nil];
    }else{
        
        UIImage *saveImage = [UIImage imageNamed:@"mobile.png"];
        [_myPhoto setImage:saveImage forState:UIControlStateNormal];
        _myPhoto.layer.borderColor = RGBColor(231, 231, 231, 1).CGColor;
        _myPhoto.layer.borderWidth = 1;
    }
    
    _myPhoto.layer.masksToBounds = YES;
    _myPhoto.layer.cornerRadius = MAIN_SCREEN_W*0.2;
    [_myPhoto addTarget:self
                 action:@selector(selectPhoto)
       forControlEvents:UIControlEventTouchUpInside];
    
    _myPhoto.layer.cornerRadius = _myPhoto.frame.size.width/2;
    return _myPhoto;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_cellDictionary count];
}

#pragma mark - TableView 代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"butttonCell"];
    if (!cell) {
        
        if(indexPath.section == 0){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"imageHead"];
//            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//            CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
//            CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            UIButton *headImage = [self getMyPhotoWithFrame:CGRectMake(20, CGRectGetHeight(cell.frame)/2, 50, 50)];
            headImage.center = CGPointMake(headImage.center.x, 40);
            
//            headImage.center = CGPointMake(headImage.center.x, cell.contentView.frame.size.height);
            [cell.contentView addSubview:headImage];
            
            UILabel *label = [[UILabel alloc] init];
            label.text = [LoginEntry getByUserdefaultWithKey:@"name"];
            label.frame = CGRectMake(headImage.frame.size.width+30, 0, 0, 0);
            label.font = [UIFont fontWithName:@"Arial" size:16];
            label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [label sizeToFit];
            label.center = CGPointMake(label.center.x, headImage.center.y);
            
            
            [cell.contentView addSubview:label];
            return  cell;
        }
        
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"butttonCell"];
        
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        UIImage *img = [[UIImage imageNamed:_cellDictionary[indexPath.section][@"img"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
        
        /** 登出图标 **/
//        if (indexPath.section == [_cellDictionary count]-1 ) {
//            imgView.tintColor = [UIColor redColor];
//        }
        
//        imgView.frame = CGRectMake(8, CGRectGetHeight(cell.frame)/2, MAIN_SCREEN_W*0.05, MAIN_SCREEN_W*0.05);
        imgView.tintColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.7];
        imgView.frame = CGRectMake(20, CGRectGetHeight(cell.frame)/2, 18, 18);
        imgView.center = CGPointMake(imgView.center.x, cell.contentView.center.y);
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [cell addSubview:imgView];
        
        
        UILabel *label = [[UILabel alloc] init];
        label.text = _cellDictionary[indexPath.section][@"cell"];
        label.frame = CGRectMake(20+imgView.frame.origin.x+imgView.frame.size.width, 0, 0, 0);
        label.font = [UIFont fontWithName:@"Arial" size:14];
        label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [label sizeToFit];
        label.center = CGPointMake(label.center.x, cell.center.y);
        [cell addSubview:label];
        

        NSSet *set = [NSSet setWithObjects:@2,@3,@4,@5,@7,@8, nil];
        NSSet *nowSet = [NSSet setWithObject:[NSNumber numberWithInteger:indexPath.section]];
        if ([nowSet isSubsetOfSet:set]) {
            UIView *underLine = [[UIView alloc]initWithFrame:CGRectMake(label.frame.origin.x, 0, MAIN_SCREEN_W, 0.5)];
            underLine.backgroundColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:0.5];
            [cell addSubview:underLine];
            
        }
        
    }
    
    return cell;
}

#pragma mark 分割tableview设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSSet *set = [NSSet setWithObjects:@1,@6,@9, nil];
    NSSet *nowSet = [NSSet setWithObject:[NSNumber numberWithInteger:section]];
    if ([nowSet isSubsetOfSet:set]) {
        return 15;
    }else{
        return 0.00001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 80;
    }
    return 42;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ((className = _cellDictionary[indexPath.section][@"controller"])) {
        
        UIViewController *viewController =  (UIViewController *)[[NSClassFromString(className) alloc] init];
        viewController.navigationItem.title = _cellDictionary[indexPath.section][@"cell"];
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (indexPath.section == [_cellDictionary count]-1){
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"登出帐号"
                            message:@"所有的个人信息将清除,你确定要登出此帐号吗?"
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }
    
    if(_cellDictionary[indexPath.section][@"action"]){
        NSString *selectString = _cellDictionary[indexPath.section][@"action"];
        [self.clicker performSelector:NSSelectorFromString(selectString)];
//        NSLog(@"s");
        //        [labelButton addTarget:self.clicker action:s[i] forControlEvents:UIControlEventTouchUpInside];
    }
    
}

#pragma 登出 alertviincludevi 代理
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController presentViewController:login animated:YES completion:^{
            [LoginEntry loginoutWithParamArrayString:@[@"dataArray",@"weekDataArray",@"nowWeek"]];
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    UIImage *image = info[UIImagePickerControllerOriginalImage];
    /** 保存图片 **/
    NSError *error;
    
    NSURL *url = info[UIImagePickerControllerReferenceURL];
     ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
    [lib assetForURL:url resultBlock:^(ALAsset *asset) {
        UIImage *saveImage = [self fullResolutionImageFromALAsset:asset];
        NSDictionary *dicParam = @{kPersonalImage:[url absoluteString]};
        [LoginEntry saveByUserdefaultWithDictionary:dicParam];
        
        [self image:saveImage didFinishSavingWithError:error contextInfo:nil];
    } failureBlock:nil];
    
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    [_myPhoto setImage:image forState:UIControlStateNormal];
    _myPhoto.layer.borderWidth = 0;
    
}

/**
 *  @author Orange-W, 15-09-13 03:09:05
 *
 *  @brief  头像功能
 */

- (void)selectPhoto{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //在照片库里选择照片作为头像
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker
                       animated:YES
                     completion:nil];
}

- (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset
{
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef
                                       scale:assetRep.scale
                                 orientation:(UIImageOrientation)assetRep.orientation];
    return img;
}



@end

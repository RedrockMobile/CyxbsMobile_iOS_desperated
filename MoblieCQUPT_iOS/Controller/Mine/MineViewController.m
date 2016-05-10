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
#import "XBSAboutViewController.h"
#import "ShakeViewController.h"
#import "QGERestTimeCourseViewController.h"
#import "ExamGradeViewController.h"
#import "EmptyClassViewController.h"
#import "LoginEntry.h"
#import "AboutMeViewController.h"
#import "SettingViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+AFNetworking.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UILabel *labelOfIntrodution;
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGFloat currentHeight;
@property (strong, nonatomic) NSMutableArray *cellDictionary;
@property (strong, nonatomic) NSMutableDictionary *data;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H-20)];
    _mainScrollView.contentSize = CGSizeMake(MAIN_SCREEN_W, 600);
    _mainScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _mainScrollView.showsVerticalScrollIndicator=NO;
    _mainScrollView.bounces = YES;
    [self.view addSubview:_mainScrollView];
    
    _currentHeight = 65;
    _cellDictionary = [NSMutableArray array];
//    SEL s[4] = {@selector(clickForExamSchedule),@selector(clickForReexamSchedule), @selector(clickForExamGrade),@selector(clickForEmptyClassroom)};
    _cellDictionary = [@[@{@"cell":@"修改信息",@"controller":@"MyInfoViewController"},
                         @{@"cell":@"与我相关",@"img":@"与我相关.png",@"controller":@"AboutMeViewController"},
                         @{@"cell":@"我的动态",@"img":@"我的动态.png",@"controller":@"MyMessagesViewController"},
                         @{@"cell":@"没课约",@"img":@"校历.png",@"controller":@"QGERestTimeCourseViewController"},
                         @{@"cell":@"空教室",@"img":@"空教室.png",@"controller":@"EmptyClassViewController"},
                         @{@"cell":@"期末成绩",@"img":@"期末成绩.png",@"controller":@"ExamGradeViewController"},
                         @{@"cell":@"校历",@"img":@"校历.png",@"controller":@"CalendarViewController"},
                         @{@"cell":@"设置",@"img":@"关于.png",@"controller":@"SettingViewController"},
                        ]
                       mutableCopy];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

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
            _labelOfIntrodution.text = _data[@"introduction"];
            if ([_data[@"photo_thumbnail_src"] isEqualToString:@""]) {
                [_avatar setImage:[UIImage imageNamed:@"headImage.png"]];
            } else {
                [_avatar sd_setImageWithURL:[NSURL URLWithString:_data[@"photo_thumbnail_src"]]];
            }
        }
        
    } WithFailureBlock:^{
        
    }];
    
    [_mainScrollView addSubview:self.tableView];
    _currentHeight += _tableView.frame.size.height;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _currentHeight, MAIN_SCREEN_W,_mainScrollView.contentSize.height+100) style:UITableViewStyleGrouped];
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
            _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 50, 50)];
            _avatar.layer.masksToBounds = YES;
            [_avatar setImage:[UIImage imageNamed:@"headImage.png"]];
            _avatar.layer.cornerRadius = _avatar.frame.size.width/2;
            
            [cell.contentView addSubview:_avatar];
            
            //设置用户名
            UILabel *labelOfUserName = [[UILabel alloc] init];
            labelOfUserName.text = [LoginEntry getByUserdefaultWithKey:@"name"];
            labelOfUserName.frame = CGRectMake(50+32, 18, 0, 0);
            labelOfUserName.font = [UIFont fontWithName:@"Arial" size:16];
            labelOfUserName.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [labelOfUserName sizeToFit];
            [cell.contentView addSubview:labelOfUserName];
            
            //设置个人简介
            _labelOfIntrodution = [[UILabel alloc] initWithFrame:CGRectMake(50+32, 45, MAIN_SCREEN_W-82-40, 0)];
            _labelOfIntrodution.text = @"简介：请点击我完善个人信息，愉快玩耍";
            _labelOfIntrodution.font = [UIFont fontWithName:@"Arial" size:12];
            _labelOfIntrodution.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:0.7];
            [_labelOfIntrodution sizeToFit];
            [cell.contentView addSubview:_labelOfIntrodution];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return  cell;
        }
        
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"butttonCell"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
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
        

        NSSet *set = [NSSet setWithObjects:@2,@3,@4,@5,@6,@8,@9, nil];
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
    NSSet *set = [NSSet setWithObjects:@1,@7, nil];
    NSSet *nowSet = [NSSet setWithObject:[NSNumber numberWithInteger:section]];
    if ([nowSet isSubsetOfSet:set]) {
        return 15;
    }else{
        return 0.00001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 78;
    }
    return 43.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ((className = _cellDictionary[indexPath.section][@"controller"])) {
        
        UIViewController *viewController =  (UIViewController *)[[NSClassFromString(className) alloc] init];
        viewController.navigationItem.title = _cellDictionary[indexPath.section][@"cell"];
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}



//#pragma mark - UIImagePickerController Delegate
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
////    UIImage *image = info[UIImagePickerControllerOriginalImage];
//    /** 保存图片 **/
//    NSError *error;
//    
//    NSURL *url = info[UIImagePickerControllerReferenceURL];
//     ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
//    [lib assetForURL:url resultBlock:^(ALAsset *asset) {
//        UIImage *saveImage = [self fullResolutionImageFromALAsset:asset];
//        NSDictionary *dicParam = @{kPersonalImage:[url absoluteString]};
//        [LoginEntry saveByUserdefaultWithDictionary:dicParam];
//        
//        [self image:saveImage didFinishSavingWithError:error contextInfo:nil];
//    } failureBlock:nil];
//    
////    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    [self dismissViewControllerAnimated:YES
//                             completion:nil];
//}
//
///**
// *  @author Orange-W, 15-09-13 03:09:05
// *
// *  @brief  头像功能
// */
//
//- (void)selectPhoto{
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//    
//    //在照片库里选择照片作为头像
//    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    imagePicker.delegate = self;
//    imagePicker.allowsEditing = YES;
//    
//    [self presentViewController:imagePicker
//                       animated:YES
//                     completion:nil];
//}
//
//- (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset
//{
//    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
//    CGImageRef imgRef = [assetRep fullResolutionImage];
//    UIImage *img = [UIImage imageWithCGImage:imgRef
//                                       scale:assetRep.scale
//                                 orientation:(UIImageOrientation)assetRep.orientation];
//    return img;
//}
@end


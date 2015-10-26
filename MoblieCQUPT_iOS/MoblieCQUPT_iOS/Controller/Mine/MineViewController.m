//
//  MineViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/8/30.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "MineViewController.h"
#import "XBSConsultButtonClicker.h"
#import "SuggestionViewController.h"
#import "XBSAboutViewController.h"
#import "ShakeViewController.h"
#import "LoginEntry.h"
#import "LoginViewController.h"
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
//    self.view.backgroundColor = [UIColor whiteColor];
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H-20)];
    _mainScrollView.contentSize = CGSizeMake(MAIN_SCREEN_W, 600);
    _mainScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _mainScrollView.showsVerticalScrollIndicator=NO;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.bounces = NO;
    [self.view addSubview:_mainScrollView];
    
    _currentHeight = 65;
    _cellDictionary = [NSMutableArray array];
//    SEL s[4] = {@selector(clickForExamSchedule),@selector(clickForReexamSchedule), @selector(clickForExamGrade),@selector(clickForEmptyClassroom)};
    _cellDictionary = [@[@{},
                         @{@"cell":@"考试安排",@"img":@"考试安排.png",@"action":@"clickForExamSchedule"},
                         @{@"cell":@"补考安排",@"img":@"补考安排.png",@"action":@"clickForExamSchedule"},
                         @{@"cell":@"期末成绩",@"img":@"期末成绩.png",@"action":@"clickForExamGrade"},
                         @{@"cell":@"空教室",@"img":@"空教室.png",@"action":@"clickForEmptyClassroom"},
//                        @{@"cell":@"去哪吃",@"img":@"zuobiao.png",@"controller":@"ShakeViewController"},
                         @{@"cell":@"校历",@"img":@"校历.png",@"controller":@"CalendarViewController"},
                         @{@"cell":@"反馈信息",@"img":@"反馈信息.png",@"controller":@"SuggestionViewController"},
                         @{@"cell":@"关于",@"img":@"关于.png",@"controller":@"XBSAboutViewController"},
                         @{@"cell":@"退出登录",@"img":@"tuichu_red_blod.png"},
                        ]
                       mutableCopy];
//    UIView *topView = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H*0.2)];
//
//    
//    topView.backgroundColor = MAIN_COLOR;
//
//    _currentHeight += topView.frame.size.height;
//    [_mainScrollView addSubview:topView];

//    [_mainScrollView addSubview:self.myPhoto];
//    [_mainScrollView addSubview:self.loginLabel];
    
    /**button **/
//    self.clicker = [[XBSConsultButtonClicker alloc]init];
    self.clicker.delegate = (MainViewController *)self;

#pragma mark 各种button的查询
//    NSArray *tempStrArr = @[@"20-3b.png",@"20-3补考.png",@"20-3exam.png",@"20-3c.png"];
//    NSArray *text = @[@"考试安排",@"补考安排",@"期末成绩",@"找自习室"];
//     NSArray *tempStrArr = @[@"kaoshichaxun.png",@"bukaochaxun.png",@"chenjichaxun",@"kongjiaoshichaxun.png"];
//    SEL s[4] = {@selector(clickForExamSchedule),@selector(clickForReexamSchedule),
//        @selector(clickForExamGrade),@selector(clickForEmptyClassroom)};
    

//    for (int i=0; i<4; i++) {
//        UIButton *labelButton = [[UIButton alloc] initWithFrame:CGRectMake( MAIN_SCREEN_W/4*i, _currentHeight, MAIN_SCREEN_W/4, MAIN_SCREEN_H*0.1)];
//        labelButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//        labelButton.layer.borderWidth = 1;
//        UIImage *stretchableButtonImage = [UIImage imageNamed:tempStrArr[i]];
////        [labelButton setImage:stretchableButtonImage forState:UIControlStateNormal];
//        UIImageView *buttonView = [[UIImageView alloc] initWithImage:stretchableButtonImage];
//        CGRect contentFrame = CGRectMake(0, 0, MAIN_SCREEN_W*0.08, MAIN_SCREEN_W*0.08);
//        buttonView.frame = contentFrame;
//        buttonView.center = CGPointMake(labelButton.frame.size.width/2, labelButton.frame.size.height/2 +8 -  buttonView.frame.size.height/2);
//        [labelButton addSubview:buttonView];
//        
//        CGRect textFrame = CGRectMake(0, 0, MAIN_SCREEN_W*0.04, MAIN_SCREEN_W*0.04);
//        UILabel *textLabel = [[UILabel alloc]initWithFrame:textFrame];
//        textLabel.text = text[i];
//        [textLabel setFont:[UIFont fontWithName:@"GeezaPro" size:12]];
//        [textLabel sizeToFit];
//        textLabel.center = CGPointMake(labelButton.frame.size.width/2, labelButton.frame.size.height/2+12+textLabel.frame.size.height/2);
//        [labelButton addSubview:buttonView];
//       
//        [labelButton addSubview:textLabel];
//        
//        [labelButton addTarget:self.clicker action:s[i] forControlEvents:UIControlEventTouchUpInside];
//        
//        labelButton.backgroundColor = [UIColor whiteColor];
//        
//        [_mainScrollView addSubview:labelButton];
//    }
//    
//    _currentHeight += MAIN_SCREEN_H*0.1;

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
    NSString *url = [LoginEntry getByUserdefaultWithKey:@"defaultImageNSUrl"];
    if (url) {
        ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
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
            CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
            CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            UIButton *headImage = [self getMyPhotoWithFrame:CGRectMake(20, CGRectGetHeight(cell.frame)/2, 50, 50)];
            headImage.center = CGPointMake(headImage.center.x
                                           , rectInTableView.origin.y+size.height);
            
            
            [cell addSubview:headImage];
            
            UILabel *label = [[UILabel alloc] init];
            label.text = @"王诚志";
            label.frame = CGRectMake(headImage.frame.size.width+30, 0, 0, 0);
            label.font = [UIFont fontWithName:@"Arial" size:16];
            label.tintColor = [UIColor lightTextColor];
            [label sizeToFit];
            label.center = CGPointMake(label.center.x, headImage.center.y);
            
            
            [cell addSubview:label];
            return  cell;
        }
        
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"butttonCell"];
        
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        UIImage *img = [[UIImage imageNamed:_cellDictionary[indexPath.section][@"img"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
        
        /** 登出图标 **/
        if (indexPath.section == [_cellDictionary count]-1 ) {
            imgView.tintColor = [UIColor blackColor];
        }
        
        imgView.frame = CGRectMake(8, CGRectGetHeight(cell.frame)/2, MAIN_SCREEN_W*0.05, MAIN_SCREEN_W*0.05);
        imgView.center = CGPointMake(imgView.center.x, cell.contentView.center.y);
        [cell addSubview:imgView];
        
        
        UILabel *label = [[UILabel alloc] init];
        label.text = _cellDictionary[indexPath.section][@"cell"];
        label.frame = CGRectMake(16+CGRectGetWidth(imgView.frame), 0, 0, 0);
        label.font = [UIFont fontWithName:@"Arial" size:15];
        [label sizeToFit];
        label.center = CGPointMake(label.center.x, cell.center.y);
        [cell addSubview:label];

        
    }
    
    return cell;
}

#pragma mark 分割tableview设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSSet *set = [NSSet setWithObjects:@1,@5, nil];
    NSSet *nowSet = [NSSet setWithObject:[NSNumber numberWithInteger:section]];
    if ([nowSet isSubsetOfSet:set]) {
        return 15;
    }else{
        return 0.00001;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 100;
    }
    return -1;
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
        
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController presentViewController:login animated:YES completion:^{
            [LoginEntry loginoutWithParamArrayString:@[@"dataArray",@"weekDataArray",@"nowWeek",@"defaultImageNSUrl"]];
        }];
    }
    
    if(_cellDictionary[indexPath.section][@"action"]){
        NSString *selectString = _cellDictionary[indexPath.section][@"action"];
        [self.clicker performSelector:NSSelectorFromString(selectString)];
//        NSLog(@"s");
        //        [labelButton addTarget:self.clicker action:s[i] forControlEvents:UIControlEventTouchUpInside];
    }
    
//
    
}

- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
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
        NSDictionary *dicParam = @{@"defaultImageNSUrl":[url absoluteString]};
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

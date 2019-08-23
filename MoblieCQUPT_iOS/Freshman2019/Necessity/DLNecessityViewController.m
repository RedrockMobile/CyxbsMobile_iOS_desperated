//
//  DLNecessityViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

/*
 
 这个页面主要由一个tableView，一个悬浮的添加Button构成
 点击navigationBar的问号按钮，跳出一个UIView介绍本页面并且同时跳出一个背景UIView设置透明度，使弹窗跳出后，背景变暗
 点击编辑按钮，编辑按钮变为删除，页面变为删除页面，将原cell里的完成选中按钮移除，添加删除选中按钮
 只能删除非必需的项目使用在model里设一个bool值来表示是否要删除
 本页面的数据本地化使用plist文件,不更新会保存用户的删除添加和已完成的数据，升级会丢失数据
 
 */

#import "DLNecessityViewController.h"
#import "FMNecessityTableViewCell.h"
#import "addView.h"
#import "DLNecessityModel.h"
#import "IntroductionView.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import <MBProgressHUD.h>
#import "BaseNavigationController.h"
#import "SYCAddReminderViewController.h"
#import "SYCEditReminderViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width/375
#define HEIGHT [UIScreen mainScreen].bounds.size.height/667


@interface DLNecessityViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate, SYCAddReminderViewControllerDelegate, SYCEditReminderViewControllerDelagate>


@property (nonatomic, strong)UIButton *addBtn;  //下方圆形添加按钮
@property (nonatomic, strong)UIButton *editBtn;   //编辑按钮
@property (nonatomic, strong)UIView *bkgView;     //背景阴影
@property (nonatomic, strong)UITableView *FMtableView;
@property (nonatomic)NSMutableArray<NSMutableArray<DLNecessityModel *> *> *dataArray;
@property (nonatomic)NSMutableArray<NSString *> *titleArray;
@property (nonatomic, strong)NSMutableArray *deleteArray;  //需要删除的cell的array
@property (nonatomic, strong)NSBundle *fileBundel;
@property (nonatomic, strong)NSString *filePath;
@property (nonatomic, strong)addView *AddView;   //下方添加栏
@property (nonatomic, strong)IntroductionView *introduction; //介绍弹窗
@property (nonatomic, strong)DLNecessityModel *model;
@property (assign, nonatomic)NSInteger isShowIntroduce;   //如名字
@property (assign, nonatomic)BOOL isEdit;  //是否编辑的flag
@property (assign, nonatomic)BOOL isSelected;
@property (assign, nonatomic)BOOL isFloat;//是否播放cell浮动的动效
@property (assign, nonatomic)BOOL isShowAddBtn;

@end

@implementation DLNecessityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.title = @"入学必备";
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(didClickEditBtn:)];
    self.navigationItem.rightBarButtonItem = right;
  
    self.isShowAddBtn = YES;
    self.view.backgroundColor = RGBColor(239, 247, 255, 1);
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataPath = [docPath stringByAppendingPathComponent:@"dataArray.archiver"];
    
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:dataPath]){
        [self initModel];
    }else{
        [self getData];
    }
    
    self.deleteArray = [@[] mutableCopy];
    self.isShowIntroduce = 1;
    self.isEdit = NO;
    
    
    self.bkgView = [[UIView alloc]initWithFrame:self.view.frame];
    self.bkgView.backgroundColor = RGBColor(239, 247, 255, 1);
    
    [self.view addSubview:self.FMtableView];

    self.addBtn = [[UIButton alloc] initWithFrame:CGRectMake(286*WIDTH, 569*HEIGHT, 61*WIDTH, 61*HEIGHT)];
    self.addBtn.backgroundColor = [UIColor clearColor];
    [self.addBtn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(clickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addBtn];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma - 数据
- (void)getData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSString *urlStr = @"https://cyxbsmobile.redrock.team/zscy/zsqy/json/1";
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"加载数据中...";
    
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        self.dataArray = [@[] mutableCopy];
        self.titleArray = [@[] mutableCopy];
        for (NSDictionary *dic in [responseObject objectForKey:@"text"]) {
            [self.titleArray addObject:[dic objectForKey:@"title"]];
            NSMutableArray *models = [@[] mutableCopy];
            for (NSDictionary *data in [dic objectForKey:@"data"]) {
                [models addObject:[DLNecessityModel DLNecessityModelWithDict:data]];
            }
            [self.dataArray addObject:[models mutableCopy]];
        }
        
            //回到主线程刷新tableview
        dispatch_sync(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.FMtableView reloadData];
        });
        [self storageData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"你的网络坏掉了m(._.)m" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:nil, nil];
        [alert show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"failure --- %@",error);
    }];
    
    
}

- (void)initModel{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataPath = [docPath stringByAppendingPathComponent:@"dataArray.archiver"];
    NSString *titlePath = [docPath stringByAppendingPathComponent:@"titleArray.archiver"];
    self.dataArray = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    self.titleArray = [NSKeyedUnarchiver unarchiveObjectWithFile:titlePath];
}


- (void)storageData{
    dispatch_queue_t queue = dispatch_queue_create("storageQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dataPath = [docPath stringByAppendingPathComponent:@"dataArray.archiver"];
        NSString *titlePath = [docPath stringByAppendingPathComponent:@"titleArray.archiver"];
        [NSKeyedArchiver archiveRootObject:self.dataArray toFile:dataPath];
        [NSKeyedArchiver archiveRootObject:self.titleArray toFile:titlePath];
    });
}


- (UITableView *)FMtableView{
    if(!_FMtableView){
        self.FMtableView = [[UITableView alloc]initWithFrame: CGRectMake(0, TOTAL_TOP_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65) style:UITableViewStyleGrouped];
        self.FMtableView.delegate = self;
        self.FMtableView.dataSource = self;
        self.FMtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.FMtableView.backgroundColor = [UIColor clearColor];
    }
    return _FMtableView;
}


#pragma - tableview的代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FMNecessityTableViewCell *cell = [FMNecessityTableViewCell cellWithTableView:tableView andIndexpath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.DLNModel = self.dataArray[indexPath.section][indexPath.row];
    
    
    cell.showTextBlock = ^(FMNecessityTableViewCell *Cell) {
        NSIndexPath *index = [tableView indexPathForCell:Cell];
        [tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    cell.btn1.tag = indexPath.row;
    
    [cell.btn1 addTarget:self action:@selector(didClickCellBtn1:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:cell.btn1];
    [cell.btn3 removeFromSuperview];
    
    if(cell.DLNModel.isReady){
        cell.label.textColor = [UIColor lightGrayColor];
        [cell.btn1 setImage:[UIImage imageNamed:@"蓝框选中"] forState:UIControlStateNormal];
    }
    else{
        cell.label.textColor = [UIColor blackColor];
        [cell.btn1 setImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateNormal];
    }
    
    if ([cell.DLNModel.detail isEqual:@""]) {
        cell.btn2.hidden = YES;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLNecessityModel *model = self.dataArray[indexPath.section][indexPath.row];
    if (model.isShowMore) {
        return [FMNecessityTableViewCell cellMoreHeight:model];
    }else{
        return [FMNecessityTableViewCell cellDefautHeight:model];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.titleArray[section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    view.backgroundColor = RGBColor(239, 247, 255, 1);
    
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(15 * WIDTH);
        make.centerY.equalTo(view);
    }];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = RGBColor(119, 119, 119, 0.7);
    label.text = self.titleArray[section];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

//cell上浮的动效
- (void)starAnimationWithTableView:(UITableView *)tableView{
    if(_isFloat){
        NSArray *cells = tableView.visibleCells;
        for (int i = 0; i < cells.count; i++) {
            UITableViewCell *cell = [cells objectAtIndex:i];
            cell.layer.opacity = 0.7;
            cell.layer.transform = CATransform3DMakeTranslation(0, [[UIScreen mainScreen] bounds].size.height, 20);
            NSTimeInterval totalTime = 0.5;
            
            [UIView animateWithDuration:0.4 delay:i*(totalTime/cells.count) usingSpringWithDamping:0.65 initialSpringVelocity:1/0.65 options:UIViewAnimationOptionCurveEaseIn animations:^{
                cell.layer.opacity = 1.0;
                cell.layer.transform = CATransform3DMakeTranslation(0, 0, 20);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

#pragma - 点击button事件
//点击cell表示已完成的button
- (void)didClickCellBtn1:(UIButton *)button event:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:_FMtableView];
    NSIndexPath *index = [_FMtableView indexPathForRowAtPoint:point];
    DLNecessityModel *model = self.dataArray[index.section][index.row];
    if(!model.isReady){
        model.isReady = YES;
        self.isFloat = YES;
    }
    else{
        model.isReady = NO;
        self.isFloat = NO;
    }
    
    [self storageData];
    [self.FMtableView reloadData];
}

//点击悬浮添加按钮
- (void)clickAddBtn:(UIButton *)button{
    SYCAddReminderViewController *vc = [[SYCAddReminderViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:[[BaseNavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

//点击NavigationBar的编辑按钮
- (void)didClickEditBtn:(UIBarButtonItem *)barBtn{
    SYCEditReminderViewController *vc = [[SYCEditReminderViewController alloc] init];
    vc.reminders = self.dataArray[0];
    vc.delagete = self;
    [self presentViewController:[[BaseNavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

- (void)reloadWithData:(NSMutableArray *)dataArray title:(NSMutableArray *)titleArray{
    self.dataArray = dataArray;
    self.titleArray = titleArray;
    if (_dataArray[0].count == 0) {
        [_dataArray removeObjectAtIndex:0];
        [_titleArray removeObjectAtIndex:0];
    }
    [self.FMtableView reloadData];
    [self storageData];
}

- (void)reloadDataWithReminder:(NSMutableArray *)reminders{
    self.dataArray[0] = reminders;
    if (_dataArray[0].count == 0) {
        [_dataArray removeObjectAtIndex:0];
        [_titleArray removeObjectAtIndex:0];
    }
    [self.FMtableView reloadData];
    [self storageData];
}


@end

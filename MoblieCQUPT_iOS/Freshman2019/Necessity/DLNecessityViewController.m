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
#define WIDTH [UIScreen mainScreen].bounds.size.width/375
#define HEIGHT [UIScreen mainScreen].bounds.size.height/667


@interface DLNecessityViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate>


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
    
  
    self.isShowAddBtn = YES;
    self.view.backgroundColor = RGBColor(239, 247, 255, 1);
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataPath = [docPath stringByAppendingPathComponent:@"dataArray.archiver"];
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:dataPath]){
        [self initModel];
    }
    else{
        [self getData];
    }
    
    [self buildMyNavigationbar];
    self.deleteArray = [@[] mutableCopy];
    self.isShowIntroduce = 1;
    self.isEdit = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
    
    
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






- (void)buildMyNavigationbar{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(didClickEditBtn:)];
    self.navigationItem.rightBarButtonItem = right;
    
    self.title = @"入学必备";
}

#pragma - 数据
- (void)getData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSString *urlStr = @"https://cyxbsmobile.redrock.team/zscy/zsqy/json/1";
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
            [self.FMtableView reloadData];
        });
        [self storageData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"你的网络坏掉了m(._.)m" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:nil, nil];
        [alert show];
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
    if(self.isEdit){
        [cell.btn1 removeFromSuperview];
        [cell.contentView addSubview:cell.btn3];
        [cell.btn3 addTarget:self action:@selector(didClickSelectBtn: event:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        [cell.btn1 addTarget:self action:@selector(didClickCellBtn1:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:cell.btn1];
        [cell.btn3 removeFromSuperview];
    }
    if(cell.DLNModel.isReady){
        cell.label.textColor = [UIColor lightGrayColor];
        [cell.btn1 setImage:[UIImage imageNamed:@"蓝框选中"] forState:UIControlStateNormal];
    }
    else{
        cell.label.textColor = [UIColor blackColor];
        [cell.btn1 setImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateNormal];
    }
    
    if(!cell.DLNModel.isSelected){
            [cell.btn3 setImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateNormal];
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


//点击navigationBar的编辑按钮
- (void)didClickEditBtn:(UIBarButtonItem *)barBtn{
    if(!self.isEdit){
        [barBtn setTitle:@"删除"];
        [_FMtableView reloadData];
        [self storageData];
        self.isEdit = YES;
    }
    else{
        [barBtn setTitle:@"编辑"];
        for (int i = 0; i < self.dataArray.count; ++i) {
            [self.dataArray[i] removeObjectsInArray:self.deleteArray];
        }
        [self storageData];
        [self.FMtableView reloadData];
        self.isEdit = NO;
    }
}


//删除页面点击圆框按钮
- (void)didClickSelectBtn:(UIButton *)btn event:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:_FMtableView];
    NSIndexPath *index = [_FMtableView indexPathForRowAtPoint:point];
    DLNecessityModel *model = self.dataArray[index.section][index.row];
    if(!model.isSelected){
        [btn setImage:[UIImage imageNamed:@"蓝框选中"] forState:UIControlStateNormal];
        [self.deleteArray addObject:self.dataArray[index.section][index.row]];
        model.isSelected = YES;
        self.model = model;
        [self.dataArray[index.section] replaceObjectAtIndex:index.row withObject:model];
    }else{
        [btn setImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateNormal];
        model.isSelected = NO;
        [self.dataArray[index.section] replaceObjectAtIndex:index.row withObject:model];
        [self.deleteArray removeObject:self.dataArray[index.section][index.row]];
    }
    if (self.deleteArray.count != 0) {
        [self.navigationItem.rightBarButtonItem setTitle:[NSString stringWithFormat:@"删除(%lu)", (unsigned long)self.deleteArray.count]];
    }else{
        [self.navigationItem.rightBarButtonItem setTitle:[NSString stringWithFormat:@"删除"]];
    }
}


//点击悬浮添加按钮
- (void)clickAddBtn:(UIButton *)button{
    self.isShowAddBtn = NO;
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.addBtn.hidden = YES;
    self.AddView = [[addView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 60, [UIScreen mainScreen].bounds.size.width, 60)];
    [self.AddView.btn addTarget:self action:@selector(didClickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.AddView];
    [UIView commitAnimations];
}


//点击cell右端详情按钮
- (void)didClickDetailBtn:(UIButton *)button{
    if(self.isShowIntroduce){
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        [self.view addSubview:self.bkgView];
        self.introduction = [[IntroductionView alloc] initWithFrame:CGRectMake(30*WIDTH, 177*HEIGHT, 316*WIDTH, 301*HEIGHT)];
        [self.introduction.btn addTarget:self action:@selector(didClickCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.introduction];
        self.isShowIntroduce = 0;
        [UIView commitAnimations];
    }
    else{
        self.bkgView.hidden = NO;
        self.introduction.hidden = NO;
    }
}


//点击介绍弹窗的关闭按钮
- (void)didClickCloseBtn:(UIButton *)btn{
    self.introduction.hidden = YES;
    self.bkgView.hidden = YES;
}


//点击添加栏的添加按钮
- (void)didClickAddBtn:(UIButton *)button{
    self.isShowAddBtn = NO;
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.addBtn.hidden = NO;
    self.AddView.hidden = YES;
    [UIView commitAnimations];
    [self.AddView.addContent addTarget:self action:@selector(GetText:) forControlEvents:UIControlEventEditingDidEnd];
    [self.AddView.addContent resignFirstResponder];
    self.isShowAddBtn = YES;
}

#pragma - 输入监听

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.AddView.addContent resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.AddView.addContent resignFirstResponder];
    return YES;
}

- (void)GetText:(UITextField *)textField{
    CGRect rect1 = [textField.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15*HEIGHT]} context:nil];
    CGFloat height1 = ceil(rect1.size.height);
    NSString *str = @"十四个字十四个字十四个字十四";
    CGRect rect2 = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15*HEIGHT]} context:nil];
    CGFloat height2 = ceil(rect2.size.height);
    if (height1 > height2) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"你的待办字数太多了ψ(｀∇´)ψ" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (!textField.text.length){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"你没有输入任何待办哦(○o○)" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        NSDictionary *dic = @{@"name":textField.text,
                              @"content":@"",
                              @"property":@"非必需"
                              };
        DLNecessityModel *model = [DLNecessityModel DLNecessityModelWithDict:dic];
        model.isShowMoreBtn = NO;
        [_dataArray addObject:model];
        [self.FMtableView reloadData];
        [self storageData];
    }
}

- (void)keyboardAction:(NSNotification*)sender{
    CGRect rect = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if([sender.name isEqualToString:UIKeyboardWillShowNotification]){
        self.AddView.frame = CGRectMake(0, SCREEN_HEIGHT - rect.size.height-60, SCREEN_WIDTH, 60);
    }else{
        self.AddView.frame = CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60);
    }
}

# pragma - 手势方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_isShowAddBtn) {
        self.addBtn.hidden = YES;
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_isShowAddBtn) {
        self.addBtn.hidden = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
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

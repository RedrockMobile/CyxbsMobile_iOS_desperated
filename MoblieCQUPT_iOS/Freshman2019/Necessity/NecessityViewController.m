//
//  NecessityViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 汪明天 on 2019/8/10.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "NecessityViewController.h"
#import "NecessityViewCell.h"
#import "IntroductionView.h"
#import "Model.h"
#import "addView.h"
#import <AFNetworking.h>
#import "GroupModel.h"
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define WIDTH [UIScreen mainScreen].bounds.size.width/375
#define HEIGHT [UIScreen mainScreen].bounds.size.height/667
@interface NecessityViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong)UIButton *addBtn;  //下方圆形添加按钮
@property (nonatomic, strong)UIButton *editBtn;   //编辑按钮
@property (nonatomic, strong)UIView *bkgView;     //背景阴影
@property (nonatomic, strong)UITableView *WMTtableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *deleteArray;  //需要删除的cell的array
@property (nonatomic, strong)NSDictionary *dict;
@property (nonatomic, strong)NSBundle *fileBundel;
@property (nonatomic, strong)NSString *filePath;
@property (nonatomic, strong)addView *AddView;   //下方添加栏
@property (nonatomic, strong)IntroductionView *introduction; //介绍弹窗
@property (nonatomic, strong)Model *model;
@property (nonatomic, strong) GroupModel *groups;
@property (assign, nonatomic)NSInteger isShowIntroduce;   //如名字
@property (assign, nonatomic)BOOL isEdit;  //是否编辑的flag
@property (assign, nonatomic)BOOL isSelected;
@property (assign, nonatomic)BOOL isFloat;//是否播放cell浮动的动效
@property (assign, nonatomic)BOOL isShowAddBtn;

@end
@implementation NecessityViewController

- (UITableView *)WMTtableView{
    if(!_WMTtableView){
        self.WMTtableView = [[UITableView alloc]initWithFrame: CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65) style:UITableViewStyleGrouped];
        self.WMTtableView.delegate = self;
        self.WMTtableView.dataSource = self;
        self.WMTtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.WMTtableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:247/255.0 blue:255/255.0 alpha:1];
    }
    return _WMTtableView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    
    
    self.isShowAddBtn = YES;
    self.view.backgroundColor = [UIColor colorWithHue:0.6111 saturation:0.0122 brightness:0.9647 alpha:1.0];
    self.fileBundel = [NSBundle mainBundle];
    self.filePath = [_fileBundel pathForResource:@"Necessity" ofType:@"plist"];
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:_filePath];
    if (arr != nil && ![arr isKindOfClass:[NSNull class]] && arr.count != 0){
        [self initModel:arr];
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
    self.bkgView.backgroundColor = [UIColor colorWithHue:0.0000 saturation:0.0000 brightness:0.0192 alpha:0.4];
    
    [self.view addSubview:self.WMTtableView];
    
    self.addBtn = [[UIButton alloc] initWithFrame:CGRectMake(286*WIDTH, 569*HEIGHT, 61*WIDTH, 61*HEIGHT)];
    self.addBtn.backgroundColor = [UIColor clearColor];
    [self.addBtn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(ClickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addBtn];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)buildMyNavigationbar{
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(didClickEditBtn:)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 130, 30)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 30)];
    titleLabel.text = @"入学必备";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:19];
    [titleView addSubview:titleLabel];
    UIButton *detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(85, 7.5, 15*WIDTH, 15*WIDTH)];
    [detailBtn setImage:[UIImage imageNamed:@"详细信息入口"] forState:UIControlStateNormal];
    [detailBtn addTarget: self action:@selector(didClickDetailBtn:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview: detailBtn];
    self.navigationItem.titleView = titleView;
}

#pragma mark - 数据
- (void)getData{
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSString *urlStr = @"https://cyxbsmobile.redrock.team/zscy/zsqy/json/1";
//    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:urlStr method:HttpRequestGet parameters:nil prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self.dict = responseObject;
        NSArray *arr = self.dict[@"text"];
        self.dataArray = [@[] mutableCopy];
        for (NSDictionary *dic in arr) {
            GroupModel *model = [GroupModel groupWithDictinary:dic];
            [_dataArray addObject:model];
        }
        //回到主线程刷新tableview
//        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.WMTtableView reloadData];
//        });
        
        [arr writeToFile:self.filePath atomically:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"你的网络坏掉了m(._.)m" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"failure --- %@",error);
    }];
    

}

- (void) initModel:(NSArray *)arr{
    self.dataArray = [@[] mutableCopy];
    for (NSDictionary *dic in arr) {
      Model *model = [Model modelWithDictionary:dic];
        NSNumber *isReady = dic[@"isReady"];
        model.isReady = [isReady boolValue];
        [_dataArray addObject:model];
    }
}


- (void)StorageData:(NSMutableArray *)arr{
    dispatch_queue_t queue = dispatch_queue_create("storageQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSMutableArray *dataArr = [NSMutableArray array];
        for (int i = 0; i < arr.count; i++) {
            Model *model = arr[i];
            NSNumber *isReady = [NSNumber numberWithBool:model.isReady];
            NSDictionary *dic = @{@"name": model.necessity,
                                  @"content":model.detail,
                                  @"property":model.property,
                                  @"isReady":isReady
                                  };
            [dataArr addObject:dic];
        }
        [dataArr writeToFile:self.filePath atomically:YES];
    });
}
#pragma mark - tableview的代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((GroupModel *)self.dataArray[section]).modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Model *model = ((GroupModel *)self.dataArray[indexPath.section]).modelArray[indexPath.row];
    NecessityViewCell *cell = [NecessityViewCell cellWithTableView:tableView andIndexpath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.WMTModel = model;
    
    
    cell.showTextBlock = ^(NecessityViewCell *Cell) {
        NSIndexPath *index = [tableView indexPathForCell:Cell];
        [tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    cell.btn1.tag = indexPath.row;
    if(self.isEdit){
        if ([cell.WMTModel.property isEqualToString:@"非必需"]) {
            [cell.contentView addSubview:cell.btn3];
        }
        [cell.btn1 removeFromSuperview];
        [cell.btn3 addTarget:self action:@selector(didClickSelectBtn: event:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        [cell.btn1 addTarget:self action:@selector(didClickCellBtn1:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:cell.btn1];
        [cell.btn3 removeFromSuperview];
    }
    if(cell.WMTModel.isReady){
        cell.label.textColor = [UIColor lightGrayColor];
        [cell.btn1 setImage:[UIImage imageNamed:@"蓝框选中"] forState:UIControlStateNormal];
    }
    else{
        cell.label.textColor = [UIColor blackColor];
        [cell.btn1 setImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateNormal];
    }
    if(!cell.WMTModel.isSelected){
        if ([cell.WMTModel.property isEqualToString:@"非必需"]) {
            [cell.btn3 setImage:[UIImage imageNamed:@"删除蓝框"] forState:UIControlStateNormal];
        }
    }
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ((GroupModel *)self.dataArray[section]).headerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Model *model = ((GroupModel *)self.dataArray[indexPath.section]).modelArray[indexPath.row];
    if (model.isShowMore) {
        return [NecessityViewCell cellMoreHeight:model];
    }else{
        return [NecessityViewCell cellDefautHeight:model];
    }
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
    NSInteger count = self.dataArray.count;
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:_WMTtableView];
    NSIndexPath *index = [_WMTtableView indexPathForRowAtPoint:point];
   Model *model = ((GroupModel *)self.dataArray[index.section]).modelArray[index.row];
    if(!model.isReady){
        model.isReady = YES;
        [self.dataArray removeObjectAtIndex:index.row];
        [self.WMTtableView deleteRow:index.row inSection:0 withRowAnimation:UITableViewRowAnimationTop];
        [self.dataArray insertObject:model atIndex:0];
        [self.WMTtableView insertRow:0 inSection:0 withRowAnimation:UITableViewRowAnimationTop];
        self.isFloat = YES;
    }
    else{
        model.isReady = NO;
        [self.dataArray removeObjectAtIndex:index.row];
        [self.WMTtableView deleteRow:index.row inSection:0 withRowAnimation:UITableViewRowAnimationBottom];
        [self.dataArray insertObject:model atIndex:count-1];
        [self.WMTtableView insertRow:self.dataArray.count-1 inSection:0 withRowAnimation:UITableViewRowAnimationBottom];
        self.isFloat = NO;
    }
    //    [_FMtableView reloadData];
    [self StorageData:self.dataArray];
    //    [self starAnimationWithTableView:_FMtableView];
    
}


//点击navigationBar的编辑按钮
- (void)didClickEditBtn:(UIBarButtonItem *)barBtn{
    if(!self.isEdit){
        [barBtn setTitle:@"删除"];
        [_WMTtableView reloadData];
        [self StorageData:self.dataArray];
        self.isEdit = YES;
    }
    else{
        [barBtn setTitle:@"编辑"];
        [self.dataArray removeObjectsInArray:self.deleteArray];
        [self.WMTtableView reloadData];
        [self StorageData:self.dataArray];
        self.isEdit = NO;
    }
}


//删除页面点击圆框按钮
- (void)didClickSelectBtn:(UIButton *)btn event:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:_WMTtableView];
    NSIndexPath *index = [_WMTtableView indexPathForRowAtPoint:point];
    Model *model = self.dataArray[index.row];
    if(!model.isSelected){
        [btn setImage:[UIImage imageNamed:@"删除蓝框选中"] forState:UIControlStateNormal];
        [self.deleteArray addObject:self.dataArray[index.row]];
        model.isSelected = YES;
        self.model = model;
        [self.dataArray replaceObjectAtIndex:index.row withObject:model];
    }
    else{
        [btn setImage:[UIImage imageNamed:@"删除蓝框"] forState:UIControlStateNormal];
        model.isSelected = NO;
        [self.dataArray replaceObjectAtIndex:index.row withObject:model];
        [self.deleteArray removeObject:self.dataArray[index.row]];
    }
}


//点击悬浮添加按钮
- (void)ClickAddBtn:(UIButton *)button{
    self.isShowAddBtn = NO;
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.addBtn.hidden = YES;
    self.AddView = [[addView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-60, [UIScreen mainScreen].bounds.size.width, 60)];
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
        Model *model = [Model modelWithDictionary:dic];
        model.isShowMoreBtn = NO;
        [_dataArray addObject:model];
        [self.WMTtableView reloadData];
        [self StorageData:_dataArray];
    }
}

- (void)keyboardAction:(NSNotification*)sender{
    CGRect rect = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if([sender.name isEqualToString:UIKeyboardWillShowNotification]){
        self.AddView.frame = CGRectMake(0,SCREENH_HEIGHT-rect.size.height-60,SCREEN_WIDTH, 60);
    }else{
        self.AddView.frame = CGRectMake(0,SCREENH_HEIGHT-60,SCREEN_WIDTH, 60);
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

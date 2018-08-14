//
//  DLNecessityViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "DLNecessityViewController.h"
#import "FMNecessityTableViewCell.h"
#import "addView.h"
#import "DLNecessityModel.h"
#import "IntroductionView.h"
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width


@interface DLNecessityViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>


@property (nonatomic, strong)UIButton *addBtn;
@property (nonatomic, strong)UIButton *editBtn;
@property (nonatomic, strong)UIView *bkgView;
@property (nonatomic, strong)UITableView *FMtableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *deleteArray;
@property (nonatomic, strong)addView *AddView;
@property (nonatomic, strong)IntroductionView *introduction;
@property (nonatomic, strong)DLNecessityModel *model;
@property (assign, nonatomic)NSInteger isShowIntroduce;
@property (assign, nonatomic)BOOL isEdit;
@property (assign, nonatomic)BOOL isSelected;
@property (assign, nonatomic)NSUInteger row;
@property (assign, nonatomic)BOOL isFloat;


@end

@implementation DLNecessityViewController

- (UITableView *)FMtableView{
    if(!_FMtableView){
        self.FMtableView = [[UITableView alloc]initWithFrame: CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50) style:UITableViewStylePlain];
        self.FMtableView.delegate = self;
        self.FMtableView.dataSource = self;
        //        self.FMtableView.rowHeight = 80;
        self.FMtableView.backgroundColor = [UIColor clearColor];
    }
    return _FMtableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHue:0.6111 saturation:0.0122 brightness:0.9647 alpha:1.0];
    
    [self buildMyNavigationbar];
    [self buildData];
    self.deleteArray = [@[] mutableCopy];
    self.isShowIntroduce = 1;
    self.isEdit = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.bkgView = [[UIView alloc]initWithFrame:self.view.frame];
    self.bkgView.backgroundColor = [UIColor colorWithHue:0.0000 saturation:0.0000 brightness:0.0192 alpha:0.4];
    
    [self.view addSubview:self.FMtableView];
    
    self.addBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 120, [UIScreen mainScreen].bounds.size.height - 130, 80, 80)];
    self.addBtn.backgroundColor = [UIColor clearColor];
    [self.addBtn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(ClickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addBtn];
    // Do any additional setup after loading the view, typically from a nib.
}




- (void)buildMyNavigationbar{
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
//    [left setImage:[UIImage imageNamed:@"返回"]];
//
//    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(didClickEditBtn:)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    titleLabel.text = @"入学必备";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [titleView addSubview:titleLabel];
    UIButton *detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(75, 5, 20, 20)];
    [detailBtn setImage:[UIImage imageNamed:@"详细信息入口"] forState:UIControlStateNormal];
    [detailBtn addTarget: self action:@selector(didClickDetailBtn:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview: detailBtn];
    self.navigationItem.titleView = titleView;
}

#pragma - 数据

- (void)buildData{
    //    NSArray *arr = @[@"录取通知书",@"高考准考证",@"身份证",@"《新生适应性资料》学习心得",@"同版近期证件照15张",@"《学生管理与学生自律协议书》",@"《致2018级新生的一封信》",@"社会实践报告",@"团员证",@"转团组织关系资料"];
    NSArray *arr = @[@{@"necessity":@"录取通知书1",
                       @"detail":@"少年不识愁滋味，爱上层楼。爱上层楼，为赋新词强说愁。\n而今识尽愁滋味，欲说还休。欲说还休，却道天凉好个秋。\n少年不识愁滋味，爱上层楼。爱上层楼，为赋新词强说愁。\n而今识尽愁滋味，欲说还休。欲说还休，却道天凉好个秋。\n"
                       },
                     @{@"necessity":@"录取通知书2",
                       @"detail":@"少年不识愁滋味，爱上层楼。爱上层楼，为赋新词强说愁。\n而今识尽愁滋味，欲说还休。欲说还休，却道天凉好个秋。"
                       },
                     @{@"necessity":@"录取通知书3",
                       @"detail":@"少年不识愁滋味，爱上层楼。爱上层楼，为赋新词强说愁。\n而今识尽愁滋味，欲说还休。欲说还休，却道天凉好个秋。"
                       },
                     @{@"necessity":@"录取通知书4",
                       @"detail":@"少年不识愁滋味，爱上层楼。爱上层楼，为赋新词强说愁。\n而今识尽愁滋味，欲说还休。欲说还休，却道天凉好个秋。"
                       },
                     @{@"necessity":@"录取通知书5",
                       @"detail":@"少年不识愁滋味，爱上层楼。爱上层楼，为赋新词强说愁。\n而今识尽愁滋味，欲说还休。欲说还休，却道天凉好个秋。"
                       },
                     @{@"necessity":@"录取通知书6",
                       @"detail":@"少年不识愁滋味，爱上层楼。爱上层楼，为赋新词强说愁。\n而今识尽愁滋味，欲说还休。欲说还休，却道天凉好个秋。"
                       },
                     @{@"necessity":@"录取通知书7",
                       @"detail":@"少年不识愁滋味，爱上层楼。爱上层楼，为赋新词强说愁。\n而今识尽愁滋味，欲说还休。欲说还休，却道天凉好个秋。"
                       },
                     @{@"necessity":@"录取通知书8",
                       @"detail":@"少年不识愁滋味，爱上层楼。爱上层楼，为赋新词强说愁。\n而今识尽愁滋味，欲说还休。欲说还休，却道天凉好个秋。"
                       },
                     @{@"necessity":@"录取通知书9",
                       @"detail":@"少年不识愁滋味，爱上层楼。爱上层楼，为赋新词强说愁。\n而今识尽愁滋味，欲说还休。欲说还休，却道天凉好个秋。"
                       },
                     ];
    self.dataArray = [@[] mutableCopy];
    for (NSDictionary *dic in arr) {
        DLNecessityModel *model = [DLNecessityModel DLNecessityModelWithDict:dic];
        [_dataArray addObject:model];
    }
}

#pragma - tableview的代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FMNecessityTableViewCell *cell = [FMNecessityTableViewCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.DLNModel = self.dataArray[indexPath.row];
    
    
    cell.showTextBlock = ^(FMNecessityTableViewCell *Cell) {
        NSIndexPath *index = [tableView indexPathForCell:Cell];
        [tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    cell.btn1.tag = indexPath.row;
    if(self.isEdit){
        [cell.contentView addSubview:cell.btn3];
        [cell.btn1 removeFromSuperview];
        [cell.btn3 addTarget:self action:@selector(didClickSelectBtn: event:) forControlEvents:UIControlEventTouchUpInside];
        self.row = indexPath.row;
    }
    else{
        self.row = indexPath.row;
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
        [cell.btn3 setImage:[UIImage imageNamed:@"删除蓝框"] forState:UIControlStateNormal];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLNecessityModel *model = self.dataArray[indexPath.row];
    if (model.isShowMore) {
        return [FMNecessityTableViewCell cellMoreHeight:model];
    }else{
        return [FMNecessityTableViewCell cellDefautHeight:model];
    }
}

- (void)starAnimationWithTableView:(UITableView *)tableView{
    if(_isFloat){
        NSArray *cells = tableView.visibleCells;
        for (int i = 0; i < cells.count; i++) {
            UITableViewCell *cell = [cells objectAtIndex:i];
            cell.layer.opacity = 0.7;
            cell.layer.transform = CATransform3DMakeTranslation(0, [[UIScreen mainScreen] bounds].size.height, 20);
            NSTimeInterval totalTime = 1.0;
            
            [UIView animateWithDuration:0.4 delay:i*(totalTime/cells.count) usingSpringWithDamping:0.65 initialSpringVelocity:1/0.65 options:UIViewAnimationOptionCurveEaseIn animations:^{
                cell.layer.opacity = 1.0;
                cell.layer.transform = CATransform3DMakeTranslation(0, 0, 20);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

#pragma - 点击button事件

- (void)didClickCellBtn1:(UIButton *)button event:(UIEvent *)event{
    NSInteger count = self.dataArray.count;
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:_FMtableView];
    NSIndexPath *index = [_FMtableView indexPathForRowAtPoint:point];
    DLNecessityModel *model = self.dataArray[index.row];
    if(!model.isReady){
        model.isReady = YES;
        [self.dataArray removeObjectAtIndex:index.row];
        [self.dataArray insertObject:model atIndex:0];
        self.isFloat = YES;
    }
    else{
        model.isReady = NO;
        [self.dataArray removeObjectAtIndex:index.row];
        [self.dataArray insertObject:model atIndex:count-1];
        self.isFloat = NO;
    }
    [_FMtableView reloadData];
    [self starAnimationWithTableView:_FMtableView];
    
}


- (void)didClickEditBtn:(UIBarButtonItem *)barBtn{
    if(!self.isEdit){
        [barBtn setTitle:@"删除"];
        [_FMtableView reloadData];
        self.isEdit = YES;
    }
    else{
        [barBtn setTitle:@"编辑"];
        [_FMtableView reloadData];
        [self.dataArray removeObjectsInArray:self.deleteArray];
        [self.FMtableView reloadData];
        self.isEdit = NO;
    }
}

- (void)didClickSelectBtn:(UIButton *)btn event:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:_FMtableView];
    NSIndexPath *index = [_FMtableView indexPathForRowAtPoint:point];
    DLNecessityModel *model = self.dataArray[index.row];
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

- (void)ClickAddBtn:(UIButton *)button{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.addBtn.hidden = YES;
    self.AddView = [[addView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-60, [UIScreen mainScreen].bounds.size.width, 60)];
    [self.AddView.btn addTarget:self action:@selector(didClickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.AddView];
    [UIView commitAnimations];
}

- (void)didClickDetailBtn:(UIButton *)button{
    if(self.isShowIntroduce){
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        [self.view addSubview:self.bkgView];
        self.introduction = [[IntroductionView alloc] initWithFrame:CGRectMake(45, 200, [UIScreen mainScreen].bounds.size.width - 90, 300)];
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

- (void)didClickCloseBtn:(UIButton *)btn{
    self.introduction.hidden = YES;
    self.bkgView.hidden = YES;
}

- (void)didClickAddBtn:(UIButton *)button{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.addBtn.hidden = NO;
    self.AddView.hidden = YES;
    [UIView commitAnimations];
    [self.AddView.addContent addTarget:self action:@selector(GetText:) forControlEvents:UIControlEventEditingDidEnd];
    
    [self.AddView.addContent resignFirstResponder];
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
    
    NSDictionary *dic = @{@"necessity":textField.text,
                          @"detail":@""
                          };
    DLNecessityModel *model = [DLNecessityModel DLNecessityModelWithDict:dic];
    [_dataArray addObject:model];
    [self.FMtableView reloadData];
}

- (void)keyboardAction:(NSNotification*)sender{
    CGRect rect = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if([sender.name isEqualToString:UIKeyboardWillShowNotification]){
        self.AddView.frame = CGRectMake(0,SCREENH_HEIGHT-rect.size.height-60,SCREEN_WIDTH, 60);
    }else{
        self.AddView.frame = CGRectMake(0,SCREENH_HEIGHT-60,SCREEN_WIDTH, 60);
    }
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

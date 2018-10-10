//
//  WYCClassBookViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/9/21.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "WYCClassBookViewController.h"
#import "WYCShowDetailViewController.h"
#import "WYCClassBookModel.h"
#import "WYCNoteModel.h"
#import "DateModle.h"
#import "WYCClassBookView.h"

#import "WYCWeekChooseBar.h"
#import "LoginViewController.h"
#import "NoLoginView.h"

#import "AddRemindViewController.h"
#import "UIFont+AdaptiveFont.h"
#import "RemindNotification.h"
#import "LessonController.h"


#define DateStart @"2018-09-10"

@interface WYCClassBookViewController ()<UIScrollViewDelegate,WYCClassBookViewDelegate>
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, assign) BOOL hiddenWeekChooseBar;
@property (nonatomic, strong) NSNumber *nowWeek;
@property (nonatomic, strong) NSMutableArray *titleTextArray;
@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) WYCWeekChooseBar *weekChooseBar;
@property (nonatomic, strong) NoLoginView *noLoginView;
@property (nonatomic, strong) DateModle *dateModel;
@property (nonatomic, strong) WYCClassBookModel *classBookModel;
@property (nonatomic, strong) WYCNoteModel *noteModel;

@property (nonatomic, copy) NSString *stuNum;
@property (nonatomic, copy) NSString *idNum;

@property (nonatomic, copy) NSString *noteModelLoadSuccess;
@property (nonatomic, copy) NSString *classbookModelLoadSuccess;

@end

@implementation WYCClassBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _noteModelLoadSuccess = @"";
    _classbookModelLoadSuccess = @"";
    
    self.titleTextArray = [@[@"整学期",@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周",@"第九周",@"第十周",@"第十一周",@"第十二周",@"第十三周",@"第十四周",@"第十五周",@"第十六周",@"第十七周",@"第十八周",@"第十九周",@"第二十周",@"第二十一周",@"第二十二周",@"第二十三周",@"第二十四周",@"第二十五周"] mutableCopy];
    //默认星期选择条不显示
    self.hiddenWeekChooseBar = YES;
    
    [self initWeekChooseBar];
    
    
    //判断是否已经登录
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    if (stuNum == nil || idNum == nil) {
        self.noLoginView = [[NoLoginView alloc]initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT-(HEADERHEIGHT+TABBARHEIGHT))];
        [self.view addSubview:self.noLoginView];
        [self.noLoginView.loginButton addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        
        self.stuNum = [UserDefaultTool getStuNum];
        self.idNum = [UserDefaultTool getIdNum];
        //        NSLog(@"stuNum:%@",self.stuNum);
        //        NSLog(@"idNum:%@",self.idNum);
        [self initModel];
        
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(WYCClassBookModelDataLoadSuccessful)
                                                 name:@"WYCClassBookModelDataLoadSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(WYCClassBookModelDataLoadFailure)
                                                 name:@"WYCClassBookModelDataLoadFailure" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(WYCNoteModelDataLoadSuccess)
                                                 name:@"WYCNoteModelDataLoadSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(WYCNoteModelDataLoadFailure)
                                                 name:@"WYCNoteModelDataLoadFailure" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateScrollViewOffSet)
                                                 name:@"ScrollViewBarChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadView)
                                                 name:@"reloadView" object:nil];
    
    
}
- (void)WYCClassBookModelDataLoadSuccessful {
    _classbookModelLoadSuccess = @"YES";
}

- (void)WYCClassBookModelDataLoadFailure{
    _classbookModelLoadSuccess = @"NO";
}
- (void)WYCNoteModelDataLoadSuccess{
    _noteModelLoadSuccess = @"YES";
}

- (void)WYCNoteModelDataLoadFailure{
    _noteModelLoadSuccess = @"NO";
}

-(void)reloadView{
    [_scrollView removeAllSubviews];
    self.stuNum = [UserDefaultTool getStuNum];
    self.idNum = [UserDefaultTool getIdNum];
    [self initClassModel];
    [self initNoteModel];
    [self performSelector:@selector(allModelLoadSuccessful) withObject:nil afterDelay:3];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    _index = (long)roundf(scrollView.contentOffset.x/_scrollView.frame.size.width);
    //NSLog(@"index:%ld",_index);
    // NSLog(@"index:%ld",(long)_index);
    [self initTitleLabel];
    [self.weekChooseBar changeIndex:_index];
    
}
-(void)updateScrollViewOffSet{
    self.index = self.weekChooseBar.index;
    [UIView animateWithDuration:0.2f animations:^{
        self.scrollView.contentOffset = CGPointMake(self.index*self.scrollView.frame.size.width,0);
    } completion:nil];
    [self initTitleLabel];
    
    
}
- (void)initModel{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载数据中...";
    hud.color = [UIColor colorWithWhite:0.f alpha:0.4f];
    /*
    //如果有缓存，则从缓存加载数据
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *remindPath = [path stringByAppendingPathComponent:@"remind.plist"];
    
    if (([UserDefaultTool valueWithKey:@"lessonResponse"][@"data"]) && ([NSMutableArray arrayWithContentsOfFile:remindPath])) {
        
        _noteModel = [[WYCNoteModel alloc]init];
        [_noteModel parsingData:[NSMutableArray arrayWithContentsOfFile:remindPath]];
        self.noteModelLoadSuccess = @"YES";
        
        
        _classBookModel = [[WYCClassBookModel alloc]init];
        NSArray *array = [UserDefaultTool valueWithKey:@"lessonResponse"][@"data"];
        [_classBookModel.weekArray addObject:array];
        [ _classBookModel parsingData:array];
        self.classbookModelLoadSuccess = @"YES";
        
        [self allModelLoadSuccessful];
    }else{
    //没缓存，从网络加载
        [self initClassModel];
        [self initNoteModel];
        [self performSelector:@selector(allModelLoadSuccessful) withObject:nil afterDelay:3];
    }
    */
    [self initClassModel];
    [self initNoteModel];
    [self performSelector:@selector(allModelLoadSuccessful) withObject:nil afterDelay:2];
}
- (void)initClassModel{
    
    
    if (!_classBookModel) {
        _classBookModel = [[WYCClassBookModel alloc]init];
        [_classBookModel getClassBookArray:self.stuNum];
    }
}
- (void)initNoteModel{
    if (!_noteModel) {
        _noteModel = [[WYCNoteModel alloc]init];
        [_noteModel getNote:self.stuNum idNum:self.idNum];
    }
}

- (void)allModelLoadSuccessful{
    if (([_noteModelLoadSuccess isEqualToString:@"YES"]&&[_classbookModelLoadSuccess isEqualToString:@"YES"])) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        DateModle *date = [[DateModle alloc]init];
        [date initCalculateDate:DateStart];
        
        [_scrollView layoutIfNeeded];
        
        @autoreleasepool {
            for (int dateNum = 0; dateNum < date.dateArray.count + 1; dateNum++) {
                
                NSMutableArray *day = [[NSMutableArray alloc]initWithCapacity:7];
                
                for (int i = 0; i < 7; i++) {
                    
                    NSMutableArray *lesson = [[NSMutableArray alloc]initWithCapacity:6];
                    
                    for (int j = 0; j < 6; j++) {
                        
                        [lesson addObject:[@[] mutableCopy]];
                    }
                    [day addObject:[lesson mutableCopy]];
                }
                
                NSArray *classBookData = _classBookModel.weekArray[dateNum];
                for (int i = 0; i < classBookData.count; i++) {
                    
                    NSNumber *hash_day = [classBookData[i] objectForKey:@"hash_day"];
                    NSNumber *hash_lesson = [classBookData[i] objectForKey:@"hash_lesson"];
                    
                    [ day[hash_day.integerValue][hash_lesson.integerValue] addObject: classBookData[i]];
                    
                }
                
                
                if (dateNum !=0) {
                    NSArray *noteData = _noteModel.noteArray[dateNum-1];
                    
                    for (int i = 0; i < noteData.count; i++) {
                        
                        NSNumber *hash_day = [noteData[i] objectForKey:@"hash_day"];
                        NSNumber *hash_lesson = [noteData[i] objectForKey:@"hash_lesson"];
                        
                        [ day[hash_day.integerValue][hash_lesson.integerValue] addObject: noteData[i]];
                    }
                }
                
                WYCClassBookView *view = [[WYCClassBookView alloc]initWithFrame:CGRectMake(dateNum*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
                view.detailDelegate = self;
                if (dateNum == 0) {
                    [view initView:YES];
                    NSArray *dateArray = @[];
                    [view addBar:dateArray isFirst:YES];
                }else{
                    [view initView:NO];
                    [view addBar:date.dateArray[dateNum-1] isFirst:NO];
                }
                
                // [view addClassData:_classBookModel.weekArray[i+1]];
                //[view addNoteData:_noteModel.noteArray[i]];
                [view addBtn:day];
                [_scrollView addSubview:view];
            }
        }
        [_scrollView layoutSubviews];
        _scrollView.contentSize = CGSizeMake(date.dateArray.count * _scrollView.frame.size.width, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [_rootView addSubview:_scrollView];
        
        
        
        NSLog(@"nowweek:%@",self.classBookModel.nowWeek);
        self.index = self.classBookModel.nowWeek.integerValue;
        
        self.titleTextArray[_index] = @"本周";
        self.scrollView.contentOffset = CGPointMake(self.index*self.scrollView.frame.size.width,0);
        [self initWeekChooseBar];
        [self initTitleLabel];
        [self.weekChooseBar changeIndex:self.index];
        
        [self initNavigationBar];
        
    }else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"classBook:%@,note:%@",_classbookModelLoadSuccess,_noteModelLoadSuccess);
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"网络错误" message:@"数据加载失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act1=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [controller addAction:act1];
        
        [self presentViewController:controller animated:YES completion:^{
            
        }];
        UIButton *btn = [[UIButton alloc]init];
        btn.height = 20;
        btn.width = 40;
        btn.centerX = self.view.centerX;
        btn.centerY = self.view.centerY;
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(reloadView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
- (void)initNavigationBar{
    [self initTitleView];
    [self initRightButton];
}
- (void)initTitleView{
    
    //自定义titleView
    self.titleView = [[UIView alloc]init];
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-60, 0, 120, 40)];
    self.titleView.backgroundColor = [UIColor clearColor];
    [self initTitleLabel];
    [self initTitleBtn];
}
- (void)initTitleLabel{
    if (_titleLabel) {
        [_titleLabel removeFromSuperview];
    }
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleView.frame.size.width/2-50, 0, 100, _titleView.frame.size.height)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    
    self.titleText = self.titleTextArray[_index];
    self.titleLabel.text = self.titleText;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.userInteractionEnabled = YES;
    
    //添加点击手势
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateWeekChooseBar)];
    [self.titleLabel addGestureRecognizer:tapGesture];
    [self.titleView addSubview:self.titleLabel];
}
- (void)initTitleBtn{
    //添加箭头按钮
    if (_titleBtn) {
        [_titleBtn removeFromSuperview];
    }
    self.titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(_titleView.frame.size.width-10, 0, 9, _titleView.frame.size.height)];
    //判断箭头方向
    if (_hiddenWeekChooseBar) {
        [self.titleBtn setImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];   //初始是下箭头
    }else{
        [self.titleBtn setImage:[UIImage imageNamed:@"uparrow"] forState:UIControlStateNormal];
    }
    
    [self.titleBtn addTarget: self action:@selector(updateWeekChooseBar) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview: self.titleBtn];
    
    self.navigationItem.titleView = self.titleView;
}
- (void)initRightButton{
    //添加备忘按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus"] style:UIBarButtonItemStylePlain target:self action:@selector(addNote)];
    self.navigationItem.rightBarButtonItem = right;
    
}

//添加备忘
- (void)addNote{
    
    AddRemindViewController *vc = [[AddRemindViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//添加星期选择条
- (void)initWeekChooseBar{
    if (_weekChooseBar) {
        [_weekChooseBar removeFromSuperview];
    }
    self.weekChooseBar = [[WYCWeekChooseBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 39*autoSizeScaleY) andArray:self.titleTextArray];
    self.weekChooseBar.hidden = self.hiddenWeekChooseBar;
    [self.view addSubview:self.weekChooseBar];
}

//更新星期选择条状态
- (void)updateWeekChooseBar{
    if (self.hiddenWeekChooseBar) {
        self.hiddenWeekChooseBar = NO;
        self.weekChooseBar.hidden = self.hiddenWeekChooseBar;
        [self initTitleBtn];
        [self updateScrollViewFame];
        
    }else{
        self.hiddenWeekChooseBar = YES;
        self.weekChooseBar.hidden = self.hiddenWeekChooseBar;
        [self initTitleBtn];
        [self updateScrollViewFame];
    }
}
-(void)updateScrollViewFame{
    //NSLog(@"num:%lu",(unsigned long)_scrollView.subviews.count);
    if (self.hiddenWeekChooseBar) {
        [_rootView setFrame:CGRectMake(0, 0, _rootView.frame.size.width, _rootView.frame.size.height)];
        [_rootView layoutIfNeeded];
        [_rootView layoutSubviews];
        for (int i = 0; i < 26; i++) {
            //NSLog(@"num:%d",i);
            WYCClassBookView *view = _scrollView.subviews[i];
            [view changeScrollViewContentSize:CGSizeMake(0, 606*autoSizeScaleY)];
            [view layoutIfNeeded];
            [view layoutSubviews];
        }
    }else{
        [_rootView setFrame:CGRectMake(0, self.weekChooseBar.frame.size.height, _rootView.frame.size.width, _rootView.frame.size.height)];
        [_rootView layoutIfNeeded];
        [_rootView layoutSubviews];
        //NSLog(@"viewcount:%lu",(unsigned long)_scrollView.subviews.count);
        for (int i = 0; i < 26; i++) {
            //NSLog(@"num:%d",i);
            WYCClassBookView *view = _scrollView.subviews[i];
            
            [view changeScrollViewContentSize:CGSizeMake(0, 606*autoSizeScaleY + self.weekChooseBar.frame.size.height)];
            [view layoutIfNeeded];
            [view layoutSubviews];
            //NSLog(@"viewnum:%d",i);
        }
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)clickLoginBtn{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否登录" message:@"马上登录拯救课表菌" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *loginViewController = [[LoginViewController alloc]init];
        
        loginViewController.loginSuccessHandler = ^(BOOL success) {
            if (success) {
                self.stuNum = [UserDefaultTool getStuNum];
                self.idNum = [UserDefaultTool getIdNum];
               
                [self initModel];
                [self.noLoginView removeFromSuperview];
                [[RemindNotification shareInstance] addNotifictaion];
            }
        };
        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:loginAction];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}



- (void)showDetail:(NSArray *)array{
    WYCShowDetailViewController *vc = [[WYCShowDetailViewController alloc]init];
    [vc initWithArray:array];
    [self.navigationController pushViewController:vc animated:YES];
    
  
}

@end



//
//  WYCClassBookViewController.m
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "WYCClassBookViewController1.h"
#import "ClassBook.h"
#import "DateModle.h"
#import "SegmentView.h"
#import "WYCClassBookView.h"
#import "WYCWeekChooseBar.h"
#import "LoginViewController.h"
#import "NoLoginView.h"

#define DateStart @"2018-03-05"
@interface WYCClassBookViewController1 ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (nonatomic, strong) ClassBook *model;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, copy) NSString *titleText;
//@property (nonatomic, strong) UINavigationItem *navigationItem;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, assign) BOOL hiddenScrollViewBar;
@property (nonatomic, strong) WYCWeekChooseBar *scrollViewBar;
@property (nonatomic, strong) NSString *stuNum;
@property (nonatomic, strong) NoLoginView *noLoginView;
@end

@implementation WYCClassBookViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    if (stuNum == nil || idNum == nil) {
        self.noLoginView = [[NoLoginView alloc]initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT-(HEADERHEIGHT+TABBARHEIGHT))];
        [self.view addSubview:self.noLoginView];
        [self.noLoginView.loginButton addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        _stuNum = [UserDefaultTool valueWithKey:@"stuNum"];
        if (!_model) {
            _model = [[ClassBook alloc]init];
            [_model getClassBookArray:_stuNum title:self.title];
        }
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"加载数据中...";
        //    hud.detailsLabelText = @"不如先去看看其他的？";
        hud.color = [UIColor colorWithWhite:0.f alpha:0.4f];
        
        
        
    }
    _index = 0;
    _hiddenScrollViewBar = YES;
    
    _titleArray = @[@"整学期",@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周",@"第九周",@"第十周",@"第十一周",@"第十二周",@"第十三周",@"第十四周",@"第十五周",@"第十六周",@"第十七周",@"第十八周",@"第十九周",@"第二十周",@"第二十一周",@"第二十二周",@"第二十三周",@"第二十四周",@"第二十五周"];
    [self changeNavigationItemTitle];
    //_navigationItem = [[UINavigationItem alloc]init];
    
    //self.navigationItem = _navigationItem;
    
    _scrollViewBar = [[WYCWeekChooseBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 39*autoSizeScaleY) andArray:_titleArray];
    
    _scrollViewBar.hidden = _hiddenScrollViewBar;
    
    [self.view addSubview:_scrollViewBar];
    [self initTitleView];
//     self.navigationItem.titleView = _titleView;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DataLoadSuccessful)
                                                 name:[NSString stringWithFormat:@"%@DataLoadSuccess",self.title] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DataLoadFailure)
                                                 name:[NSString stringWithFormat:@"%@DataLoadFailure",self.title] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateScrollViewOffSet)
                                                 name:@"ScrollViewBarChanged" object:nil];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)clickLoginBtn{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否登录" message:@"马上登录拯救课表菌" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *loginViewController = [[LoginViewController alloc]init];
        loginViewController.loginSuccessHandler = ^(BOOL success) {
            if (success) {
                //                [self afterLogin];
            }
        };
        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:loginAction];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)DataLoadSuccessful {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
   // NSLog(@"week1:%@",_model.classBookArray[0]);
    DateModle *date = [[DateModle alloc]init];
    [date initCalculateDate:DateStart];
    
    
    
    [_scrollView layoutIfNeeded];
    WYCClassBookView *view = [[WYCClassBookView alloc]initWithFrame:CGRectMake(0*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [view initView:YES];
    NSArray *dateArray = @[];
    [view addBar:dateArray isFirst:YES];
    [view addBtn:_model.classBookArray[0]];
    [view chackBigLesson];
    [_scrollView addSubview:view];
    
    @autoreleasepool {
        for (int i = 0; i < date.dateArray.count; i++) {
            WYCClassBookView *view = [[WYCClassBookView alloc]initWithFrame:CGRectMake((i+1)*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
            [view initView:NO];
            [view addBar:date.dateArray[i] isFirst:NO];
            [view addBtn:_model.classBookArray[i]];
            [view chackBigLesson];
            [_scrollView addSubview:view];
        }
    }
    [_scrollView layoutSubviews];
    _scrollView.contentSize = CGSizeMake(date.dateArray.count * _scrollView.frame.size.width, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    
    [_rootView addSubview:_scrollView];
   
    [self.view addSubview:_rootView];
    
    
    
}

- (void)DataLoadFailure{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"网络错误" message:@"数据加载失败" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act1=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [controller addAction:act1];
    
    [self presentViewController:controller animated:YES completion:^{
        
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    _index = (long)roundf(scrollView.contentOffset.x/_scrollView.frame.size.width);
    NSLog(@"index:%ld",_index);
   // NSLog(@"index:%ld",(long)_index);
    [self changeNavigationItemTitle];
    [self initTitleView];
    [_scrollViewBar changeIndex:_index];
    
}

-(void)changeNavigationItemTitle{
    
    _titleText = _titleArray[_index];
    
}
- (void)initTitleView{
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"加号"] style:UIBarButtonItemStylePlain target:self action:@selector(addNote)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-40, 0, 80, 40)];
    _titleView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleView.frame.size.width/2-30, 0, 60, _titleView.frame.size.height)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = _titleText;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.userInteractionEnabled = YES;
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSegmentView)];
    [titleLabel addGestureRecognizer:tapGesture];
    [_titleView addSubview:titleLabel];
    
    
    UIButton *detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(_titleView.frame.size.width/2+30, 0, 9, _titleView.frame.size.height)];
    //展开是下箭头，不展开是上箭头
    if (_hiddenScrollViewBar) {
        [detailBtn setImage:[UIImage imageNamed:@"下箭头"] forState:UIControlStateNormal];
    }else{
    [detailBtn setImage:[UIImage imageNamed:@"上箭头"] forState:UIControlStateNormal];
    }
    [detailBtn addTarget: self action:@selector(showSegmentView) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview: detailBtn];
    
    self.navigationItem.titleView = _titleView;
    
}

-(void)showSegmentView{
    if (_hiddenScrollViewBar) {
        _hiddenScrollViewBar = NO;
        _scrollViewBar.hidden = _hiddenScrollViewBar;
        [self initTitleView];
        [self updateScrollViewFame];
        
    }else{
        _hiddenScrollViewBar = YES;
        _scrollViewBar.hidden = _hiddenScrollViewBar;
        [self initTitleView];
        [self updateScrollViewFame];
    }
    
}
-(void)updateScrollViewFame{
    if (_hiddenScrollViewBar) {
        [_rootView setFrame:CGRectMake(0, 0, _rootView.frame.size.width, _rootView.frame.size.height)];
        [_rootView layoutIfNeeded];
        [_rootView layoutSubviews];
        for (int i = 0; i < 26; i++) {
            WYCClassBookView *view = _scrollView.subviews[i];
            [view changeScrollViewContentSize:CGSizeMake(0, 606*autoSizeScaleY)];
            [view layoutIfNeeded];
            [view layoutSubviews];
        }
    }else{
        [_rootView setFrame:CGRectMake(0, _scrollViewBar.frame.size.height, _rootView.frame.size.width, _rootView.frame.size.height)];
        [_rootView layoutIfNeeded];
        [_rootView layoutSubviews];
        //NSLog(@"viewcount:%lu",(unsigned long)_scrollView.subviews.count);
        for (int i = 0; i < 26; i++) {
            
            WYCClassBookView *view = _scrollView.subviews[i];
            [view changeScrollViewContentSize:CGSizeMake(0, 606*autoSizeScaleY + _scrollViewBar.frame.size.height)];
            [view layoutIfNeeded];
            [view layoutSubviews];
            //NSLog(@"viewnum:%d",i);
        }
    }
}
-(void)updateScrollViewOffSet{
    _index = _scrollViewBar.index;
    [UIView animateWithDuration:0.2f animations:^{
        self->_scrollView.contentOffset = CGPointMake(self->_index*self->_scrollView.frame.size.width,0);
    } completion:nil];
    
   
}
-(void)addNote{
    
    _scrollViewBar.index = _scrollViewBar.index + 1;
    NSLog(@"barindex:%ld",_scrollViewBar.index);
    [_scrollViewBar changeIndex:_index];
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

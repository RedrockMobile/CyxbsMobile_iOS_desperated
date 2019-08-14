//
//  MainViewController.m
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/2.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "FYHOnlineActivityMainViewController.h"
#import "FYHSearchResult.h"
#import "FYHAcademyGroupController.h"
#import "FYHHometownGroupController.h"
#import "FYHOnlineActivitiesController.h"
#import "WillCopy.h"
#import "FYHSearchBar.h"
#import "SuccessWindow.h"
#import "ActicytyQRCodeView.h"
#import "ActivityItem.h"

#define SEGMENTBAR_H 49
#define CELL_H 53

@interface FYHOnlineActivityMainViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) FYHSearchBar *searchBar;
@property (nonatomic, weak) FYHSearchResult *resultTable;
@property (nonatomic, strong) AcademyOrHometownItem *selectedItem;
@property (nonatomic, weak) WillCopy *willCopyWindow;
@property (nonatomic, weak) UILabel *warning;
@property (nonatomic, weak) UITableView *academyTable;
@property (nonatomic, weak) UITableView *hometownTable;
@property (nonatomic, assign) BOOL isKeyboardVisible;

@end

@implementation FYHOnlineActivityMainViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(academyRequetsSucceeded:) name:@"model requests suceeded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedACell:) name:@"selected a cell" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(joinActivity:) name:@"join activity" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeKeyboardStatus:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeKeyboardStatus:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    self.title = @"线上交流";
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:247/255.0 blue:254/255.0 alpha:1];
    self.slider.hidden = YES;
    [self.segmentButtons[self.selectedIndex] setTitleColor:[UIColor colorWithRed:70/255.0 green:114/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    
    // 搜索条
    FYHSearchBar *searchBar = [[FYHSearchBar alloc] initWithFrame:CGRectMake(15, SEGMENTBAR_H + 15, MAIN_SCREEN_W - 30, CELL_H)];
    [self.view addSubview:searchBar];
    
    self.searchBar = searchBar;
    self.searchBar.textField.delegate = self;
    self.searchBar.textField.placeholder = @" 找不到学院群？试试搜索";
    self.searchBar.textField.font = [UIFont systemFontOfSize:15];
    
    // 搜索结果表格
    FYHSearchResult *resultTable = [[FYHSearchResult alloc] initWithFrame:CGRectMake(15, SEGMENTBAR_H + CELL_H + 15, MAIN_SCREEN_W - 30, 0) style:UITableViewStylePlain];
    self.resultTable = resultTable;
    self.resultTable.dataSource = self;
    self.resultTable.delegate = self;
    self.resultTable.rowHeight = CELL_H;
    self.resultTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.resultTable];
    [self.view bringSubviewToFront:self.searchBar];
    [self.view bringSubviewToFront:self.segmentBar];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"model requests suceeded" object:nil];
    [self removeObserver:self forKeyPath:@"selectedIndex"];
}

#pragma mark - 创建子控制器
- (void)addSubControllers {
    FYHAcademyGroupController *academy = [[FYHAcademyGroupController alloc] init];
    FYHHometownGroupController *hometown = [[FYHHometownGroupController alloc] init];
    FYHOnlineActivitiesController *activities = [[FYHOnlineActivitiesController alloc] initWithStyle:UITableViewStylePlain];
    
    self.academyTable = academy.tableView;
    self.hometownTable = hometown.tableView;
    self.academyTable.delegate = self;
    self.hometownTable.delegate = self;
    
    academy.title = @"学院群";
    hometown.title = @"老乡群";
    activities.title = @"线上活动";
    
    self.controllers = @[academy, hometown, activities];
}

- (void)buildSubViews {
    for (int i = 0; i < self.controllers.count; i++) {
        [self addChildViewController:self.controllers[i]];
        self.controllers[i].view.frame = CGRectMake(i * MAIN_SCREEN_W, SEGMENTBAR_H + CELL_H + 15, MAIN_SCREEN_W, [UIScreen mainScreen].bounds.size.height - TOTAL_TOP_HEIGHT - SEGMENTBAR_H - CELL_H - 15);
        [self.controllersScrollView addSubview:self.controllers[i].view];
    }
    self.controllers[2].view.frame = CGRectMake(2 * MAIN_SCREEN_W, SEGMENTBAR_H, MAIN_SCREEN_W, [UIScreen mainScreen].bounds.size.height - TOTAL_TOP_HEIGHT - SEGMENTBAR_H);
    
//    self.controllersScrollView.contentSize = CGSizeMake(MAIN_SCREEN_W * self.controllers.count, 0);

    // 禁止横向滚动
    self.controllersScrollView.contentSize = CGSizeMake(0, 0);

    
    self.title = self.childViewControllers[self.selectedIndex].title;
}

#pragma mark - 请求数据
// 请求模型数据
- (void)requestsAcademyWithURL:(NSString *)url andModelName:(NSString *)modelName andPostData:(NSString *)data {
    
    NSLog(@"%@", data);
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    NSDictionary *parameters;
    if ([modelName isEqualToString:@"academy"]) {
        parameters = @{@"college": data};
    } else {
        parameters = @{@"province": data};
    }
    
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:url method:HttpRequestPost parameters:parameters prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"text"]) {
            AcademyOrHometownItem *academy = [[AcademyOrHometownItem alloc] initWithDict:dict];
            [tempArray addObject:academy];
        }
        if (self.isKeyboardVisible) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"model requests suceeded" object:nil userInfo:@{@"modelName": modelName, @"modelArray": tempArray}];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"model requests failed" object:nil];
    }];
    
//    [manager POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSMutableArray *tempArray = [NSMutableArray array];
//        for (NSDictionary *dict in responseObject[@"text"]) {
//            AcademyOrHometownItem *academy = [[AcademyOrHometownItem alloc] initWithDict:dict];
//            [tempArray addObject:academy];
//        }
//        if (self.isKeyboardVisible) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"model requests suceeded" object:nil userInfo:@{@"modelName": modelName, @"modelArray": tempArray}];
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"model requests failed" object:nil];
//    }];
}

// 通知回调(设置模型数据，展示结果表格)
- (void)academyRequetsSucceeded:(NSNotification *)notification {
    if ([notification.userInfo[@"modelArray"] count] == 0) {
        if (!self.warning) {
            UILabel *warning = [[UILabel alloc] init];
            warning.text = @"暂时没有你想要的群号";
            warning.font = [UIFont systemFontOfSize:15];
            warning.textAlignment = NSTextAlignmentRight;
            warning.textColor = [UIColor colorWithRed:255/255.0 green:97/255.0 blue:88/255.0 alpha:1];
            warning.backgroundColor = [UIColor colorWithRed:251/255.0 green:253/255.0 blue:255/255.0 alpha:1];
            [self.searchBar addSubview:warning];
            [warning mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.searchBar);
                make.right.equalTo(self.searchBar.textField.mas_right).offset(-20);
            }];
            self.warning = warning;
        } else {
            self.warning.hidden = NO;
        }
        return;
    } else {
        if (self.warning && self.warning.hidden == NO) {
            self.warning.hidden = YES;
        }
        self.resultTable.resultArray = notification.userInfo[@"modelArray"];
        if ([notification.userInfo[@"modelName"] isEqualToString:@"academy"]) {
            self.academyArray = notification.userInfo[@"modelArray"];
        } else if ([notification.userInfo[@"modelName"] isEqualToString:@"hometown"]) {
            self.hometownArray = notification.userInfo[@"modelArray"];
        }
        
        [self.resultTable reloadData];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.resultTable.frame = CGRectMake(15, SEGMENTBAR_H + CELL_H + 15, MAIN_SCREEN_W - 30, MAIN_SCREEN_H - TOTAL_TOP_HEIGHT - SEGMENTBAR_H - 30 - CELL_H);
        }];
    }
}

// 收起结果表格
- (void)foldResultTable {
    [UIView animateWithDuration:0.3 animations:^{
        self.resultTable.frame = CGRectMake(15, SEGMENTBAR_H + CELL_H + 15, MAIN_SCREEN_W - 30, 0);
    }];
}

- (void)segmentButtonClick:(UIButton *)button {
    if (button.tag != self.selectedIndex) {
        [self foldResultTable];
        [self.view endEditing:YES];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.controllersScrollView.contentOffset = CGPointMake(MAIN_SCREEN_W * button.tag, self.controllersScrollView.contentOffset.y);
        
        if (button.tag) {
            self.searchBar.frame = CGRectMake(-(self.controllersScrollView.contentOffset.x - MAIN_SCREEN_W - 15), self.searchBar.frame.origin.y, self.searchBar.frame.size.width, self.searchBar.frame.size.height);
        } else {
            self.searchBar.frame = CGRectMake(15, self.searchBar.frame.origin.y, self.searchBar.frame.size.width, self.searchBar.frame.size.height);
        }
        
        if (self.searchBar.mj_x <= -360) {
            self.searchBar.alpha = 0;
        } else {
            self.searchBar.alpha = 1;
        }
        
        [self moveSlider];
    }];
    
    self.selectedIndex = button.tag;
}

#pragma mark - scrollView代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    
    [self.view endEditing:YES];
    
    if (scrollView == self.resultTable) {
        if (scrollView.contentOffset.y < 0) {
            scrollView.contentOffset = CGPointMake(0, 0);
        }
    }
    
    if (scrollView == self.academyTable || scrollView == self.hometownTable) {
        [self foldResultTable];
    }
}

#pragma mark - searchBar
- (void)textChanged:(NSNotification *)notifiction {
    UITextField *textField = [notifiction object];
    if (textField.text.length > 0) {
        if (self.selectedIndex == 0) {
            // http://129.28.185.138:9025/zsqy/select/college
            [self
             requestsAcademyWithURL:SEARCHACADEMYAPI andModelName:@"academy" andPostData:textField.text];
        } else if (self.selectedIndex == 1) {
            [self requestsAcademyWithURL:SEARCHHOMETOWNAPI andModelName:@"hometown" andPostData:textField.text];
        }
    } else if (textField.text.length == 0) {
        if (self.warning && self.warning.hidden == NO) {
            self.warning.hidden = YES;
        }
        //        if (self.searchBar.textField.text.length - 1 == 0) {
        //            [self foldResultTable];
        //            self.warning.hidden = YES;
        //        }
    }
}



#pragma mark - tableView数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.selectedIndex == 0) {
        return self.academyArray.count;
    } else if (self.selectedIndex == 1) {
        return self.hometownArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"search result";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor colorWithRed:249/255.0 green:253/255.0 blue:255/255.0 alpha:1];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor colorWithRed:220/255.0 green:231/255.0 blue:252/255.0 alpha:1].CGColor;
    cell.textLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    if (self.selectedIndex == 0) {
        cell.textLabel.text = self.academyArray[indexPath.row].name;
    } else if (self.selectedIndex == 1) {
        cell.textLabel.text = self.hometownArray[indexPath.row].name;
    }
    return cell;
}

#pragma mark - tableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.resultTable) {
        self.selectedItem = ((FYHSearchResult *)tableView).resultArray[indexPath.row];
        
        if (self.selectedIndex == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"selected an academy" object:nil userInfo:@{@"model": self.selectedItem}];
        } else if (self.selectedIndex == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"selected a hometown" object:nil userInfo:@{@"model": self.selectedItem}];
        }
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.view endEditing:YES];
        [self foldResultTable];
        
    } else if (tableView == self.academyTable || tableView == self.hometownTable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selected a cell" object:nil userInfo:@{@"model": ((FYHAcademyGroupController *)self.childViewControllers[self.selectedIndex]).allModelArray[indexPath.row]}];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([change[NSKeyValueChangeNewKey] integerValue] == 0) {
        self.searchBar.textField.placeholder = @" 找不到学院群？试试搜索";
    } else if ([change[NSKeyValueChangeNewKey] integerValue] == 1) {
        self.searchBar.textField.placeholder = @" 找不到老乡群？试试搜索";
    }
    [self.segmentButtons[[change[NSKeyValueChangeOldKey] integerValue]] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.segmentButtons[[change[NSKeyValueChangeNewKey] integerValue]] setTitleColor:[UIColor colorWithRed:70/255.0 green:114/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
}

#pragma mark - 选择了学院群/老乡群
- (void)selectedACell:(NSNotification *)notification {
    AcademyOrHometownItem *model = notification.userInfo[@"model"];
    if (!self.willCopyWindow) {
        WillCopy *window = [[WillCopy alloc] init];
        [self.view addSubview:window];
        
        self.willCopyWindow = window;
        window.hidden = YES;
        [self.willCopyWindow.cancel addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.willCopyWindow.certain addTarget:self action:@selector(certainClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    self.willCopyWindow.academy.text = model.name;
    self.willCopyWindow.groupNumber.text = [NSString stringWithFormat:@"QQ群：%@", model.data];
    
    self.willCopyWindow.hidden = NO;
    self.willCopyWindow.alpha = 0;
    
    [UIView animateWithDuration:0.15 animations:^{
        self.willCopyWindow.alpha = 1;
    }];
}

- (void)cancelClicked {
    [UIView animateWithDuration:0.15 animations:^{
        self.willCopyWindow.alpha = 0;
    } completion:^(BOOL finished) {
        self.willCopyWindow.hidden = YES;
    }];
}

- (void)certainClicked {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [self.willCopyWindow.groupNumber.text substringFromIndex:4];
    
    SuccessWindow *successWindow = [[SuccessWindow alloc] init];
    [self.willCopyWindow addSubview:successWindow];
    [self performSelector:@selector(dismissSuccessWindow:) withObject:successWindow afterDelay:1.5];
}

- (void)dismissSuccessWindow:(SuccessWindow *)successWindow {
    if (!successWindow.hidden) {
        [UIView animateWithDuration:0.15 animations:^{
            successWindow.alpha = 0;
            self.willCopyWindow.alpha = 0;
        } completion:^(BOOL finished) {
            successWindow.hidden = YES;
            self.willCopyWindow.hidden = YES;
        }];
    }
}

#pragma mark - 点击了立即加入活动
-(void)joinActivity:(NSNotification *)notification {
    ActivityItem *model = notification.userInfo[@"model"];
    ActicytyQRCodeView *QRCodeView = [[ActicytyQRCodeView alloc] initWithImageURL:model.photo andMessage:model.message];
    QRCodeView.alpha = 0;
    [self.view addSubview:QRCodeView];
    [UIView animateWithDuration:0.15 animations:^{
        QRCodeView.alpha = 1;
    }];
}

#pragma mark - 改变键盘状态
- (void)changeKeyboardStatus:(NSNotification *)notification {
    if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
        self.isKeyboardVisible = NO;
    } else {
        self.isKeyboardVisible = YES;
    }
}


@end

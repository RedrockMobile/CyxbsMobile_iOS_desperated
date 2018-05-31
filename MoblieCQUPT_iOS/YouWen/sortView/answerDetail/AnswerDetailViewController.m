//
//  AnswerDetailViewController.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/4/3.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "AnswerDetailViewController.h"
#import "AnswerDetailTableHeaderView.h"
#import "AnswerDetailTableViewCell.h"
#import "AnswerCommentModel.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "YouWenAnswerDetailModel.h"
#import "YouWenBottomButtonView.h"
#import "LXDetailCommentView.h"
#import "MBCommunityHandle.h"
#import "YouWenAdoptFrame.h"

#define UPVOTEURL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Answer/praise"
#define CANCELUPVOTEURL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Answer/cancelPraise"
#define COMMENTANSWERURL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Answer/remark"
#define ADOPTANSWERURL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Answer/adopt"
@interface AnswerDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) AnswerDetailTableHeaderView *tableHeaderView;
@property (nonatomic) NSMutableArray<AnswerCommentModel *> *answerCommentModelArr;
@property (nonatomic, strong) YouWenBottomButtonView *bottomView;
@property (nonatomic, strong) LXDetailCommentView *detailCommentView;
@property (nonatomic, strong) UIWindow *window;
@property (strong, nonatomic) UIView *coverGrayView;
@property (strong, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) YouWenAdoptFrame *adoptFrame;
@end

@implementation AnswerDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self addBottomView];
    [self.view addSubview:self.tableview];
    self.tableHeaderView = [[AnswerDetailTableHeaderView alloc] initWithModel:self.model];
    self.tableHeaderView.titleLabel.text = self.questionTitle;
    if ([_isSelf isEqualToString:@"0"]) {
        self.tableHeaderView.adoptBtn.hidden = YES;
    } else {
        [self.tableHeaderView.adoptBtn addTarget:self action:@selector(adopt) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.tableview.tableHeaderView layoutIfNeeded];
    self.tableview.tableHeaderView = self.tableHeaderView;
    
    self.answerCommentModelArr = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    self.window = [UIApplication sharedApplication].keyWindow;
}

#pragma mark - bottomButtonView
- (YouWenBottomButtonView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[YouWenBottomButtonView alloc] init];
        //是自己的问题
        if ([self.isSelf integerValue]) {
            _bottomView.label1.text = @"点赞";
            _bottomView.label2.text = @"评论";
            [_bottomView.btn1 addTarget:self action:@selector(upvote) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView.btn2 addTarget:self action:@selector(addComment) forControlEvents:UIControlEventTouchUpInside];
            if (self.is_upvote) {
                _bottomView.imageView1.image = [UIImage imageNamed:@"已点赞图标"];
            } else {
                _bottomView.imageView1.image = [UIImage imageNamed:@"未点赞图标"];
            }
            
            
        } else {
            _bottomView.label1.text = @"点赞";
            _bottomView.label2.text = @"评论";
            [_bottomView.btn1 addTarget:self action:@selector(upvote) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView.btn2 addTarget:self action:@selector(addComment) forControlEvents:UIControlEventTouchUpInside];
            if (self.is_upvote) {
                _bottomView.imageView1.image = [UIImage imageNamed:@"已点赞图标"];
            } else {
                _bottomView.imageView1.image = [UIImage imageNamed:@"未点赞图标"];
            }
            
        }
    }
    
    return _bottomView;
}


//采纳答案
- (void)adopt {
    //弹出提示框
    self.adoptFrame = [YouWenAdoptFrame init];
    [self.adoptFrame show];
    [self.adoptFrame.confirmBtn addTarget:self action:@selector(confirmAdoptAnswer) forControlEvents:UIControlEventTouchUpInside];
    [self.adoptFrame.cancelBtn addTarget:self action:@selector(cancelAdoptAnswer) forControlEvents:UIControlEventTouchUpInside];
}


- (void)confirmAdoptAnswer {
    NSDictionary *parameter = @{
                               @"stuNum":[UserDefaultTool getStuNum],
                               @"idNum":[UserDefaultTool getIdNum],
                               @"answer_id":self.answer_id,
                               @"question_id":self.question_id
                               };
    
    _hud.labelText = @"...";
    [NetWork NetRequestPOSTWithRequestURL:ADOPTANSWERURL WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = @"采纳成功";
        [self.hud hide:YES afterDelay:1.5];
        
        [self.adoptFrame free];
    } WithFailureBlock:^{
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = @"网络错误";
        [self.hud hide:YES afterDelay:1.5];
    }];
    
}


- (void)cancelAdoptAnswer {
    [self.adoptFrame free];
}


- (void)addBottomView {
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@(45/700.0*ScreenHeight));
    }];
}

- (void)upvote {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString string];
    if (self.is_upvote) {
        url = CANCELUPVOTEURL;
    } else {
        url = UPVOTEURL;
    }
    NSDictionary *parameters = @{
                                 @"stuNum":[UserDefaultTool getStuNum],
                                 @"idNum":[UserDefaultTool getIdNum],
                                 @"answer_id":self.answer_id
                                 };
    
    [manager POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
       //更改点赞图片
        if (self.is_upvote) {
            self.bottomView.imageView1.image = [UIImage imageNamed:@"未点赞图标"];
        } else {
            self.bottomView.imageView1.image = [UIImage imageNamed:@"已点赞图标"];
        }
        self.is_upvote = !self.is_upvote;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}


- (UIView *)coverGrayView {
    if (!_coverGrayView) {
        _coverGrayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _coverGrayView.backgroundColor = [UIColor clearColor];
    }
    
    return _coverGrayView;
}


- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    [UIView beginAnimations:@"riseAnimate" context:nil];
    [UIView setAnimationDuration:0.275];
    self.detailCommentView.frame = CGRectMake(0, SCREENHEIGHT - height - self.detailCommentView.frame.size.height, SCREENWIDTH, self.detailCommentView.frame.size.height);
    [UIView commitAnimations];
}

//点击评论btn弹出的框框
- (UIView *)detailCommentView {
    if (!_detailCommentView) {
        _detailCommentView = [[LXDetailCommentView alloc] init];
        _detailCommentView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 0);
        [_detailCommentView.cancelBtn addTarget:self action:@selector(tapCancelBtn) forControlEvents:UIControlEventTouchDown];
        [_detailCommentView.sendBtn addTarget:self action:@selector(tapSendBtn) forControlEvents:UIControlEventTouchDown];
        
        _detailCommentView.commentTextView.delegate = self;
    }
    
    return _detailCommentView;
}

- (void)tapCancelBtn {
    [UIView beginAnimations:@"downAnimate" context:nil];
    [UIView setAnimationDuration:0.1];
    self.detailCommentView.frame = CGRectMake(0, SCREENHEIGHT, SCREENHEIGHT, 0);
    self.coverGrayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView commitAnimations];
    [self.detailCommentView.commentTextView resignFirstResponder];
    [self.coverGrayView removeFromSuperview];
}

- (void)tapSendBtn {
    if ([self.detailCommentView.placeholder.text isEqualToString:@"说点什么吧..."]) {
        [self upLoadCommentWithContent:self.detailCommentView.commentTextView.text];
    }else {
        NSString *content = [NSString stringWithFormat:@"%@%@",self.detailCommentView.placeholder.text,self.detailCommentView.commentTextView.text];
        [self upLoadCommentWithContent:content];
    }
    
    [self tapCancelBtn];
}



- (void)addComment {
    NSString *stuNum = [UserDefaultTool getStuNum];
    
    if (stuNum) {
        [self.window addSubview:self.coverGrayView];
        [self.coverGrayView addSubview:self.detailCommentView];
        self.detailCommentView.backgroundColor = [UIColor whiteColor];
        self.detailCommentView.placeholder.text = @"说点什么吧...";
        
        [UIView animateWithDuration:0.25 animations:^{
            self.coverGrayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
            self.detailCommentView.frame = CGRectMake(0, SCREENHEIGHT - (271/667.0) * SCREENHEIGHT, SCREENWIDTH, (271/667.0) * SCREENHEIGHT);
        }];
    } else {
        [MBCommunityHandle noLogin:self handler:^(BOOL success) {
            [self addComment];
        }];
    }
}



#pragma mark - 评论上传

- (void)upLoadCommentWithContent:(NSString *)content {
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    NSDictionary *parameter = @{@"stuNum":stuNum,
                                @"idNum":idNum,
                                @"answer_id":self.answer_id,
                                @"content":content};
    NSLog(@"发送评论");
    _hud.labelText = @"正在发送评论...";
    [NetWork NetRequestPOSTWithRequestURL:COMMENTANSWERURL WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeText;
        if ([content isEqualToString:@""]) {
            self.hud.labelText = @"请输入评论";
        } else {
            self.hud.labelText = @"评论成功";
        }
        [self.hud hide:YES afterDelay:1.5];
        //刷新界面
        [self.tableview reloadData];
        self.detailCommentView.commentTextView.text = @"";
    } WithFailureBlock:^{
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = @"网络错误";
        [self.hud hide:YES afterDelay:1.5];
    }];
}



#pragma mark - textView delegate methods
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([self.detailCommentView.commentTextView.text isEqualToString:@""]) {
        self.detailCommentView.placeholder.hidden = NO;
    } else {
        self.detailCommentView.placeholder.hidden = YES;
    }
}


- (void)getData {
    NSString *urlStr = @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Answer/getRemarkList";
    NSDictionary *parameters = @{
                                 @"stuNum":@"2016214345",
                                 @"idNum":@"257654",
                                 @"answer_id":self.answer_id
                                 };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        for (NSDictionary *dic in responseObject[@"data"]) {
            AnswerCommentModel *model = [[AnswerCommentModel alloc] initWithDic:dic];
            [self.answerCommentModelArr addObject:model];
        }
        
        if (self.answerCommentModelArr.count == 0) {
            UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200)];
            label.text = @"快来成为第一个帮助者吧～";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14.0];
            label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.8];
            [footerView addSubview:label];
            _tableview.tableFooterView = footerView;
        }
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - tableview
- (UITableView *)tableview {
    if (!_tableview) {
        [self.bottomView layoutIfNeeded];
        CGRect bottomViewRect = self.bottomView.frame;
        CGRect tableViewRect = CGRectMake(self.view.origin.x, self.view.origin.y, self.view.size.width, self.view.size.height - bottomViewRect.size.height);
        _tableview = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.showsVerticalScrollIndicator = NO;
//        _tableview.estimatedRowHeight = 100;
//        _tableview.estimatedSectionHeaderHeight = 100;
//        _tableview.rowHeight = UITableViewAutomaticDimension;
//        _tableview.sectionHeaderHeight = UITableViewAutomaticDimension;
//        _tableview.tableHeaderView.height = UITableViewAutomaticDimension;
    }
    
    return _tableview;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identify = @"AnswerDetailTableViewCell";
    AnswerDetailTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        cell = [[AnswerDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        if (self.answerCommentModelArr.count > 0) {
            NSInteger row  = indexPath.row;
            cell.nickname.text = self.answerCommentModelArr[row].nickname;
            cell.avatarImageView.contentMode = UIViewContentModeScaleToFill;
            [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.answerCommentModelArr[row].avatarUrlStr]];
            cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2.0;
            cell.imageView.clipsToBounds = YES;
            cell.dateLabel.text = self.answerCommentModelArr[row].date;
            cell.contentLabel.text = self.answerCommentModelArr[row].content;
            
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    ;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 400;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.answerCommentModelArr.count;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 1) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 46)];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 17, 100, 14)];
//        [view addSubview:label];
//        if (self.answerCommentModelArr.count > 0) {
//            label.text = [NSString stringWithFormat:@"评论%ld", self.answerCommentModelArr.count];
//        }
//        label.font = [UIFont systemFontOfSize:13];
//        label.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
//        return view;
//    }
//
//    return 0;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

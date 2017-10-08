//
//  MBCommuityDetailsViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/21.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommuityDetailsViewController.h"
#import "MBCommunityCellTableViewCell.h"
#import "MBCommunityTableView.h"
#import "MBCommentCell.h"
#import "MBReleaseViewController.h"
//#import "MBReplyView.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "MyMessagesViewController.h"
#import "MBCommunityHandle.h"
#import <MJRefresh.h>

#import "LXReplyView.h"
#import "LXDetailCommentView.h"
#import "MBCommunityHandle.h"
/*
 *
 *          ┌─┐       ┌─┐
 *       ┌──┘ ┴───────┘ ┴──┐
 *       │                 │
 *       │       ───       │
 *       │  ─┬┘       └┬─  │
 *       │                 │
 *       │       ─┴─       │
 *       │                 │
 *       └───┐         ┌───┘
 *           │         │
 *           │         │
 *           │         │
 *           │         └──────────────┐
 *           │                        │
 *           │                        ├─┐
 *           │                        ┌─┘
 *           │                        │
 *           └─┐  ┐  ┌───────┬──┐  ┌──┘
 *             │ ─┤ ─┤       │ ─┤ ─┤
 *             └──┴──┘       └──┴──┘
 *                 神兽保佑
 *                 代码无BUG!
 */

@interface MBCommuityDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,MBCommentEventDelegate>

@property (strong, nonatomic) MBCommunityTableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) UIView *headView;

@property (strong, nonatomic) UILabel *headLabel;

@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@property (assign, nonatomic) BOOL isLoadedComment;

//@property (strong, nonatomic) MBReplyView *replyView;
@property (strong, nonatomic) LXReplyView *replyView;

@property (strong, nonatomic) MBProgressHUD *hud;

@property (strong, nonatomic) LXDetailCommentView *detailCommentView;

@property CGRect replyViewOriginalRect;

@property (strong, nonatomic) MBCommunityHandle *handle;

//最上面的遮盖阴影
@property (strong, nonatomic) UIView *coverGrayView;

@property (strong, nonatomic) UIWindow *window;

@end

@implementation MBCommuityDetailsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _isLoadedComment = NO;
    [self.view addSubview:self.tableView];
    /*格格的
    [self.view addSubview:self.replyView];
    */
    [self.view addSubview:self.replyView];
    [self.view addSubview:self.detailCommentView];
    
    _coverGrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0)];
    _coverGrayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
     [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(keyboardWillShow:)
        name:UIKeyboardWillShowNotification
        object:nil];
    
    self.window = [UIApplication sharedApplication].keyWindow;
//    [self.view addSubview:self.coverGrayView];
    // Do any additional setup after loading the view from its nib.
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    /*
    _replyView.cancel.transform = CGAffineTransformMakeRotation(0);
    [UIView animateWithDuration:0.3 animations:^{
        _replyView.frame = CGRectMake(0, ScreenHeight - height - self.replyView.frame.size.height, self.replyView.frame.size.width, self.replyView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
     */    
    [UIView beginAnimations:@"riseAnimate" context:nil];
    [UIView setAnimationDuration:0.25];
    self.detailCommentView.frame = CGRectMake(0, SCREENHEIGHT - height - self.detailCommentView.frame.size.height, SCREENWIDTH, self.detailCommentView.frame.size.height);
    self.coverGrayView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - height - self.detailCommentView.frame.size.height);
    [UIView commitAnimations];
}

//- (UIView *)coverGrayView {
//    if (!_coverGrayView) {
//        _coverGrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0)];
//        _coverGrayView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
//    }
//    
//    return _coverGrayView;
//}

- (MBCommunityTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MBCommunityTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-59) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadNetWorkData];
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
        }];
    }
    return _tableView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return self.headView;
    }else {
        return nil;
    }
    
}

//评论的heedView
- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        _headView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 40)];
        back.backgroundColor = [UIColor whiteColor];
        
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
        headLabel.text = [NSString stringWithFormat:@"评论 %@",self.viewModel.model.remark_num];
        headLabel.font = [UIFont systemFontOfSize:13];
        headLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [headLabel sizeToFit];
        headLabel.center = CGPointMake(10+headLabel.frame.size.width/2, back.frame.size.height/2);
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 39, ScreenWidth, 1)];
        line.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        
        _headLabel = headLabel;
        [back addSubview:headLabel];
        [back addSubview:line];
        [_headView addSubview:back];
    }
    
    return _headView;
}

/*
//评论框
- (MBReplyView *)replyView {
    if (!_replyView) {
        _replyView = [[MBReplyView alloc]init];
        _replyView.textView.returnKeyType = UIReturnKeySend;
        _replyView.textView.delegate = self;
    }
    
    return _replyView;
}
 */

//新版评论框
- (LXReplyView *)replyView {
    if (!_replyView) {
        _replyView = [[LXReplyView alloc] init];
        [_replyView.commentBtn addTarget:self action:@selector(tapCommentBtn) forControlEvents:UIControlEventTouchDown];
        [_replyView.upvoteBtn addTarget:self action:@selector(tapUpvoteBtn) forControlEvents:UIControlEventTouchDown];
        _replyView.numberOfUpvoteLabel.text = [self.viewModel.model.like_num stringValue];
        if (self.viewModel.model.is_my_like == YES) {
            _replyView.upvoteImageView.image = [UIImage imageNamed:@"icon_upvote_inside_selected"];
        } else {
            _replyView.upvoteImageView.image = [UIImage imageNamed:@"icon_upvote_inside_notselect"];
        }
    }
    
    return _replyView;
}

- (void)tapCommentBtn {
    if (self.detailCommentView.hidden == YES) {
        self.detailCommentView.hidden = NO;
    }
    self.detailCommentView.placeholder.text = @"说点什么吧...";
    NSString *stuNum = [UserDefaultTool getStuNum];
    
    if (stuNum) {
        
        [self.window addSubview:self.coverGrayView];
        [UIView beginAnimations:@"apperAnimate" context:nil];
        [UIView setAnimationDuration:0.25];
        self.detailCommentView.frame = self.replyViewOriginalRect;
        self.coverGrayView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - self.replyViewOriginalRect.size.height);
        [UIView commitAnimations];
    } else {
        [MBCommunityHandle noLogin:self handler:^(BOOL success) {
            [self tapCommentBtn];
        }];
    }
}

//点击评论btn弹出的框框
- (UIView *)detailCommentView {
    if (!_detailCommentView) {
        _detailCommentView = [[LXDetailCommentView alloc] init];
        [self.view addSubview:_detailCommentView];
        [_detailCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.view.mas_right).offset(0);
            make.bottom.equalTo(self.view.mas_bottom).offset(0);
            make.height.mas_equalTo(@(271/667.0 * SCREENHEIGHT));
        }];
        [_detailCommentView.cancelBtn addTarget:self action:@selector(tapCancelBtn) forControlEvents:UIControlEventTouchDown];
        [_detailCommentView.sendBtn addTarget:self action:@selector(tapSendBtn) forControlEvents:UIControlEventTouchDown];
        
        _detailCommentView.commentTextView.delegate = self;
    }
    
    return _detailCommentView;
}

- (void)tapCancelBtn {
    [UIView beginAnimations:@"downAnimate" context:nil];
    [UIView setAnimationDuration:0.25];
    self.detailCommentView.frame = CGRectMake(0, SCREENHEIGHT, SCREENHEIGHT, 0);
    self.coverGrayView.frame = CGRectMake(0, 0, SCREENWIDTH, 0);
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

    [UIView beginAnimations:@"send" context:nil];
    [UIView setAnimationDuration:0.25];
    self.detailCommentView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 0);
    [UIView commitAnimations];
    
    [self tapCancelBtn];
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

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        if (self.dataArray.count == 0) {
            return 1;
        }else {
            return self.dataArray.count;
        }
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
            return self.viewModel.detailCellHeight;
    }else {
        if (self.dataArray.count == 0) {
            return 200;
        }else {
            return ((MBComment_ViewModel *)self.dataArray[indexPath.row]).cellHeight;
        }
    }
}


- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.00001;
    }else {
        return 50;
    }
    
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForFooterInSection:(NSInteger)section {
        return 0;
}

- (void)tapUpvoteBtn {
    
    self.replyView.numberOfUpvoteLabel.text = [MBCommunityHandle clickUpvoteBtn:self currentUpvoteNum:[self.replyView.numberOfUpvoteLabel.text intValue]  upvoteIsSelect:self.viewModel.model.is_my_like viewModel:self.viewModel];
    if (self.viewModel.model.is_my_like == NO) {
        self.replyView.upvoteImageView.image = [UIImage imageNamed:@"icon_upvote_inside_notselect"];
    } else {
        self.replyView.upvoteImageView.image = [UIImage imageNamed:@"icon_upvote_inside_selected"];
    }
}

- (UITableViewCell *)tableView:(MBCommunityTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _headLabel.text = [NSString stringWithFormat:@"评论 %lu",(unsigned long)self.dataArray.count];
    if (indexPath.section == 0) {
        MBCommunityCellTableViewCell *cell = [MBCommunityCellTableViewCell cellWithTableView:tableView type:MBCommunityViewCellDetail row:(int)indexPath.row];
        cell.subViewFrame = self.viewModel;
        /*点赞
        cell.clickSupportBtnBlock = [MBCommunityHandle clickSupportBtn:self];
         */
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        if (self.dataArray.count == 0) {
            static NSString *identify = @"commentViewCell";
            MBCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[MBCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                if (!_isLoadedComment) {
                    _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                    _indicatorView.frame = CGRectMake(0, 0, ScreenWidth, 200);
                    [cell.contentView addSubview:_indicatorView];
                    cell.contentView.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1];
                    [_indicatorView startAnimating];
                    [self loadNetWorkData];
                }
            }else {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
                label.text = @"快来发表你的评论吧";
                label.font = [UIFont systemFontOfSize:14];
                label.textColor = [UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1];
                label.textAlignment = NSTextAlignmentCenter;
                [cell.contentView addSubview:label];
            }
            return cell;
        }else {
            MBCommentCell *cell = [MBCommentCell cellWithTableView:tableView];
            cell.eventDelegate = self;
            cell.viewModel = self.dataArray[indexPath.row];
            [_headLabel sizeToFit];
            return cell;
        }
    }
}

- (void)commentEvenWhenClickHeadImageView:(MBCommentModel *)model {
    MyMessagesViewController *myMeVc = [[MyMessagesViewController alloc]initWithLoadType:MessagesViewLoadTypeOther withCommentModel:model];
    [self.navigationController pushViewController:myMeVc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        if (self.dataArray.count != 0) {
            MBComment_ViewModel *viewModel = self.dataArray[indexPath.row];
            /*
            [_replyView.textView becomeFirstResponder];
             */
            if (self.detailCommentView.hidden == YES) {
                self.detailCommentView.hidden = NO;
            }
            [UIView beginAnimations:@"apperAnimate" context:nil];
            [UIView setAnimationDuration:0.25];
            self.detailCommentView.frame = self.replyViewOriginalRect;
            [UIView commitAnimations];
            
            NSString *nickName = viewModel.model.nickname;
            NSString *placeholder = [NSString stringWithFormat:@"回复 %@ : ",nickName];
            /*
            _replyView.textView.placeholder = placeholder;
             */
            self.detailCommentView.placeholder.text = placeholder;
//            _replyView.cancel.transform = CGAffineTransformMakeRotation(0);
        }
    }
}

#pragma mark - 请求网络数据

- (void)loadNetWorkData {
    NSString *stuNum = [UserDefaultTool getStuNum]?:@"";
    NSString *idNum = [UserDefaultTool getIdNum]?:@"";
    NSNumber *article_id = self.viewModel.model.article_id;
    NSNumber *type_id = self.viewModel.model.type_id;
    NSDictionary *parameter = @{@"stuNum":stuNum,
                                @"idNum":idNum,
                                @"article_id":article_id,
                                @"type_id":type_id,
                                @"version":@1.0,
                                @"size":@(15)};
    [NetWork NetRequestPOSTWithRequestURL:GETREMARK_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        _isLoadedComment = YES;
        _dataArray = [NSMutableArray array];
        NSArray *array = returnValue[@"data"];
        for (NSDictionary *dic in returnValue[@"data"]) {
            MBCommentModel *commentModel = [[MBCommentModel alloc]initWithDictionary:dic];
            MBComment_ViewModel *comment_ViewModel = [[MBComment_ViewModel alloc]init];
            comment_ViewModel.model = commentModel;
            [_dataArray addObject:comment_ViewModel];
            self.viewModel.model.remark_num = @(self.dataArray.count);
        }
        [_indicatorView stopAnimating];
        [self.tableView reloadData];
        if ([array count]<15) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        [self.tableView.mj_header endRefreshing];
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = @"网络错误";
        [self.hud hide:YES afterDelay:1.5];
        
        NSLog(@"请求评论出错");
    }];
}


#pragma mark -

/*
 **键盘“发送” 卒
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        /*
        if ([_replyView.textView.placeholder isEqualToString:@"评论"]) {
            [self upLoadCommentWithContent:self.replyView.textView.text];
        }else {
            NSString *content = [NSString stringWithFormat:@"%@%@",_replyView.textView.placeholder,_replyView.textView.text];
            [self upLoadCommentWithContent:content];
        }
        [_replyView.textView resignFirstResponder];
        [UIView animateWithDuration:0.25 animations:^{
            _replyView.frame = CGRectMake(0, ScreenHeight - _replyView.frame.size.height, _replyView.frame.size.width, _replyView.frame.size.height);
        } completion:^(BOOL finished) {
        
        }];
         * /
        
        if ([self.detailCommentView.placeholder.text isEqualToString:@"说点什么吧..."]) {
            [self upLoadCommentWithContent:self.detailCommentView.commentTextView.text];
        }else {
            NSString *content = [NSString stringWithFormat:@"%@%@",self.detailCommentView.placeholder.text,self.detailCommentView.commentTextView.text];
            [self upLoadCommentWithContent:content];
        }
        [self.detailCommentView.commentTextView resignFirstResponder];
        [UIView animateWithDuration:0.25 animations:^{
            _replyView.frame = CGRectMake(0, ScreenHeight - _replyView.frame.size.height, _replyView.frame.size.width, _replyView.frame.size.height);
        } completion:^(BOOL finished) {
            self.detailCommentView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 0);
        }];
    }
    / *
    _replyView.cancel.transform = CGAffineTransformMakeRotation(M_PI);
    * /
    
    return YES;
}
*/

#pragma mark - 评论上传

- (void)upLoadCommentWithContent:(NSString *)content {
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    NSNumber *article_id = self.viewModel.model.article_id;
    NSNumber *type_id = self.viewModel.model.type_id;
    NSDictionary *parameter = @{@"stuNum":stuNum,
                                @"idNum":idNum,
                                @"article_id":article_id,
                                @"type_id":type_id,
                                @"content":content};
    NSLog(@"发送评论");
    _hud.labelText = @"正在发送评论...";
    [NetWork NetRequestPOSTWithRequestURL:POSTREMARK_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = @"评论成功";
        [self.hud hide:YES afterDelay:1.5];
        [self loadNetWorkData];
        /*
        self.replyView.textView.placeholder = @"评论";
        self.replyView.textView.text = @"";
         */
        self.detailCommentView.commentTextView.text = @"";
    } WithFailureBlock:^{
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = @"网络错误";
        [self.hud hide:YES afterDelay:1.5];
        /*
        [self.replyView.textView becomeFirstResponder];
         */
    }];
}

/*
 布局完后获取被约束控件的frame
 */
- (void)viewDidLayoutSubviews {
    self.replyViewOriginalRect = self.detailCommentView.frame;
    self.detailCommentView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 0);
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

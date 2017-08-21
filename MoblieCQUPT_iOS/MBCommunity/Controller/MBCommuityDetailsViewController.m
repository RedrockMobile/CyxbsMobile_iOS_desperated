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
#import "MBReplyView.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "MyMessagesViewController.h"
#import "MBCommunityHandle.h"
#import <MJRefresh.h>
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

@property (strong, nonatomic) MBReplyView *replyView;

@property (strong, nonatomic) MBProgressHUD *hud;


@end

@implementation MBCommuityDetailsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _isLoadedComment = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.replyView];
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(keyboardWillShow:)
        name:UIKeyboardWillShowNotification
        object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    _replyView.cancel.transform = CGAffineTransformMakeRotation(0);
    [UIView animateWithDuration:0.3 animations:^{
        _replyView.frame = CGRectMake(0, ScreenHeight - height - self.replyView.frame.size.height, self.replyView.frame.size.width, self.replyView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    NSLog(@"%d",height);
}

- (MBCommunityTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MBCommunityTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-50) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadNetWorkData];
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
        headLabel.font = [UIFont systemFontOfSize:16];
        headLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
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

//评论框
- (MBReplyView *)replyView {
    if (!_replyView) {
        _replyView = [[MBReplyView alloc]init];
        _replyView.textView.returnKeyType = UIReturnKeySend;
        _replyView.textView.delegate = self;
    }
    
    return _replyView;
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

- (UITableViewCell *)tableView:(MBCommunityTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _headLabel.text = [NSString stringWithFormat:@"评论 %lu",(unsigned long)self.dataArray.count];
    if (indexPath.section == 0) {
        MBCommunityCellTableViewCell *cell = [MBCommunityCellTableViewCell cellWithTableView:tableView type:MBCommunityViewCellDetail];
        cell.subViewFrame = self.viewModel;
        cell.clickSupportBtnBlock = [MBCommunityHandle clickSupportBtn:self];
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
            [_replyView.textView becomeFirstResponder];
            NSString *nickName = viewModel.model.nickname;
            NSString *placeholder = [NSString stringWithFormat:@"回复 %@ : ",nickName];
            _replyView.textView.placeholder = placeholder;
            _replyView.cancel.transform = CGAffineTransformMakeRotation(0);
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
                                @"version":@1.0};
    [NetWork NetRequestPOSTWithRequestURL:GETREMARK_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        _isLoadedComment = YES;
        _dataArray = [NSMutableArray array];
        for (NSDictionary *dic in returnValue[@"data"]) {
            MBCommentModel *commentModel = [[MBCommentModel alloc]initWithDictionary:dic];
            MBComment_ViewModel *comment_ViewModel = [[MBComment_ViewModel alloc]init];
            comment_ViewModel.model = commentModel;
            [_dataArray addObject:comment_ViewModel];
            self.viewModel.model.remark_num = @(self.dataArray.count);
        }
        [_indicatorView stopAnimating];
        [self.tableView reloadData];
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


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
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
    }
    _replyView.cancel.transform = CGAffineTransformMakeRotation(M_PI);
    return YES;
}

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
        self.replyView.textView.placeholder = @"评论";
        self.replyView.textView.text = @"";
    } WithFailureBlock:^{
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = @"网络错误";
        [self.hud hide:YES afterDelay:1.5];
        [self.replyView.textView becomeFirstResponder];
    }];
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

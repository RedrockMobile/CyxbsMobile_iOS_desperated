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

@property (copy, nonatomic) NSString *currenSelectCellOfRow;
@property (copy, nonatomic) NSString *currenSelectCellOfTableView;


@end

@implementation MBCommuityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isLoadedComment = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"详情";
    
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
        _tableView = [[MBCommunityTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -50) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
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
        NSInteger numOfComment = [self.viewModel.model.numOfComment integerValue];
        headLabel.text = [NSString stringWithFormat:@"评论 %ld",(long)numOfComment];
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
        if (self.viewModel.model.modelType == MBCommunityModelTypeListNews || ![self.viewModel.model.typeID isEqualToString:@"5"]) {
            CGRect contentSize = [self.viewModel.model.newsContent boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
            return self.viewModel.cellHeight + contentSize.size.height -35;
        }else {
            return self.viewModel.cellHeight;
        }
    }else {
        if (self.dataArray.count == 0) {
            return 200;
        }else {
            return ((MBComment_ViewModel *)self.dataArray[indexPath.row]).cellHeight;
        }
    }
}


- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    }else if (section == 0){
        return 0.00001;
    }else {
        return 10;
    }
    
}
- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForFooterInSection:(NSInteger)section {
        return 0;
}

- (UITableViewCell *)tableView:(MBCommunityTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MBCommunityCellTableViewCell *cell = [MBCommunityCellTableViewCell cellWithTableView:tableView];
        cell.subViewFrame = self.viewModel;
        if (self.viewModel.model.modelType == MBCommunityModelTypeListNews || ![self.viewModel.model.typeID isEqualToString:@"5"]) {
            CGRect contentSize = [self.viewModel.model.newsContent boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
            cell.contentLabel.text = self.viewModel.model.newsContent;
            cell.contentLabel.frame = (CGRect){{cell.contentLabel.frame.origin.x,cell.contentLabel.frame.origin.y},{ScreenWidth-20 ,contentSize.size.height}};
//            [cell.contentLabel sizeToFit];
            cell.supportBtn.frame = (CGRect){{cell.supportBtn.frame.origin.x,CGRectGetMaxY(cell.contentLabel.frame)},{cell.supportBtn.frame.size.width,cell.supportBtn.frame.size.height}};
            
            cell.supportImage.frame = (CGRect){{cell.supportImage.frame.origin.x,CGRectGetMaxY(cell.contentLabel.frame)},{cell.supportImage.frame.size.width,cell.supportImage.frame.size.height}};;
            
            cell.commentBtn.frame = (CGRect){{cell.commentBtn.frame.origin.x,CGRectGetMaxY(cell.contentLabel.frame)},{cell.commentBtn.frame.size.width,cell.commentBtn.frame.size.height}};;
            
            cell.commentImage.frame = (CGRect){{cell.commentImage.frame.origin.x,CGRectGetMaxY(cell.contentLabel.frame)},{cell.commentImage.frame.size.width,cell.commentImage.frame.size.height}};;
        }
        __weak typeof(self) weakSelf = self;
        cell.clickSupportBtnBlock = ^(UIButton *imageBtn,UIButton *labelBtn,MBCommunity_ViewModel *viewModel) {
            MBCommunityModel *model = viewModel.model;
            if (imageBtn.selected && labelBtn.selected) {
                NSInteger currentSupportNum = [labelBtn.titleLabel.text integerValue];
                NSInteger nowSupportNum;
                if (currentSupportNum == 0) {
                    nowSupportNum = 0;
                }else {
                    nowSupportNum = currentSupportNum - 1;
                }
                [labelBtn setTitle:[NSString stringWithFormat:@"%ld",(long)nowSupportNum] forState:UIControlStateNormal];
                model.numOfSupport = [NSString stringWithFormat:@"%ld",(long)nowSupportNum];
                [weakSelf uploadSupport:viewModel withType:1];
                imageBtn.selected = !imageBtn.selected;
                labelBtn.selected = !labelBtn.selected;
                NSLog(@"点击取消赞");
            }else {
                NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
                NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
                if (stuNum.length == 0 && idNum.length == 0) {
                    [weakSelf uploadSupport:viewModel withType:0];
                }else {
                    NSInteger currentSupportNum = [labelBtn.titleLabel.text integerValue];
                    [labelBtn setTitle:[NSString stringWithFormat:@"%ld",currentSupportNum+1] forState:UIControlStateNormal];
                    model.numOfSupport = [NSString stringWithFormat:@"%ld",currentSupportNum+1];
                    [weakSelf uploadSupport:viewModel withType:0];
                    imageBtn.selected = !imageBtn.selected;
                    labelBtn.selected = !labelBtn.selected;
                    weakSelf.currenSelectCellOfRow = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
                    weakSelf.currenSelectCellOfTableView = [NSString stringWithFormat:@"%ld",(long)tableView.tag];
                    NSLog(@"点击赞");
                }
            }
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        if (self.dataArray.count == 0) {
            static NSString *identify = @"commentViewCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
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
            MBComment_ViewModel *viewModel = self.dataArray[indexPath.row];
            cell.viewModel = viewModel;
            NSInteger numOfComment = [self.viewModel.model.numOfComment integerValue];
            _headLabel.text = [NSString stringWithFormat:@"评论 %ld",(long)numOfComment];
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
            NSString *nickName = viewModel.model.IDLabel;
            NSString *placeholder = [NSString stringWithFormat:@"回复 %@ : ",nickName];
            _replyView.textView.placeholder = placeholder;
            _replyView.cancel.transform = CGAffineTransformMakeRotation(0);
        }
    }
}

#pragma mark - 请求网络数据

- (void)loadNetWorkData {
     _dataArray = [NSMutableArray array];
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"]?:@"";
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"]?:@"";
    NSString *article_id = self.viewModel.model.articleID;
    NSString *type_id = self.viewModel.model.typeID;
    
    NSDictionary *parameter = @{@"stuNum":stuNum,
                                @"idNum":idNum,
                                @"article_id":article_id,
                                @"type_id":type_id};
    __weak typeof(self) weakSelf = self;
    [NetWork NetRequestPOSTWithRequestURL:GETREMARK_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSInteger numOfComment = ((NSArray *)returnValue[@"data"]).count;
        weakSelf.viewModel.model.numOfComment = [NSString stringWithFormat:@"%ld",(long)numOfComment];
        MBCommunityModel *newModel = weakSelf.viewModel.model;
        weakSelf.viewModel.model = newModel;
        _isLoadedComment = YES;
        for (NSDictionary *dic in returnValue[@"data"]) {
            MBCommentModel *commentModel = [[MBCommentModel alloc]initWithDictionary:dic];
            MBComment_ViewModel *comment_ViewModel = [[MBComment_ViewModel alloc]init];
            comment_ViewModel.model = commentModel;
            [_dataArray addObject:comment_ViewModel];
        }
        if (_dataArray.count == 0) {
            [_indicatorView stopAnimating];
            [weakSelf.tableView reloadData];
        }else {
            [_indicatorView stopAnimating];
            [weakSelf.tableView reloadData];
        }
    } WithFailureBlock:^{
        [_indicatorView stopAnimating];
        [self.tableView reloadData];
        _isLoadedComment = YES;
        NSLog(@"请求评论出错");
    }];
}


#pragma mark -


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if ([text isEqualToString:@"\n"]) {
        if ([_replyView.textView.placeholder isEqualToString:@"评论"]) {
            _replyView.cancel.transform = CGAffineTransformMakeRotation(M_PI);
            [self upLoadCommentWithContent:self.replyView.textView.text];
        }else {
            NSString *content = [NSString stringWithFormat:@"%@%@",_replyView.textView.placeholder,_replyView.textView.text];
            _replyView.cancel.transform = CGAffineTransformMakeRotation(M_PI);
            [self upLoadCommentWithContent:content];
        }
    }
    return YES;
}

#pragma mark - 评论上传

- (void)upLoadCommentWithContent:(NSString *)content {
    
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    NSString *article_id = self.viewModel.model.articleID;
    NSString *type_id = self.viewModel.model.typeID;
    
    
    if (stuNum.length == 0 && idNum.length == 0) {
        [_replyView.textView resignFirstResponder];
        [UIView animateWithDuration:0.25 animations:^{
            _replyView.frame = CGRectMake(0, ScreenHeight - _replyView.frame.size.height, _replyView.frame.size.width, _replyView.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"是否登录？" message:@"没有完善信息,还想发评论?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [weakSelf.replyView.textView becomeFirstResponder];
        }];
        
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            LoginViewController *LVC = [[LoginViewController alloc] init];
            LVC.loginSuccessHandler = ^(BOOL success) {
                if (success) {
                    [weakSelf upLoadCommentWithContent:content];
                }
            };
            [weakSelf presentViewController:LVC animated:YES completion:nil];
        }];
        
        [alertC addAction:cancel];
        [alertC addAction:confirm];
        
        [self presentViewController:alertC animated:YES completion:nil];
    }else {
        NSDictionary *parameter = @{@"stuNum":stuNum,
                                    @"idNum":idNum,
                                    @"article_id":article_id,
                                    @"type_id":type_id,
                                    @"content":content};
        
        NSLog(@"发送评论");
        [_replyView.textView resignFirstResponder];
        [UIView animateWithDuration:0.25 animations:^{
            _replyView.frame = CGRectMake(0, ScreenHeight - _replyView.frame.size.height, _replyView.frame.size.width, _replyView.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.labelText = @"正在发送评论...";
        
        
        __weak typeof(self) weakSelf = self;
        [NetWork NetRequestPOSTWithRequestURL:POSTREMARK_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
            weakSelf.hud.mode = MBProgressHUDModeText;
            weakSelf.hud.labelText = @"评论成功";
            [weakSelf.hud hide:YES afterDelay:1.5];
            MBCommunity_ViewModel *viewModel_new = weakSelf.viewModel;
            weakSelf.viewModel.model.numOfComment = [NSString stringWithFormat:@"%ld",[self.viewModel.model.numOfComment integerValue]+1];
            viewModel_new.model = weakSelf.viewModel.model;
            weakSelf.viewModel = viewModel_new;
            [weakSelf loadNetWorkData];
            weakSelf.replyView.textView.placeholder = @"评论";
            weakSelf.replyView.textView.text = @"";
        } WithFailureBlock:^{
            weakSelf.hud.mode = MBProgressHUDModeText;
            weakSelf.hud.labelText = @"网络错误";
            [weakSelf.hud hide:YES afterDelay:1.5];
            [weakSelf.replyView.textView becomeFirstResponder];
        }];

    }
    
}

#pragma mark -

#pragma mark - 上传点赞

- (void)uploadSupport:(MBCommunity_ViewModel *)viewModel withType:(NSInteger)type {
    //type == 0 赞 , type == 1 取消赞
    MBCommunityModel *model = viewModel.model;
    NSString *url;
    if (type == 0) {
        url = ADDSUPPORT_API;
    }else if (type == 1) {
        url = CANCELSUPPOTRT_API;
    }
    
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    NSString *idNum = [LoginEntry getByUserdefaultWithKey:@"idNum"];
    NSString *article_id = model.articleID;
    NSString *type_id = model.typeID;
    
    if (stuNum.length == 0 && idNum.length == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"是否登录？" message:@"没有完善信息呢,肯定不让你点赞呀" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:nil];
        
        __weak typeof(self) weakSelf = self;
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            LoginViewController *LVC = [[LoginViewController alloc] init];
            LVC.loginSuccessHandler = ^(BOOL success) {
                if (success) {
                    [weakSelf uploadSupport:viewModel withType:type];
                }
            };
            [weakSelf presentViewController:LVC animated:YES completion:nil];
        }];
        
        [alertC addAction:cancel];
        [alertC addAction:confirm];
        
        [self presentViewController:alertC animated:YES completion:nil];
    }else {
        NSDictionary *parameter = @{@"stuNum":stuNum,
                                    @"idNum":idNum,
                                    @"article_id":article_id,
                                    @"type_id":type_id};
        
        __block MBCommunityModel *modelBlock = model;
        __block MBCommunity_ViewModel *viewModelBlock = viewModel;
        __weak typeof(self) weakSelf = self;
        
        [NetWork NetRequestPOSTWithRequestURL:url WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
            modelBlock.isMyLike = [NSString stringWithFormat:@"%d",![modelBlock.isMyLike boolValue]];
            viewModelBlock.model = modelBlock;
            NSInteger row = [weakSelf.currenSelectCellOfRow integerValue];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:row];
            MBCommunityTableView *tableView = weakSelf.tableView;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            NSLog(@"请求 %@",modelBlock.isMyLike);
        } WithFailureBlock:^{
            NSLog(@"请求赞出错");
        }];

    }
    
}

#pragma mark -

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

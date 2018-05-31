//
//  DetailViewController.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/3/7.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenDetailViewController.h"
#import "YouWenDetailHeadView.h"
#import "YouWenDetailCell.h"
#import "YouWenQuestionDetailModel.h"
#import "YouWenAnswerDetailModel.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "AnswerDetailViewController.h"
#import "YouWenBottomButtonView.h"
#import <Masonry.h>
#import "YouWenWriteAnswerViewController.h"
#import "TransparentView.h"
#import "ReportViewController.h"
#import "YouWenAdoptFrame.h"
#import "commitSuccessFrameView.h"

#define UPVOTEURL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Answer/praise"
#define CANCELUPVOTEURL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Answer/cancelPraise"
#define QUESTIONSINFO @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Question/getDetailedInfo"
#define ADOPTANSWERURL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Answer/adopt"

@interface YouWenDetailViewController () <UITableViewDelegate, UITableViewDataSource ,getNewView, YouWenWriteAnswerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) YouWenQuestionDetailModel *detailQuestionModel;
@property (nonatomic, strong) NSMutableArray <YouWenAnswerDetailModel *> *answerModelArr;
@property (nonatomic, strong) YouWenDetailHeadView *headView;
@property (nonatomic, strong) YouWenBottomButtonView * bottomView;
@property (nonatomic, strong) YouWenAdoptFrame *adoptFrame;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) NSString *tempAnswerID;
@property (nonatomic, strong) commitSuccessFrameView *commitSuccessFrame;

@end


@implementation YouWenDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self addBottomView];
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"andMore"] style:UIBarButtonItemStylePlain target:self action:@selector(moreInfor)];
}

- (YouWenBottomButtonView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[YouWenBottomButtonView alloc] init];
        if ([self.detailQuestionModel.isSelf integerValue]) {
            _bottomView.label1.text = @"加价";
            _bottomView.label2.text = @"取消提问";
            [_bottomView.btn1 addTarget:self action:@selector(addReward) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView.btn2 addTarget:self action:@selector(cancelQuestion) forControlEvents:UIControlEventTouchUpInside];
        } else {
            _bottomView.label1.text = @"忽略";
            _bottomView.label2.text = @"帮助";
            [_bottomView.btn1 addTarget:self action:@selector(ignore) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView.btn2 addTarget:self action:@selector(reply) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return _bottomView;
}


- (void)addBottomView {
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@(45/720.0*ScreenHeight));
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        [self.bottomView layoutIfNeeded];
        CGRect bottomViewRect = self.bottomView.frame;
        CGRect tableViewRect = CGRectMake(self.view.origin.x, self.view.origin.y, self.view.size.width, self.view.size.height - bottomViewRect.size.height);
        _tableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;

        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

#pragma mark - tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"YouWenDetailCell";
    
//    YouWenDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
//
//        cell = [[YouWenDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    YouWenDetailCell *cell;
    if (self.answerModelArr.count > 0) {
        NSInteger index = indexPath.row;
        
        //有图的cell
        if (self.answerModelArr[index].photoUrlArr.count > 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"YouWenDetailCellFirst"];
            
            if (!cell) {
                cell = [[YouWenDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YouWenDetailCellFirst"];
            }
            
            NSArray *picArr = [NSArray arrayWithObjects:cell.imageView1, cell.imageView2, nil];
            for (int i = 0; i < self.answerModelArr[index].photoUrlArr.count; i++) {
                UIImageView *temp = picArr[i];
                [temp sd_setImageWithURL:[NSURL URLWithString:self.answerModelArr[index].photoUrlArr[i]] placeholderImage:nil];
            }
        } else {
            //没图的cell
            cell = [tableView dequeueReusableCellWithIdentifier:@"YouWenDetailCellSecond"];
            
            if (!cell) {
                cell = [[YouWenDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YouWenDetailCellSecond"];
            }
        }
        
        if (self.isSelf) {
            cell.adoptBtn.hidden = NO;
            self.tempAnswerID = self.answerModelArr[indexPath.row].answer_id;
            if ([self.answerModelArr[indexPath.row].is_adopted isEqualToString:@"0"]) {
                [cell.adoptBtn addTarget:self action:@selector(adopt) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [cell.adoptBtn setTitle:@"已解决" forState:UIControlStateNormal];
            }
            
        } else {
            cell.adoptBtn.hidden = YES;
        }
        
        [cell.extendBtn addTarget:self action:@selector(extend) forControlEvents:UIControlEventTouchUpInside];
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:self.answerModelArr[index].avatarUrl] placeholderImage:nil];
        cell.avatar.contentMode = UIViewContentModeScaleAspectFill;
        cell.avatar.layer.cornerRadius = cell.avatar.layer.bounds.size.width/2.0;
        cell.avatar.layer.masksToBounds = YES;
        
        if ([self.answerModelArr[index].gender isEqualToString:@"女"]) {
            cell.genderImageView.image = [UIImage imageNamed:@"女"];
        } else {
            cell.genderImageView.image = [UIImage imageNamed:@"男"];
        }
        cell.commentImageView.image = [UIImage imageNamed:@"评论"];
        if (self.answerModelArr[index].is_praised) {
            cell.upvoteImageView.image = [UIImage imageNamed:@"已点赞图标"];
        } else {
            cell.upvoteImageView.image = [UIImage imageNamed:@"未点赞图标"];
        }
        cell.upvoteImageView.userInteractionEnabled = YES;
        cell.upvoteImageView.tag = [self.answerModelArr[index].answer_id integerValue];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upvote:)];
        [cell.upvoteImageView addGestureRecognizer:tap];
        
        cell.nickname.text = self.answerModelArr[index].nickname;
        cell.descriptionLabel.text = self.answerModelArr[index].content;
        cell.timeLabel.text = self.answerModelArr[index].timeStr;
        cell.upvoteNumLabel.text = self.answerModelArr[index].upvoteNum;
        cell.commentNumLabel.text = self.answerModelArr[index].commentNum;

    }
        
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 0;
    } else {
        return self.answerModelArr.count;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    AnswerDetailViewController *vc = [[AnswerDetailViewController alloc] init];
    vc.answer_id = self.answerModelArr[indexPath.row].answer_id;
    vc.model = self.answerModelArr[indexPath.row];
    vc.questionTitle = self.questionTitle;
    vc.question_id = self.question_id;
    vc.isSelf = self.detailQuestionModel.isSelf;
    vc.is_upvote = self.answerModelArr[indexPath.row].is_praised;
    vc.isAdopt = self.answerModelArr[indexPath.row].is_adopted;
    [self.navigationController pushViewController:vc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        if (self.detailQuestionModel) {
            NSUInteger num = self.detailQuestionModel.picArr.count;
            self.headView = [[YouWenDetailHeadView alloc] initWithNumOfPic:num];
            self.headView.titleLabel.text = self.detailQuestionModel.title;
            self.headView.descriptionLabel.text = self.detailQuestionModel.descriptionStr;
            self.headView.bottomView.avatarImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.detailQuestionModel.avatar]]];
            self.headView.bottomView.nicknameLabel.text = self.detailQuestionModel.nickName;
            self.headView.bottomView.timeLabel.text = self.detailQuestionModel.disappearTime;
            self.headView.bottomView.rewardImageView.image = [UIImage imageNamed:@"积分按钮"];
            self.headView.bottomView.rewardLabel.text = [NSString stringWithFormat:@"%d积分", [self.detailQuestionModel.reward intValue]];
            [self.headView.bottomView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.detailQuestionModel.avatar] placeholderImage:nil];
            if ([self.detailQuestionModel.gender isEqualToString:@"女"] ) {
                self.headView.bottomView.genderImageview.image = [UIImage imageNamed:@"女"];
            } else {
                self.headView.bottomView.genderImageview.image = [UIImage imageNamed:@"男"];
            }
            [self.headView.bottomView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.detailQuestionModel.avatar]];
            
            NSArray *picArr = [NSArray arrayWithObjects:self.headView.imageview1, self.headView.imageview2, self.headView.imageview3, self.headView.imageview4, nil];
            for (int i = 0; i < num; i++) {
                UIImageView *temp = picArr[i];
                [temp sd_setImageWithURL:[NSURL URLWithString:self.detailQuestionModel.picArr[i]] placeholderImage:nil];
            }
            return self.headView;
        } else {
            return [[UIView alloc] init];
        }
        
    } else if (section == 1){
        UIView *headerView = [[UIView alloc] init];
        UILabel *numOfAns = [[UILabel alloc] init];
        numOfAns.font = [UIFont systemFontOfSize:14.0];
        numOfAns.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
        numOfAns.numberOfLines = 0;
        [headerView addSubview:numOfAns];
        [numOfAns mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView).offset(10);
            make.bottom.equalTo(headerView).offset(-10);
            make.left.equalTo(headerView).offset(20);
        }];
        
        if (self.answerModelArr) {
            NSInteger num = self.answerModelArr.count;
            numOfAns.text = [NSString stringWithFormat:@"%ld个回答", num];
        }
        
        return headerView;
    }
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.01f)];
}


#pragma mark - other
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
                                @"answer_id":self.tempAnswerID,
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
        [self.tableView reloadData];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 网络请求
- (void)getData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    

    NSDictionary *parameters = @{
                                 @"stuNum":[UserDefaultTool getStuNum],
                                 @"idNum":[UserDefaultTool getIdNum],
                                 @"question_id":self.question_id
                                 };
    

    [manager POST:QUESTIONSINFO parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (responseObject) {
            self.detailQuestionModel = [[YouWenQuestionDetailModel alloc] initWithDic:responseObject[@"data"]];
            
            self.answerModelArr = [NSMutableArray array];
            
            for (NSDictionary *dic in responseObject[@"data"][@"answers"]) {
                YouWenAnswerDetailModel *model = [[YouWenAnswerDetailModel alloc] initWithDic:dic];
                [self.answerModelArr addObject:model];
            }
            
            if (self.answerModelArr.count == 0) {
                UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200)];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200)];
                label.text = @"快来成为第一个帮助者吧～";
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:14.0];
                label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.8];
                [footerView addSubview:label];
                _tableView.tableFooterView = footerView;
            }
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}


- (void)reply {
    YouWenWriteAnswerViewController *VC = [[YouWenWriteAnswerViewController alloc] init];
    VC.delegate = self;
    VC.question_id = @"183";
//    VC.question_id = self.question_id;
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)upvote:(UITapGestureRecognizer *)sender{
    YouWenDetailCell *cell = (YouWenDetailCell *)sender.view.superview.superview;
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    NSString *url = [NSString string];
    YouWenAnswerDetailModel *model = [[YouWenAnswerDetailModel alloc] init];
    model = self.answerModelArr[indexpath.row];

    if (model.is_praised) {
        url = CANCELUPVOTEURL;
    } else {
        url = UPVOTEURL;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *answer_id = [NSString stringWithFormat:@"%ld", sender.view.tag];
    
    
    NSDictionary *parameters = @{
                                 @"stuNum":[UserDefaultTool getStuNum],
                                 @"idNum":[UserDefaultTool getIdNum],
                                 @"answer_id":answer_id
                                 };
    
    [manager POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        model.is_praised = !model.is_praised;
        if ([url isEqualToString:UPVOTEURL]) {
            model.upvoteNum = [NSString stringWithFormat:@"%d", [model.upvoteNum intValue] + 1];
        } else {
            model.upvoteNum = [NSString stringWithFormat:@"%d", [model.upvoteNum intValue] - 1];
        }
        
        [self.tableView reloadRowAtIndexPath:indexpath withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];

}

- (void)newView:(UIButton *)btn{
    UIViewController *view;
    if (btn.tag == 0) {
        view = [[ReportViewController alloc] initWithId:_question_id];
    }
    else {
    }
    
    [self.navigationController pushViewController:view animated:YES];
}
- (void)moreInfor{
    TransparentView *view = [[TransparentView alloc] initWithNews:@[@"report",@"share",@"举报",@"分享"]];
    view.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}


#pragma mark - WriteAnswerVC Delegate
- (void)reload {
    self.commitSuccessFrame = [[commitSuccessFrameView alloc] init];
    [self.commitSuccessFrame.confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.commitSuccessFrame show];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self.commitSuccessFrame free];
    });
    [self.tableView reloadData];
}

- (void) confirm {
    if (self.commitSuccessFrame) {
        [self.commitSuccessFrame free];
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

@end

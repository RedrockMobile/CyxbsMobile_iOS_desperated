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
#import "YouWenQuestionDetailModel.h"
#import "YouWenBottomButtonView.h"


#define UPVOTEURL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Answer/praise"
#define CANCELUPVOTEURL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Answer/cancelPraise"
#define ADDCOMMENTURL
@interface AnswerDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) AnswerDetailTableHeaderView *tableHeaderView;
@property (nonatomic) NSMutableArray<AnswerCommentModel *> *answerCommentModelArr;
@property (nonatomic, strong) YouWenBottomButtonView *bottomView;
@end

@implementation AnswerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self addBottomView];
    [self.view addSubview:self.tableview];
    self.tableHeaderView = [[AnswerDetailTableHeaderView alloc] initWithModel:self.model];
    self.tableview.tableHeaderView = self.tableHeaderView;
    self.answerCommentModelArr = [NSMutableArray array];
    
    
}

#pragma mark - bottomButtonView
- (YouWenBottomButtonView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[YouWenBottomButtonView alloc] init];
        if ([self.isSelf integerValue]) {
            _bottomView.label1.text = @"点赞";
            _bottomView.label2.text = @"评论";
            [_bottomView.btn1 addTarget:self action:@selector(upvote) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView.btn2 addTarget:self action:@selector(addComment) forControlEvents:UIControlEventTouchUpInside];
        } else {
            _bottomView.label1.text = @"点赞";
            _bottomView.label2.text = @"评论";
            [_bottomView.btn1 addTarget:self action:@selector(upvote) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView.btn2 addTarget:self action:@selector(addComment) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return _bottomView;
}

- (void)addBottomView {
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@(45/700.0*ScreenHeight));
    }];
}

- (void)upvote {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *stuNum = [user objectForKey:@"stuNum"];
    NSString *idNum = [user objectForKey:@"idNum"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSString *upvoteUrl  = UPVOTEURL;
//    NSString *cancelUpvoteUrl = CANCELUPVOTEURL;
    NSString *url = [NSString string];
    if (self.is_upvote) {
        url = CANCELUPVOTEURL;
    } else {
        url = UPVOTEURL;
    }
    NSDictionary *parameters = @{
                                 @"stuNum":stuNum,
                                 @"idNum":idNum,
                                 @"answer_id":self.answer_id
                                 };
    
    [manager POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        //更改点赞图片
//        if (self.is_upvote) {
//            self.bottomView.imageView1.image = [UIImage imageNamed:@"未点赞图标"];
//        } else {
//            self.bottomView.imageView1.image = [UIImage imageNamed:@"已点赞图标"];
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)addComment {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *stuNum = [user objectForKey:@"stuNum"];
    NSString *idNum = [user objectForKey:@"idNum"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr  = UPVOTEURL;
    NSDictionary *parameters = @{
                                 @"stuNum":stuNum,
                                 @"idNum":idNum,
                                 @"answer_id":self.answer_id
                                 };
    
    [manager POST:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //评论数目+1
        ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
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
    }
    
    return _tableview;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static const NSString *identify = @"AnswerDetailTableViewCell";
    AnswerDetailTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        cell = [[AnswerDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        if (self.answerCommentModelArr.count > 0) {
            NSInteger row  = indexPath.row;
            cell.nickname.text = self.answerCommentModelArr[row].nickname;
            cell.avatarImageView.contentMode = UIViewContentModeScaleToFill;
            [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.answerCommentModelArr[row].avatarUrlStr]];
            cell.dateLabel.text = self.answerCommentModelArr[row].date;
            cell.contentLabel.text = self.answerCommentModelArr[row].content;
            
        }
        
    }
    
    return cell;
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

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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

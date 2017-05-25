//
//  DetailTopicViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/20.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "DetailTopicViewController.h"
#import "MBCommunityTableView.h"
#import "MBCommunity_ViewModel.h"
#import "MBCommunityCellTableViewCell.h"
#import "MBCommunityHandle.h"
#import "MBReleaseViewController.h"
#import "LoginViewController.h"
#import <MJRefresh.h>
#import <MBProgressHUD.h>
#import "MyMessagesViewController.h"
#import "MBCommuityDetailsViewController.h"
#import "BannerScrollView.h"
#import "DetailBannnerView.h"
#import <Masonry.h>
@interface DetailTopicViewController ()<UITableViewDelegate,UITableViewDataSource,MBCommunityCellEventDelegate>
@property UITableView *tableView;
@property NSMutableArray *viewModels;
@property DetailBannnerView *detailBannnerView;
@property TopicModel *topic;
@property (nonatomic) UIBarButtonItem *shareButton;
@property (nonatomic) UIButton *joinBtn;
@property BOOL isRefresh;
@property NSInteger page;
@end

@implementation DetailTopicViewController

- (instancetype)initWithTopic:(TopicModel *)topic{
    self = [self init];
    if (self) {
        self.topic = topic;
        self.viewModels = [NSMutableArray array];
        self.isRefresh = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    [self setupTableView];
    [self getArticles];
    [self setupJoinBtn];
    self.navigationItem.rightBarButtonItem = self.shareButton;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupJoinBtn{
    if (self.joinBtn == nil) {
        self.joinBtn = [[UIButton alloc]init];
        [self.joinBtn addTarget:self action:@selector(joinAction) forControlEvents:UIControlEventTouchUpInside];
        [self.joinBtn setBackgroundImage:[UIImage imageNamed:@"topic_image_join"] forState:UIControlStateNormal];
        [self.view addSubview:self.joinBtn];

        [self.joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.and.left.and.bottom.equalTo(self.view).offset(0);
            make.height.mas_equalTo(SCREENHEIGHT*0.15);
        }];
    }
}

- (void)joinAction{
    
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-SCREENHEIGHT*0.15) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    self.detailBannnerView =[[DetailBannnerView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 230) andTopic:self.topic];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.isRefresh = YES;
        [self getArticles];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.isRefresh = NO;
        [self getArticles];
    }];
}

#pragma mark - 请求网络数据

- (void)getArticles{
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"]?:@"";
    NSMutableDictionary *parameter =
    @{@"stuNum":stuNum,
      @"topic_id":self.topic.topic_id}.mutableCopy;
    if (self.isRefresh) {
        [parameter setObject:@0 forKey:@"page"];
    }
    else{
        [parameter setObject:@(self.page+1) forKey:@"page"];
    }
    
    [NetWork NetRequestPOSTWithRequestURL:TOPICARTICLE_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        NSMutableArray *dataArray = returnValue[@"data"][@"articles"];
        if (self.isRefresh) {
            self.page = 0;
            self.viewModels = [NSMutableArray array];
        }
        else{
            self.page++;
        }
        for (int i=0; i<dataArray.count; i++) {
            MBCommunityModel *model = [[MBCommunityModel alloc]initWithDictionary:dataArray[i]];
            MBCommunity_ViewModel *viewModel = [[MBCommunity_ViewModel alloc]init];
            viewModel.model = model;
            [self.viewModels addObject:viewModel];
        }
        self.tableView.hidden = NO;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"%@",returnValue);
    } WithFailureBlock:^{
        NSLog(@"请求数据失败");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您的网络不给力!";
        [hud hide:YES afterDelay:1];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark -UITableView

- (NSInteger)tableView:(MBCommunityTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(MBCommunityTableView *)tableView {
    return self.viewModels.count+1;
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.section;
    if (index == 0) {
        return self.detailBannnerView.extendHeight;
    }
    return [self.viewModels[index-1] cellHeight];
    
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(MBCommunityTableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(MBCommunityTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.section;
    MBCommunityCellTableViewCell *cell = [MBCommunityCellTableViewCell cellWithTableView:tableView type:MBCommunityViewCellSimple];
    MBCommunity_ViewModel *viewModel;
    if(index == 0){
        UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:self.detailBannnerView.frame];
        [cell addSubview:self.detailBannnerView];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.detailBannnerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell).with.insets(padding);
        }];
        return cell;
    }
    viewModel = self.viewModels[index-1];
    cell.eventDelegate = self;
    cell.clickSupportBtnBlock = [MBCommunityHandle clickSupportBtn:self];
    cell.subViewFrame = viewModel;
    return cell;
}

//点击cell的头像的代理方法
- (void)eventWhenclickHeadImageView:(MBCommunityModel *)model {
    MyMessagesViewController *myMeVc = [[MyMessagesViewController alloc]initWithLoadType:MessagesViewLoadTypeOther withCommunityModel:model];
    myMeVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myMeVc animated:YES];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.section;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MBCommuityDetailsViewController *vc= [[MBCommuityDetailsViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    if (index == 0) {
        [self.detailBannnerView extend];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        return;
    }
    MBCommunity_ViewModel *viewModel = self.viewModels[index-1];
    vc.viewModel = viewModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIBarButtonItem *)shareButton {
    UIBarButtonItem *shareBtn;
    if (!_shareButton) {
        shareBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(clickShareButton)];
        
    }
    return shareBtn;
}

- (void)clickShareButton{
//    //显示分享面板
//    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        [self shareTextToPlatformType:platformType];
//        // 根据获取的platformType确定所选平台进行下一步操作
//    }];
        NSString *textToShare = @"要分享的文本内容";
    
        UIImage *imageToShare = [UIImage imageNamed:@"智妍1.jpg"];
    
        NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
    
        NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
    
    
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
        activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
        [self.navigationController presentViewController:   activityVC animated:YES completion:nil];
}

//- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
//{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    //设置文本
//    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
//
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            NSLog(@"************Share fail with error %@*********",error);
//        }else{
//            NSLog(@"response data is %@",data);
//        }
//    }];
//}
//- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
//{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//
//    //创建网页内容对象
//    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
//    //设置网页地址
//    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
//
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            UMSocialLogInfo(@"************Share fail with error %@*********",error);
//        }else{
//            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                UMSocialShareResponse *resp = data;
//                //分享结果消息
//                UMSocialLogInfo(@"response message is %@",resp.message);
//                //第三方原始返回的数据
//                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//
//            }else{
//                UMSocialLogInfo(@"response data is %@",data);
//            }
//        }
//        //        [self alertWithError:error];
//    }];
//}
//
//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  dailyAttendanceDetailViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/1.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "dailyAttendanceDetailViewController.h"
#import "dailyAttendanceCell.h"
#define URL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/integralRecords"

@interface dailyAttendanceDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *detailTableView;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *soreLab;
@property (nonatomic, strong) NSMutableArray *data;
@property (assign, nonatomic) NSInteger page;
@end

@implementation dailyAttendanceDetailViewController

- (id)initWithImage:(UIImage *)img AndSore:(NSString *)num{
    if (self = [super init]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.view.backgroundColor = RGBColor(246, 246, 246, 1);
        self.title = @"积分明细";

        _headImage = [[UIImageView alloc] initWithImage:img];
        _soreLab = [[UILabel alloc] init];
        _data = [NSMutableArray array];
        _page = 0;
        
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前的积分数：%@", num]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 6)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"6D86E8"] range:NSMakeRange(7, num.length)];
        _soreLab.attributedText = attributedString;
        
        [self setTableView];
    }
    return self;
}

- (void)setTableView{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 40, 100)];
    _headImage.frame = CGRectMake(20, 0, 60, 60);
    _headImage.layer.cornerRadius = _headImage.width/2;
    _headImage.layer.borderWidth = 1;
    _headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImage.layer.masksToBounds = YES;

    _headImage.centerY = header.centerY;
    [header addSubview:_headImage];
    
    _soreLab.frame = CGRectMake(_headImage.right + 20, 0, 200, 20);
    _soreLab.centerY = header.centerY;
    [header addSubview:_soreLab];
    // 设置header
    
    self.detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 20, ScreenWidth - 40, 300) style:UITableViewStylePlain];
    self.detailTableView.tableHeaderView = header;
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    self.detailTableView.layer.cornerRadius = 10;
    self.detailTableView.layer.masksToBounds = YES;
    
    self.detailTableView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.detailTableView.layer.shadowOffset = CGSizeMake(10, 10);
    self.detailTableView.layer.shadowOpacity = 1;
    
    [self.view addSubview:_detailTableView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    dailyAttendanceCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"dailyAttendanceCell" owner:nil options:nil] lastObject];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (void)freshData{
    HttpClient * client = [HttpClient defaultClient];
    [client requestWithPath:URL method:HttpRequestPost parameters:@{@"stunum":[UserDefaultTool getStuNum], @"idNum":[UserDefaultTool getIdNum]} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [_data removeAllObjects];
        
        [_data addObjectsFromArray:[responseObject objectForKey:@"data"]];
        // 刷新表格
        self.detailTableView.mj_footer.hidden = NO;
        [self.detailTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UILabel *faileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        faileLable.text = @"哎呀！网络开小差了 T^T";
        faileLable.textColor = [UIColor blackColor];
        faileLable.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        faileLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:faileLable];
        [_detailTableView removeFromSuperview];
    }];
}



@end

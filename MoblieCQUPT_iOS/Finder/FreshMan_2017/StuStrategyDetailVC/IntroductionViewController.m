//
//  IntroductionViewController.m
//  TestLayoutButton
//
//  Created by helloworld on 2017/8/4.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "IntroductionViewController.h"
#import "IntroductionTableViewCell.h"

@interface IntroductionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSMutableArray *contentArray;

@end

@implementation IntroductionViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.view.superview.height*50/667 - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return _tableView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setArrayData];
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"IntroductionTableViewCell";
    IntroductionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"IntroductionTableViewCell" owner:nil options:nil] lastObject];;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.grayView.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
    
    cell.blueView.layer.cornerRadius = 2;
    cell.blueView.backgroundColor = [UIColor colorWithRed:121/255.0 green:141/255.0 blue:250/255.0 alpha:1];
    
    cell.titltLabel.font = [UIFont systemFontOfSize:15];
    cell.titltLabel.text = self.titleArray[indexPath.row];
    cell.titltLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    
    cell.contentLabel1.font = cell.contentLabel2.font = cell.contentLabel3.font = cell.contentLabel4.font = cell.contentLabel5.font = cell.contentLabel6.font = cell.contentLabel7.font = [UIFont systemFontOfSize:13];
    cell.contentLabel1.textColor = cell.contentLabel2.textColor = cell.contentLabel3.textColor = cell.contentLabel4.textColor = cell.contentLabel5.textColor = cell.contentLabel6.textColor = cell.contentLabel7.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
 
    if (indexPath.row == 0) {
        cell.contentLabel7.hidden = YES;
        cell.contentLabel1.attributedText = self.contentArray[0][0];
        cell.contentLabel2.attributedText = self.contentArray[0][1];
        cell.contentLabel3.attributedText = self.contentArray[0][2];
        cell.contentLabel4.attributedText = self.contentArray[0][3];
        cell.contentLabel5.attributedText = self.contentArray[0][4];
        cell.contentLabel6.attributedText = self.contentArray[0][5];
    } else if (indexPath.row == 1) {
        cell.contentLabel1.attributedText = self.contentArray[1][0];
        cell.contentLabel2.attributedText = self.contentArray[1][1];
        cell.contentLabel3.attributedText = self.contentArray[1][2];
        cell.contentLabel4.attributedText = self.contentArray[1][3];
        cell.contentLabel5.attributedText = self.contentArray[1][4];
        cell.contentLabel6.attributedText = self.contentArray[1][5];
        cell.contentLabel7.attributedText = self.contentArray[1][6];
    } else if (indexPath.row == 2) {
        cell.contentLabel6.hidden = YES;
        cell.contentLabel7.hidden = YES;
        cell.contentLabel1.attributedText = self.contentArray[2][0];
        cell.contentLabel2.attributedText = self.contentArray[2][1];
        cell.contentLabel3.attributedText = self.contentArray[2][2];
        cell.contentLabel4.attributedText = self.contentArray[2][3];
        cell.contentLabel5.attributedText = self.contentArray[2][4];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 500;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setArrayData {
    self.titleArray = [[NSArray alloc] initWithObjects:@"新生清单", @"安全守则", @"乘车路线", nil];
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"报道时间：本科新生2017年9月14、15日报道"];
    NSRange range1 = [[str1 string] rangeOfString:@"报道时间："];
    [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range1];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:@"报道地点：重庆邮电大学风雨操场"];
    NSRange range2 = [[str2 string] rangeOfString:@"报道地点："];
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range2];
    
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:@"新生必带：自带同版近期照片共15张（要求光面相纸洗印，白底一寸，半神，正脸，免冠大头照片），新生档案，党团关系证明，户口本（需要迁户口的同学携带），录取通知书，高考准考证，身份证以及身份证（复印件多复印几份，多复印几份，虽然学校并未做要求），银行卡（缴学费）,少量现金。"];
    NSRange range3 = [[str3 string] rangeOfString:@"新生必带："];
    [str3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range3];
    
    NSMutableAttributedString *str4 = [[NSMutableAttributedString alloc] initWithString:@"洗护用品：男生的剃须刀，女生的护肤品（男生也可以适当准备一些），日常洗漱需要的物品（诸如牙膏牙刷，毛巾，沐浴露，盆桶一以及洗衣物所需要的洗衣液，刷子等等。"];
    NSRange range4 = [[str4 string] rangeOfString:@"洗护用品："];
    [str4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range4];
    
    NSMutableAttributedString *str5 = [[NSMutableAttributedString alloc] initWithString:@"衣物方面：四季的外套、袜子等等（要是重庆本地的同学或者是经常回家的同学非当季的衣物可以不用携带），各种四晾衣物的工具（如衣叉，衣架等等）。蚊帐（根据个人喜好，也可以采用驱蚊液，这样就可以不挂蚊帐），一些基本的床上用品（枕头，被子等，被单最好准备两张，枕套同样如此），凉席（有了空调你也许会忘掉它），遮光帘（根据个人情况，要是对灯光比较敏感，建议准备），一些日常使用的药品（感冒药，创可贴之类的），台灯，还有各类寝室神器（这些就根据自己的实际需要进行添置）。"];
    NSRange range5 = [[str5 string] rangeOfString:@"衣物方面："];
    [str5 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range5];
    
    NSMutableAttributedString *str6 = [[NSMutableAttributedString alloc] initWithString:@"个人物品：电脑（笔记本最宜，其他的数码产品根据自己的情况进行添置），以及一些学习物品（签字笔，笔记本等等），台灯，水杯等等。"];
    NSRange range6 = [[str6 string] rangeOfString:@"个人物品："];
    [str6 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range6];
    
     NSArray *array1 = [[NSArray alloc] initWithObjects:str1, str2, str3, str4, str5, str6,nil];
    
    
    NSMutableAttributedString *str11 = [[NSMutableAttributedString alloc] initWithString:@"防止上当受骗：一些不法分子利用新生刚入学不熟悉的情况，以老师，学长或者老乡的身份骗取新生信任，然后以代费、减免学费等多种方式进行诈骗。"];
    NSRange range11 = [[str11 string] rangeOfString:@"防止上当受骗："];
    [str11 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range11];
    
    NSMutableAttributedString *str22 = [[NSMutableAttributedString alloc] initWithString:@"不携带过多现金：数额较大的现金应该及时存入银行，存折、银行卡、身份证尽量分开放；使用银行卡要谨慎以防密码泄露。"];
    NSRange range22 = [[str22 string] rangeOfString:@"不携带过多现金："];
    [str22 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range22];
    
    NSMutableAttributedString *str33 = [[NSMutableAttributedString alloc] initWithString:@"拒绝上门推销：许多不法分子以到寝室推销为名进行诈骗或盗窃，如若发现上门推销人员，应该及时报告宿管人员或者保卫处。"];
    NSRange range33 = [[str33 string] rangeOfString:@"拒绝上门推销："];
    [str33 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range33];
    
    NSMutableAttributedString *str44 = [[NSMutableAttributedString alloc] initWithString:@"室内注意防盗：要保管好自己的笔记本电脑、手机等贵重物品，不要将其随意放置，以免被“顺手牵羊”。"];
    NSRange range44 = [[str44 string] rangeOfString:@"室内注意防盗："];
    [str44 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range44];
    
    NSMutableAttributedString *str55 = [[NSMutableAttributedString alloc] initWithString:@"注意消防安全：爱护消防设施，寝室内不违章使用大功率电器。"];
    NSRange range55 = [[str55 string] rangeOfString:@"注意消防安全："];
    [str55 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range55];
    
    NSMutableAttributedString *str66 = [[NSMutableAttributedString alloc] initWithString:@"注意交通安全：不乘坐“黑车”和存在安全隐患的车辆。"];
    NSRange range66 = [[str66 string] rangeOfString:@"注意交通安全："];
    [str66 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range66];
    
    NSMutableAttributedString *str77 = [[NSMutableAttributedString alloc] initWithString:@"遇到情况及时与公安机关联系：在遇到不法侵害时，要及时与公安机关（110）或者学校保卫处联系（62461018,62460110）。"];
    NSRange range77 = [[str77 string] rangeOfString:@"遇到情况及时与公安机关联系："];
    [str77 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range77];
    
    NSArray *array11 = [[NSArray alloc] initWithObjects:str11, str22, str33, str44, str55, str66, str77, nil];
    
    
    NSMutableAttributedString *str111 = [[NSMutableAttributedString alloc] initWithString:@"迎新接站：报道期间，我校将在重庆火车北站南、北广场设新生接待站，有同学负责引导新生到指定地点乘车。"];
    NSRange range111 = [[str111 string] rangeOfString:@"迎新接站："];
    [str111 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range111];
    
    NSMutableAttributedString *str222 = [[NSMutableAttributedString alloc] initWithString:@"重庆江北机场（距离学校约40公里）：可乘机场大巴至上清寺后转乘108路公交车至南坪，再转乘346或347路公交车到学校；或乘轻轨三号线到南坪，再转乘346或347路公交车到学校；直接打车到校费用约为70元；"];
    NSRange range222 = [[str222 string] rangeOfString:@"重庆江北机场（距离学校约40公里）："];
    [str222 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range222];
    
    NSMutableAttributedString *str333 = [[NSMutableAttributedString alloc] initWithString:@"龙头寺火车站、重庆北站（距离学校约20公里）：乘323路或168路公交车至南坪，转乘346或347路公交车至学校：或乘轻轨三号线到南坪，再转乘346或347路公交车到学校；直接打车到校费用约40元；"];
    NSRange range333 = [[str333 string] rangeOfString:@"龙头寺火车站、重庆北站（距离学校约20公里）："];
    [str333 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range333];
    
    NSMutableAttributedString *str444 = [[NSMutableAttributedString alloc] initWithString:@"菜园坝火车站、汽车站（距离学校约12公里）：可在菜园坝广场乘347路公交车至学校；直接打车到校费用约为25元；"];
    NSRange range444 = [[str444 string] rangeOfString:@"菜园坝火车站、汽车站（距离学校约12公里）："];
    [str444 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range444];
    
    NSMutableAttributedString *str555 = [[NSMutableAttributedString alloc] initWithString:@"朝天门码头（距离学校约9公里）：可乘车至南坪后转乘346或347路公交车至学校；直接打车到校费用约为20元。"];
    NSRange range555 = [[str555 string] rangeOfString:@"朝天门码头（距离学校约9公里）："];
    [str555 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:1 alpha:1] range:range555];
    NSArray *array111 = [[NSArray alloc] initWithObjects:str111, str222, str333, str444, str555, nil];
    
    self.contentArray = [[NSMutableArray alloc] initWithObjects:array1, array11, array111, nil];
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

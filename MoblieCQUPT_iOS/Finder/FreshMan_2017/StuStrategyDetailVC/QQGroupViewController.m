//
//  QQGroupViewController.m
//  TestLayoutButton
//
//  Created by helloworld on 2017/8/4.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "QQGroupViewController.h"
#import <Masonry.h>

@interface QQGroupViewController ()<UITextFieldDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *collegeArray;
@property (strong, nonatomic) UITextField *textField1;
@property (strong, nonatomic) UITextField *textField2;
@property (strong, nonatomic) NSMutableArray *resultArray;
@property (strong, nonatomic) UILabel *contentLabel;
@property BOOL displayHintLabel;

@end

@implementation QQGroupViewController

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - self.view.superview.height*50/667)];
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        if ([UIScreen mainScreen].bounds.size.width <= 330) {
            _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 2364 + 40 - 110);
        }
        else {
            _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 2364 + 60);
        }
        
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 6)];
        grayView.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
        UITapGestureRecognizer *tapToBackGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToBack)];
        [self.scrollView addGestureRecognizer:tapToBackGesture];
        [_scrollView addSubview:grayView];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(18, 17, [UIScreen mainScreen].bounds.size.width - 36, 33/341.0 * ([UIScreen mainScreen].bounds.size.width - 36))];
        textField.layer.cornerRadius = 3;
        textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1];
        textField.placeholder = @"输入学院或地区";
        textField.returnKeyType = UIReturnKeySearch;
        textField.tag = 1;
        textField.delegate = self;
        self.textField1 = textField;
        [self.scrollView addSubview:textField];
    }
    
    return _scrollView;
}

- (void)tapToBack {
    [self.textField1 resignFirstResponder];
}

- (void)tapToBack1 {
    [self.textField2 resignFirstResponder];
}

//点击textfield选中当前文字
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    UITextPosition *endDocument = textField.endOfDocument;//获取 text的 尾部的 TextPositext
    
    UITextPosition *end = [textField positionFromPosition:endDocument offset:0];
    UITextPosition *start = [textField positionFromPosition:end offset:-textField.text.length];//左－右＋
    if (textField.tag == 1) {
        self.textField1.selectedTextRange = [textField textRangeFromPosition:start toPosition:end];
    }
    else if (textField.tag == 2) {
        self.textField2.selectedTextRange = [textField textRangeFromPosition:start toPosition:end];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.displayHintLabel = YES;
    if ([self.textField1.text isEqualToString:@""] || [self.textField2.text isEqualToString:@""]) {
        NSLog(@"显示");
        return NO;
    }
    self.scrollView.scrollEnabled = NO;
    
    if (textField.tag == 1) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 6, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height - 6)];
        scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.tag = 1997;
        scrollView.scrollEnabled = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.bounces = NO;
        UITapGestureRecognizer *tapToBackGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToBack1)];
        [scrollView addGestureRecognizer:tapToBackGesture1];
        [self.scrollView addSubview:scrollView];
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(28, 32 + 17 + (33/341.0 * ([UIScreen mainScreen].bounds.size.width - 36)), 200, 13)];
        label.text = @"搜索结果";
        label.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        label.font = [UIFont systemFontOfSize:13];
        [scrollView addSubview:label];
        NSString *searchStr = self.textField1.text;
        for (int i =0; i < self.collegeArray.count; i++) {
            if (searchStr.length >= 2 && [self.collegeArray[i] containsString:searchStr ]) {
                [self.resultArray addObject:self.collegeArray[i]];
            }
        }
        
        UILabel *hintLabel = [[UILabel alloc] init];
        hintLabel.hidden = YES;
        hintLabel.tag = 1234;
        [scrollView addSubview:hintLabel];
        hintLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        hintLabel.backgroundColor = [UIColor clearColor];
        hintLabel.font = [UIFont systemFontOfSize:14];
        hintLabel.textAlignment = NSTextAlignmentLeft;
        hintLabel.text = @"暂无搜索结果";
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(scrollView.mas_left).offset(28);
            make.top.equalTo(label.mas_bottom).offset(16);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
        }];
    
//展示搜索结果
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, 32 + 17 + (33/341.0 * ([UIScreen mainScreen].bounds.size.width - 36)) + 13 + 16, [UIScreen mainScreen].bounds.size.width - 28 - 48, 1000)];
        _contentLabel.numberOfLines = 0;
        if([UIScreen mainScreen].bounds.size.width <= 330) {
            _contentLabel.font  = [UIFont systemFontOfSize:10];
        }
        else {
            _contentLabel.font = [UIFont systemFontOfSize:13];
        }
        _contentLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        NSMutableString *resultStr = [[NSMutableString alloc] init];
    
        for (int i = 0; i < self.resultArray.count; i++) {
            self.displayHintLabel = NO;
            [resultStr appendString:self.resultArray[i]];
            if (i != self.resultArray.count - 1) {
                [resultStr appendString:@"\n"];
            }
        }
        
        if ([searchStr isEqualToString:@"重庆"]) {
            if ([UIScreen mainScreen].bounds.size.width <= 330) {
                scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 680);
            }
            else {
                scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 750);
            }
            scrollView.scrollEnabled = YES;
        }
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:resultStr];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [resultStr length])];
        [_contentLabel setAttributedText:attributedString];
        [_contentLabel sizeToFit];
        [scrollView addSubview:_contentLabel];
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(18 + [UIScreen mainScreen].bounds.size.width - 36 - 43 + 15 - 5, 29, 27 + 5, 13)];
        [cancelBtn setTitleColor:[UIColor colorWithRed:101/255.0 green:178/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn addTarget:self action:@selector(tapCancelBtn) forControlEvents:UIControlEventTouchDown];
        [scrollView addSubview:cancelBtn];
        
        UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(18, 17, [UIScreen mainScreen].bounds.size.width - 36 - 43, 33/341.0 * ([UIScreen mainScreen].bounds.size.width - 36))];
        textField1.layer.cornerRadius = 3;
        textField1.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
        textField1.leftViewMode = UITextFieldViewModeAlways;
        textField1.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1];
        textField1.returnKeyType = UIReturnKeySearch;
        textField1.tag = 2;
        textField1.placeholder = @"输入学院或地区";
        textField1.delegate = self;
        self.textField2 = textField1;
        self.textField2.text = searchStr;
        [scrollView addSubview:textField1];
    }
    else if (textField.tag == 2) {
        UIScrollView *scrollView = [self.scrollView viewWithTag:1997];
        scrollView.delegate = self;
        if ((scrollView.scrollEnabled = YES)) {
            scrollView.scrollEnabled = NO;
        }
        [self.contentLabel setFrame:CGRectMake(28, 32 + 17 + (33/341.0 * ([UIScreen mainScreen].bounds.size.width - 36)) + 13 + 16, [UIScreen mainScreen].bounds.size.width - 28 - 48, 100)];
        NSString *searchStr = self.textField2.text;
        for (int i =0; i < self.collegeArray.count; i++) {
            if (searchStr.length >= 2 && [self.collegeArray[i] containsString:searchStr]) {
                [self.resultArray addObject:self.collegeArray[i]];
            }
        }
        
        if ([searchStr isEqualToString:@"重庆"]) {
            scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 750);
            scrollView.scrollEnabled = YES;
        }
        
        NSMutableString *resultStr = [[NSMutableString alloc] init];
        for (int i = 0; i < self.resultArray.count; i++) {
            self.displayHintLabel = NO;
            [resultStr appendString:self.resultArray[i]];
            if (i != self.resultArray.count - 1) {
                [resultStr appendString:@"\n"];
            }
        }
        
//        UILabel * contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, 32 + 17 + (33/341.0 * ([UIScreen mainScreen].bounds.size.width - 36)) + 13 + 16, [UIScreen mainScreen].bounds.size.width - 28 - 48, 100)];
//        contentLabel.numberOfLines = 0;
//        contentLabel.font = [UIFont systemFontOfSize:13];
//        contentLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:resultStr];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [resultStr length])];
        [_contentLabel setAttributedText:attributedString];
        [_contentLabel sizeToFit];
    }
    
    if (self.displayHintLabel == YES) {
        //拿到第二个scrollView
        UIView *scrollview = [self.scrollView viewWithTag:1997];
        //拿到hintLabel
        UIView *hintLabel = [scrollview viewWithTag:1234];
        hintLabel.hidden = NO;
    }
    else {
        UIView *scrollview = [self.scrollView viewWithTag:1997];
        UIView *hintLabel = [scrollview viewWithTag:1234];
        hintLabel.hidden = YES;
    }
    
    [self.resultArray removeAllObjects];
    [textField resignFirstResponder];
    return YES;
}

- (void)tapCancelBtn {
    UIView *view = [self.view viewWithTag:1997];
    [view removeFromSuperview];
    self.textField1.text = @"";
    self.scrollView.scrollEnabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collegeArray = [[NSArray alloc] initWithObjects:@"重庆邮电大学总群：636208141",@"通信与信息工程学院：498167991",@"计算机与科学技术学院：638612170",@"自动化学院：574872113",@"光电工程学院/国际半导体学院：636449199",@"外国语学院：333094013",@"传媒艺术学院：527468298",@"生物信息学院：637402699",@"经济管理学院信息管理与信息系统专业：362192309",@"经济管理学院： 545772871",@"经济管理学院工程管理专业：552540368",@"软件工程学院：482656306",@"网络空间安全与信息法学院：162240404",@"理学院：575159267",@"体育学院：649510732",@"国际学院：17443276",@"先进制造工程学院：563565394",@"贵州：601631814",@"河北：548535234",@"安徽：562487104",@"辽宁：134489031",@"河南老乡群1：310222276",@"河南老乡群2：251311309",@"河南安阳：116198098",@"山东：384043802",@"江苏：123736116",@"黑龙江：316348915",@"潮汕：4958681",@"江西：3889855",@"江西上饶：476426072",@"浙江：247010642",@"广西贵港：5819894",@"广西南宁：16026851",@"广西：9651531",@"广西柳州：7045893",@"广东：113179139",@"广东韶关：66484867",@"广东惠州：213337022 ",@"山西：119738941",@"海南：9334029",@"福建：173210510",@"吉林：118060379",@"云南宣威：211910023",@"云南玉溪：256581906",@"云南曲靖：117499346",@"云南：548640416",@"云南官方群：42052111",@"天津：8690505",@"湖北恩施：179765240",@"湖北：33861584",@"湖北黄冈：181704337",@"湖南：204491110",@"重庆梁平：85423833",@"重庆忠县：115637967",@"重庆铜梁：198472776",@"重庆大足：462534986",@"重庆开县：5657168",@"重庆荣昌：149452192",@"重庆永川：467050041",@"重庆丰都：343292119",@"重庆涪陵：199748999",@"重庆云阳：118971621",@"重庆璧山：112571803",@"重庆石柱：289615375",@"重庆彭水：283978475",@"重庆南川：423494314",@"重庆垫江：307233230",@"重庆合川：226325326",@"重庆荣昌：149452192",@"重庆綦江：109665788",@"重庆奉节：50078959",@"重庆铜梁：198472776",@"重庆黔江：102897346",@"重庆万州：469527984",@"重庆巫溪：143884210",@"重庆巫山：129440237",@"四川大群：142604890",@"四川成都：298299346",@"四川自贡：444020511",@"四川绵阳：191653502",@"陕西：193388613",@"新疆：248052400",@"青海：282597612",@"北京：143833720",@"甘肃美术：578076400",@"甘肃：155724412", nil];
    self.resultArray = [[NSMutableArray alloc] init];
    self.displayHintLabel = NO;
    [self layoutLabel];
    [self.view addSubview:self.scrollView];
}
- (void) layoutLabel {
    UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 17 + 23 + 33/341.0 * ([UIScreen mainScreen].bounds.size.width - 36), [UIScreen mainScreen].bounds.size.width - 20 - 78, 15)];
    titleLabel1.textAlignment = NSTextAlignmentLeft;
    titleLabel1.textColor = [UIColor blackColor];
    titleLabel1.text = @"新生群：";
    [self.scrollView addSubview:titleLabel1];
    
    UILabel * contentLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 17 + 54 + 33/341.0 * ([UIScreen mainScreen].bounds.size.width - 36), [UIScreen mainScreen].bounds.size.width - 20 - 78, 384)];
    contentLabel1.numberOfLines = 0;
    if([UIScreen mainScreen].bounds.size.width <= 330) {
        contentLabel1.font  = [UIFont systemFontOfSize:11.5];
    }
    else {
        contentLabel1.font = [UIFont systemFontOfSize:13];
    }
    contentLabel1.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    NSString *str1 = @"重庆邮电大学总群：636208141\n通信与信息工程学院：498167991\n计算机与科学技术学院：638612170\n自动化学院：574872113\n光电工程学院/国际半导体学院：636449199\n外国语学院：333094013\n传媒艺术学院：527468298\n生物信息学院：637402699\n经济管理学院信息管理与信息系统专业：362192309\n经济管理学院： 545772871\n经济管理学院工程管理专业：552540368\n软件工程学院：482656306\n网络空间安全与信息法学院：162240404\n理学院：575159267\n体育学院：649510732\n国际学院：17443276\n先进制造工程学院：563565394";
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:str1];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:10];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str1 length])];
    [contentLabel1 setAttributedText:attributedString1];
    [contentLabel1 sizeToFit];
    [self.scrollView addSubview:contentLabel1];
    
    
    
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 29 + 553, [UIScreen mainScreen].bounds.size.width - 20 - 78, 15)];
    titleLabel2.textAlignment = NSTextAlignmentLeft;
    titleLabel2.textColor = [UIColor blackColor];
    titleLabel2.text = @"老乡群：";
    [self.scrollView addSubview:titleLabel2];
    
    UILabel * contentLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 597 + 17, [UIScreen mainScreen].bounds.size.width - 20 - 78, 384)];
    contentLabel2.numberOfLines = 0;
    contentLabel2.font = [UIFont systemFontOfSize:13];
    contentLabel2.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    NSString *str2 = @"贵州：601631814\n河北：548535234\n安徽：562487104\n辽宁：134489031\n河南老乡群1：310222276\n河南老乡群2：251311309\n河南安阳：116198098\n山东：384043802\n江苏：123736116\n黑龙江：316348915\n潮汕：4958681\n江西：3889855\n江西上饶：476426072\n浙江：247010642\n广西贵港：5819894\n广西南宁：16026851\n广西：9651531\n广西柳州：7045893\n广东：113179139\n广东韶关：66484867\n广东惠州：213337022\n山西：119738941\n海南：9334029\n福建：173210510\n吉林：118060379\n云南宣威：211910023\n云南玉溪：256581906\n云南曲靖：117499346\n云南：548640416\n云南官方群：42052111\n天津：8690505\n湖北恩施：179765240\n湖北：33861584\n湖北黄冈：181704337\n湖南：204491110\n重庆梁平：85423833\n重庆忠县：115637967\n重庆铜梁：198472776\n重庆大足：462534986\n重庆开县：5657168\n重庆荣昌：149452192\n重庆永川：467050041\n重庆丰都：343292119\n重庆涪陵：199748999\n重庆云阳：118971621\n重庆璧山：112571803\n重庆石柱：289615375\n重庆彭水：283978475\n重庆南川：423494314\n重庆垫江：307233230\n重庆合川：226325326\n重庆荣昌：149452192\n重庆綦江：109665788\n重庆奉节：50078959\n重庆铜梁：198472776\n重庆黔江：102897346\n重庆万州：469527984\n重庆巫溪：143884210\n重庆巫山：129440237\n四川大群：142604890\n四川成都：298299346\n四川自贡：444020511\n四川绵阳：191653502\n陕西：193388613\n新疆：248052400\n青海：282597612\n北京：143833720\n甘肃美术：578076400\n甘肃：155724412";
    if([UIScreen mainScreen].bounds.size.width <= 330) {
        contentLabel2.font  = [UIFont systemFontOfSize:11.5];
    }
    else {
        contentLabel2.font = [UIFont systemFontOfSize:13];
    }
    NSMutableAttributedString * attributedString2 = [[NSMutableAttributedString alloc] initWithString:str2];
    NSMutableParagraphStyle * paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle2 setLineSpacing:10];
    [attributedString2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [str2 length])];
    [contentLabel2 setAttributedText:attributedString2];
    [contentLabel2 sizeToFit];
    [self.scrollView addSubview:contentLabel2];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.textField2 resignFirstResponder];
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

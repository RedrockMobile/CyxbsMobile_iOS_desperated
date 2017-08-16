//
//  MilitaryTrainingTipsViewController.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2017/8/13.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "MilitaryTrainingCell.h"
#import "MilitaryTrainingTipsViewController.h"

@interface MilitaryTrainingTipsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;

@end

@implementation MilitaryTrainingTipsViewController

//用到的时候才加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 47 - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return _tableView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = @[@"饮食篇", @"防晒篇", @"药品篇", @"其它"];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 400;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"MilitaryTraining";
    MilitaryTrainingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MilitaryTrainingCell" owner:nil options:nil] lastObject];
    }
    cell.grayView.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
    cell.blueView.backgroundColor = [UIColor colorWithRed:88/255.0 green:177/255.0 blue:252/255.0 alpha:1];
    cell.blueView.layer.cornerRadius = 2;
    cell.titleLabel.font = [UIFont systemFontOfSize:15.0];
    cell.titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.contentLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        NSString *str1 = @"1.早餐一定要吃好，午餐一定要吃饱，晚餐要吃得适宜。军训时饭量会增大，不想发胖的妹子在晚饭时一定要管好自己的嘴巴；由于天气比较炎热，也会有一些同学吃不下饭，建议多少吃点，军训体力消耗很大，以免身体不适。\n\n2.多吃富含多种维生素的水果蔬菜，可以淡化黑色素，在一定程度上起到美白的效果。\n\n3.饮用水、运动饮料（军训期间会大量流汗，适量补充水分很重要，建议可以喝一些葡萄糖水。）\n\n4.少吃冰的东西（军训期间天气会比较炎热，降暑很有必要，但是要少吃冰的东西，以免引起肠胃的不舒服。）";
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:str1];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:10];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str1 length])];
        [cell.contentLabel setAttributedText:attributedString1];
        [cell.contentLabel sizeToFit];
    }
    else if (indexPath.row == 1) {
        NSString *str1 = @"1军训防晒是最重要的环节，不管是男生还是女生，都一定要注意防晒，因为防晒不仅是要防晒，更是要防晒伤。\n\n2.防晒霜、防晒喷雾(最好买SPF50、PA+++的，SPF是防晒黑指数，PA是防晒伤指数，军训时长时间在烈日下暴晒，用指数高的比较适宜。出门前半个小时就要涂，因为防晒霜也要时间吸收。可以随身携带防晒霜，军训时出汗多，可以定时补涂一次。防晒霜的涂抹位置最好是脸部、脖子以及所有穿上军训服后能够漏出来的地方。）\n\n3.湿纸巾、吸油面纸（擦汗必备，擦完脸再涂上防晒霜。）\n\n4.润唇膏(可选择一些带有防晒指数的)\n\n5.晒后修复(可以用芦荟胶或大瓶化妆水做水膜，也可以直接敷保湿面膜。)";
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:str1];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:10];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str1 length])];
        [cell.contentLabel setAttributedText:attributedString1];
        [cell.contentLabel sizeToFit];
    } else if (indexPath.row == 2) {
        NSString *str1 = @"1.防暑药（藿香正气水等）\n\n2.花露水、驱蚊水（晚上军训时会有一些蚊虫，备上以防止叮咬）\n\n3.风油精(提神醒脑。军训时需要早起，有些同学可能会睡眠不足，可以起到提神的功效。此外，风油精也会让人觉得特别清凉。)\n\n4.维C片、维E片(补充维生素，淡化黑色素，美白皮肤。)\n\n5.创可贴、棉签、碘伏(创可贴要随身带几枚，以备不时之需。)";
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:str1];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:10];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str1 length])];
        [cell.contentLabel setAttributedText:attributedString1];
        [cell.contentLabel sizeToFit];
    } else if (indexPath.row == 3) {
        NSString *str1 = @"1.吸汗速干衣（有的军训服是不吸汗的，穿一件吸汗速干衣作为打底衫会舒服一点。）\n\n2.发绳、发卡(军训时注重仪容仪表，长头发需要绑起来，刘海需要别起来，另外发卡也是卡帽子神器。)\n\n3.厚鞋垫、卫生巾（军训发的鞋子会有点硬，大家请备好厚鞋垫或是垫鞋子的卫生巾。卫生巾可以吸汗，垫着也会更软一点，鞋子穿着了，站军姿、踢正步时会更有力量呐）\n\n4.运动袜（舒适、吸汗。另外，参加走方阵的同学按要求要穿深色的袜子。）\n\n5.零钱（随身带零钱，以备不时之需）\n\n6.泡脚（军训训练强度会比较大，用热水泡脚既解乏，又利于睡眠）";
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:str1];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:10];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str1 length])];
        [cell.contentLabel setAttributedText:attributedString1];
        [cell.contentLabel sizeToFit];
    }
    
    if ([UIScreen mainScreen].bounds.size.width <= 330) {
        cell.contentLabel.font = [UIFont systemFontOfSize:10];
    }
    else {
        cell.contentLabel.font = [UIFont systemFontOfSize:13.0];
    }
    
    return cell;
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

//
//  MilitarytrainingTipsViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "MilitarytrainingTipsViewController.h"

@interface MilitarytrainingTipsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@end

@implementation MilitarytrainingTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小贴士";
    NSString *str1 = @"1.军训期间请假遵循一事一请假的原则，无特殊事由不得请假；\n2.学生在军训场上感到不适，可直接通过“打报告”的形式向教官请假，在训练场边暂时休息；\n3.请假半天以下的由军训排排长经商辅导员同意后批准；\n4.请假半天以上，3天以下的，由学生本人提出书面申请（请假条见附页），经辅导员签字后报校武装部审批，并由学生本人将审批后的申请交军训排排长实施；\n5.请假3天以上的需报请军训师领导同意；\n6.请假须外出的，须详细说明原因，并定期向辅导员报告动态；\n7.请假时间累计原则上不得超过军训时间的1/3（即5天）；\n8.如有其他特殊原因请假超过5天的，须专门报请军训师批准。";
         NSString *str2 =@"1.早饭建议多多补充蛋白质和维生素，水果尽量选用能提高防晒能力的，譬如番茄，西瓜，蓝莓柑橘等VC含量高的，避免芹菜，柠檬，白萝卜这种感光的蔬菜。\n2.军训基本处于脱水状态，建议补充些盐水平衡体内电解质避免皮肤抵抗力的下降。军训期间提供接水处，学生可自带水杯。\n3.夜间训练建议携带驱蚊水，可有效减少蚊子的叮咬。\n4.倘若皮肤晒伤，要加以保护措施避免反复晒伤，晒伤的地方进行冷敷处理或者浸泡在凉水里。可在晒伤处涂抹保湿乳液，不要使用霜，软膏等质地过于浓稠的护肤品，切记不要挤破水泡。\n5.军姿站立时间过久脚肿是由于静脉回流不通畅导致的，建议军训休息时间多多活动双脚，晚上按摩，泡脚时冷热水交替，睡觉的时候垫高腿。";
    [_contentview layoutIfNeeded];
    [_scrollview layoutIfNeeded];
    //[_contentview layoutSubviews];
     CGFloat label1Hetght = [self calculateRowHeight:str1 fontSize:14];
    _label1.height = label1Hetght  ;
    //_label1.width = _scrollview.width;
    [_label1 setNumberOfLines:0];
    _label1.lineBreakMode = NSLineBreakByWordWrapping;
    _label1.text = [[NSString alloc]initWithFormat:@"%@", str1];
    [_label1 layoutIfNeeded];
    
    CGFloat label2Hetght = [self calculateRowHeight:str2 fontSize:14];
    //self.contentview.backgroundColor = [UIColor whiteColor];
    //_label2.width = _scrollview.width;
    _label2.height = label2Hetght ;
    [_label2 setNumberOfLines:0];
    _label2.lineBreakMode = NSLineBreakByWordWrapping;
    _label2.text = [[NSString alloc]initWithFormat:@"%@", str2];
    [_label2 layoutIfNeeded];
    
    _scrollview.contentSize = CGSizeMake(0, 60*autoSizeScaleY + label1Hetght + label2Hetght);
    [self.view layoutSubviews];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(self.contentview.width, 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}



@end

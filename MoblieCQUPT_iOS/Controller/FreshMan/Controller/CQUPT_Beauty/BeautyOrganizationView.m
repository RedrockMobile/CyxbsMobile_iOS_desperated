//
//  BeautyOrganizationView.m
//  FreshManFeature
//
//  Created by hzl on 16/8/12.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "BeautyOrganizationView.h"

#define maxScreenHeight [UIScreen mainScreen].bounds.size.height
#define maxScreenWdith [UIScreen mainScreen].bounds.size.width

#define titleHeight ([UIScreen mainScreen].bounds.size.height - 0.156 * maxScreenHeight)/7.0
#define titleWidth 0.168 * maxScreenWdith

@interface BeautyOrganizationView ()<UIScrollViewDelegate>

@property (nonatomic, copy)NSArray *IntroduceArray;

@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) NSArray<NSString *> *titles;

@property (strong, nonatomic) NSMutableArray<UIButton *> *btnArray;

@property (assign, nonatomic) NSInteger currentIndex;

@property (strong, nonatomic) UIButton *currentSelectBtn;

@end

@implementation BeautyOrganizationView


- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        _titles = [[NSArray<NSString *> alloc]initWithArray:titles];
        [self initWithTitleView];
        [self initWithScrollView];
        [self clickBtn:_btnArray[0]];
    }
    return self;
}

- (void)initWithTitleView {
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

    
    backgroundView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    
    _btnArray = [NSMutableArray<UIButton *> array];
    for (int i = 0; i < _titles.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, i * titleHeight , titleWidth, titleHeight);
        
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        btn.titleLabel.lineBreakMode = NO;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0.027 * maxScreenWdith,0.015 * maxScreenHeight,0.027 * maxScreenWdith,0.015 * maxScreenHeight);
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:btn.titleLabel.text];
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:0.001 * maxScreenHeight];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [btn.titleLabel.text length])];
        [btn.titleLabel setAttributedText:attributedString1];
        
        [btn.titleLabel sizeToFit];
        
        
        btn.tag = i;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [backgroundView addSubview:btn];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            _currentSelectBtn = btn;
            btn.selected = YES;
        }
        [_btnArray addObject:btn];
    }
    [self addSubview:backgroundView];
    
}

- (void)initWithScrollView {
    [self creatIntroduce];
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(titleWidth+0.015*maxScreenWdith, 0, [UIScreen mainScreen].bounds.size.width - titleWidth-0.088 * maxScreenWdith, [UIScreen mainScreen].bounds.size.height-114)];
    
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height * _titles.count);
    
    _mainScrollView.scrollEnabled = NO;
    _mainScrollView.delegate = self;
    
    for (int i = 0; i < _titles.count; i++) {
        UITextView *introduceText = [[UITextView alloc] initWithFrame:CGRectZero];
        introduceText.textColor = [UIColor colorWithRed:91/255.0 green:91/255.0 blue:91/255.0 alpha:1];
        introduceText.font = [UIFont systemFontOfSize:13];
        introduceText.text = _IntroduceArray[i];
        introduceText.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        introduceText.editable = NO;
        introduceText.scrollEnabled = YES;
                
        introduceText.frame = CGRectMake(titleWidth+0.015*maxScreenWdith, i * ([UIScreen mainScreen].bounds.size.height), [UIScreen mainScreen].bounds.size.width - titleWidth-0.088 * maxScreenWdith, _mainScrollView.bounds.size.height);
        
        [_mainScrollView addSubview:introduceText];
    }
    
    [self addSubview:self.mainScrollView];
    
}

- (void)clickBtn:(UIButton *)sender {
    [UIView animateWithDuration:0.2f animations:^{
        for (int i = 0;i < _btnArray.count;i++)
        {
            _btnArray[i].backgroundColor = [UIColor whiteColor];
        }
        _mainScrollView.contentOffset = CGPointMake(titleWidth, sender.tag * ([UIScreen mainScreen].bounds.size.height));
        sender.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        _currentSelectBtn.selected = NO;
        _currentSelectBtn = sender;
        _currentSelectBtn.selected = YES;
    } completion:nil];
}


- (void)creatIntroduce
{
    NSError *error = nil;
    
    NSString *txtpath1 = [[NSBundle mainBundle] pathForResource:@"团委" ofType:@"txt"];
    NSString *txtpath2 = [[NSBundle mainBundle] pathForResource:@"学生会" ofType:@"txt"];
    NSString *txtpath3 = [[NSBundle mainBundle] pathForResource:@"科联" ofType:@"txt"];
    NSString *txtpath4 = [[NSBundle mainBundle] pathForResource:@"社联" ofType:@"txt"];
    NSString *txtpath5 = [[NSBundle mainBundle] pathForResource:@"青协" ofType:@"txt"];
    NSString *txtpath6 = [[NSBundle mainBundle] pathForResource:@"大艺团" ofType:@"txt"];\
    NSString *txtpath7 = [[NSBundle mainBundle] pathForResource:@"红岩网校工作站简介" ofType:@"txt"];
    
    NSString *ylcIntroduce = [NSString stringWithContentsOfFile:txtpath1 encoding:NSUTF8StringEncoding error:&error];
    NSString *stoIntroduce = [NSString stringWithContentsOfFile:txtpath2 encoding:NSUTF8StringEncoding error:&error];
    NSString *scoIntroduce = [NSString stringWithContentsOfFile:txtpath3 encoding:NSUTF8StringEncoding error:&error];
    NSString *sogIntroduce = [NSString stringWithContentsOfFile:txtpath4 encoding:NSUTF8StringEncoding error:&error];
    NSString *svoIntroduce = [NSString stringWithContentsOfFile:txtpath5 encoding:NSUTF8StringEncoding error:&error];
    NSString *saoIntroduce = [NSString stringWithContentsOfFile:txtpath6 encoding:NSUTF8StringEncoding error:&error];
     NSString *rrkIntroduce = [NSString stringWithContentsOfFile:txtpath7 encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
    {
        NSLog(@"读写文件错误 %@",error);
    }
    
    _IntroduceArray = @[ylcIntroduce,rrkIntroduce,stoIntroduce,scoIntroduce,sogIntroduce,svoIntroduce,saoIntroduce];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

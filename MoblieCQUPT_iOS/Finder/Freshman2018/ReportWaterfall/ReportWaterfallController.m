//
//  ReportWaterfallController.m
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/12.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "ReportWaterfallController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"



#define width [UIScreen mainScreen].bounds.size.width//宽
#define height [UIScreen mainScreen].bounds.size.height//高

@interface ReportWaterfallController ()

@end

NSString *str01;
NSString *str02;
NSString *str03;
NSString *str04;

@implementation ReportWaterfallController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewInit) name:@"saveSuccessful" object:nil];
    
    //标题文字
    self.title = @"报道流程";
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackGround"]];

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, width, height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.bounces = YES;
    //画布大小
    _scrollView.contentSize = CGSizeMake(width, height - 60 + (height - 100) / 2 + 100);
    [self.view addSubview:_scrollView];
    
    //网络请求
    [self getTheData];
    
    //初始化体育馆/宿舍/支付
    _view01 = [[UIView alloc] init];
    _view02 = [[UIView alloc] init];
    _view03 = [[UIView alloc] init];
    _label01 = [[UILabel alloc] init];
    _label03 = [[UILabel alloc] init];
    _label02 = [[UILabel alloc] init];
    _label04 = [[UILabel alloc] init];
    _label05 = [[UILabel alloc] init];
    _label06 = [[UILabel alloc] init];
    _button01 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button02 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button03 = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageView01 = [[UIImageView alloc] init];
    _imageView02 = [[UIImageView alloc] init];
    _imageView03 = [[UIImageView alloc] init];
    _imageView04 = [[UIImageView alloc] init];
    _imageView05 = [[UIImageView alloc] init];
    _imageView06 = [[UIImageView alloc] init];
    
    //[self viewInit];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
    self.callBackHandle();
}

- (void)viewInit
{
    //体育馆
    _view01.frame = CGRectMake(0, 0, width, (height - 100) / 2);
    _view01.backgroundColor = [UIColor clearColor];
    _label01.frame = CGRectMake(20, 10, 200, 30);
    _label01.text = _arrayData01[0];
    _label03.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
    _label03.text = @"点击按钮，查看具体流程";
    _label03.numberOfLines = 0;
    
    //设置字体样式
    _label01.font = [UIFont fontWithName:@"AaPangYaer" size:19.f];
    _label03.font = [UIFont fontWithName:@"AaPangYaer" size:19.f];

    _imageView01.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
    [_imageView01 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.yyeke.com/welcome2018%@",_arr[0]]] placeholderImage:nil];
    _imageView02.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
    [_imageView02 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.yyeke.com/welcome2018%@",_arr[1]]] placeholderImage:nil];
    
    //圆角处理
    _imageView01.layer.cornerRadius = 20;
    _imageView01.layer.masksToBounds = YES;
    _imageView02.layer.cornerRadius = 20;
    _imageView02.layer.masksToBounds = YES;
    
    [_view01 addSubview:_label01];
    [_view01 addSubview:_label03];
    [_view01 addSubview:_imageView01];
    [_view01 addSubview:_imageView02];

    //寝室
    _view02.frame = CGRectMake(0, (height - 100) / 2 + 40, width, (height - 100) / 2);
    _view02.backgroundColor = [UIColor clearColor];
    _label02.frame = CGRectMake(20, 10, 200, 30);
    _label02.text = _arrayData01[1];
    _label04.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
    _label04.text = @"点击按钮，查看具体流程";
    _label04.numberOfLines = 0;

    //设置字体样式
    _label02.font = [UIFont fontWithName:@"AaPangYaer" size:19.f];
    _label04.font = [UIFont fontWithName:@"AaPangYaer" size:19.f];
    
    _imageView03.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
    [_imageView03 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.yyeke.com/welcome2018%@",_arr[2]]] placeholderImage:nil];
    _imageView04.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
    [_imageView04 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.yyeke.com/welcome2018%@",_arr[3]]] placeholderImage:nil];
    
    //圆角处理
    _imageView03.layer.cornerRadius = 20;
    _imageView03.layer.masksToBounds = YES;
    _imageView04.layer.cornerRadius = 20;
    _imageView04.layer.masksToBounds = YES;
    
    [_view02 addSubview:_label02];
    [_view02 addSubview:_label04];
    [_view02 addSubview:_imageView03];
    [_view02 addSubview:_imageView04];

    //支付
    _view03.frame = CGRectMake(0, ((height - 100) / 2 + 40) * 2, width, (height - 100) / 2);
    _view03.backgroundColor = [UIColor clearColor];
    _label05.frame = CGRectMake(20, 10, 200, 30);
    _label05.text = _arrayData01[2];
    _label06.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
    _label06.text = @"点击按钮，查看具体流程";
    _label06.numberOfLines = 0;
    
    //设置字体样式
    _label05.font = [UIFont fontWithName:@"AaPangYaer" size:19.f];
    _label06.font = [UIFont fontWithName:@"AaPangYaer" size:19.f];
    
    _imageView05.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
    [_imageView05 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.yyeke.com/welcome2018%@",_arr[4]]] placeholderImage:nil];
    _imageView06.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
    [_imageView06 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.yyeke.com/welcome2018%@",_arr[5]]] placeholderImage:nil];
    
    //圆角处理
    _imageView05.layer.cornerRadius = 20;
    _imageView05.layer.masksToBounds = YES;
    _imageView06.layer.cornerRadius = 20;
    _imageView06.layer.masksToBounds = YES;
    
    
    //开启交互模式
    _imageView01.userInteractionEnabled = YES;
    _imageView01.tag = 1;
    _imageView02.userInteractionEnabled = YES;
    _imageView02.tag = 2;
    _imageView03.userInteractionEnabled = YES;
    _imageView03.tag = 3;
    _imageView04.userInteractionEnabled = YES;
    _imageView04.tag = 4;
    _imageView05.userInteractionEnabled = YES;
    _imageView05.tag = 5;
    _imageView06.userInteractionEnabled = YES;
    _imageView06.tag = 6;
    
    //添加点击手势
    UITapGestureRecognizer *tapGesture01 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    UITapGestureRecognizer *tapGesture02 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    UITapGestureRecognizer *tapGesture03 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    UITapGestureRecognizer *tapGesture04 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    UITapGestureRecognizer *tapGesture05 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    UITapGestureRecognizer *tapGesture06 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_imageView01 addGestureRecognizer:tapGesture01];
    [_imageView02 addGestureRecognizer:tapGesture02];
    [_imageView03 addGestureRecognizer:tapGesture03];
    [_imageView04 addGestureRecognizer:tapGesture04];
    [_imageView05 addGestureRecognizer:tapGesture05];
    [_imageView06 addGestureRecognizer:tapGesture06];
    
    [_view03 addSubview:_label05];
    [_view03 addSubview:_label06];
    [_view03 addSubview:_imageView05];
    [_view03 addSubview:_imageView06];
    
    
    //体育馆button01
    _button01.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
    [_button01 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [_view01 addSubview:_button01];
    _button01.tag = 0;
    [_button01 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];

    //宿舍button02
    _button02.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
    [_button02 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [_view02 addSubview:_button02];
    _button02.tag = 1;
    [_button02 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //支付button
    _button03.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
    [_button03 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [_view03 addSubview:_button03];
    _button03.tag = 2;
    [_button03 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    

    [_scrollView addSubview:_view01];
    [_scrollView addSubview:_view02];
    [_scrollView addSubview:_view03];
}

- (void)tapAction:(UIGestureRecognizer *)gesture
{
    self.navigationController.navigationBar.hidden = YES;
    //创建黑色背景
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _Img = view;
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    if (gesture.view.tag == 1)
    {
        _imageView01.frame = CGRectMake(0, (height - width) / 2, width, width);
        [view addSubview:_imageView01];
        _imageView01.userInteractionEnabled = YES;
        NSLog(@"_imageView01 touched");
        //添加点击手势（即点击图片后退出全屏）
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
        [_imageView01 addGestureRecognizer:tapGesture];
        
        [self shakeToShow:view];
    }
    else if (gesture.view.tag == 2)
    {
        _imageView02.frame = CGRectMake(0, (height - width) / 2, width, width);
        [view addSubview:_imageView02];
        _imageView02.userInteractionEnabled = YES;
        NSLog(@"_imageView01 touched");
        //添加点击手势（即点击图片后退出全屏）
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
        [_imageView02 addGestureRecognizer:tapGesture];
        
        [self shakeToShow:view];
    }
    else if (gesture.view.tag == 3)
    {
        _imageView03.frame = CGRectMake(0, (height - width) / 2, width, width);
        [view addSubview:_imageView03];
        _imageView03.userInteractionEnabled = YES;
        NSLog(@"_imageView01 touched");
        //添加点击手势（即点击图片后退出全屏）
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
        [_imageView03 addGestureRecognizer:tapGesture];
        
        [self shakeToShow:view];
    }
    else if (gesture.view.tag == 4)
    {
        _imageView04.frame = CGRectMake(0, (height - width) / 2, width, width);
        [view addSubview:_imageView04];
        _imageView04.userInteractionEnabled = YES;
        NSLog(@"_imageView01 touched");
        //添加点击手势（即点击图片后退出全屏）
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
        [_imageView04 addGestureRecognizer:tapGesture];
        
        [self shakeToShow:view];
    }
    else if (gesture.view.tag == 5)
    {
        _imageView05.frame = CGRectMake(0, (height - width) / 2, width, width);
        [view addSubview:_imageView05];
        _imageView05.userInteractionEnabled = YES;
        NSLog(@"_imageView01 touched");
        //添加点击手势（即点击图片后退出全屏）
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
        [_imageView05 addGestureRecognizer:tapGesture];
        
        [self shakeToShow:view];    }
    else if (gesture.view.tag == 6)
    {
        _imageView06.frame = CGRectMake(0, (height - width) / 2, width, width);
        [view addSubview:_imageView06];
        _imageView06.userInteractionEnabled = YES;
        NSLog(@"_imageView01 touched");
        //添加点击手势（即点击图片后退出全屏）
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
        [_imageView06 addGestureRecognizer:tapGesture];
        
        [self shakeToShow:view];
    }
}

- (void)closeView
{
    self.navigationController.navigationBar.hidden = NO;
    //[self.navigationController popViewControllerAnimated:YES];
    [_Img removeFromSuperview];
    
    //画布大小
    _scrollView.contentSize = CGSizeMake(width, height - 60 + (height - 100) / 2 + 100);
    [self viewInit];
}


//放大过程中出现的缓慢动画
- (void) shakeToShow:(UIView *)aView{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

- (void)pressBtn:(UIButton *)btn
{
    if (btn.tag == 0)
    {
        _scrollView.contentSize = CGSizeMake(width, height * 3 / 2 - 10 + (height - 100) / 2 + 40);
        _view01.frame = CGRectMake(0, 0, width, height - 60);
        _label03.text = _arrayData02[0];
        _label03.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, height - 60 - (height - 100) / 2 * 3 / 4 - 60);
//        _label03.numberOfLines = 0;
        NSLog(@"%@",_arrayData02[0]);
        [_button01 setImage:[UIImage imageNamed:@"upBtn"] forState:UIControlStateNormal];
        _button01.frame = CGRectMake(width / 2 - 15, height - 120, 30, 30);
        _button01.tag = 3;
        [_button01 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //宿舍位置复原
        _view02.frame = CGRectMake(0, height - 20, width, (height - 100) / 2);
        _label04.text = @"点击按钮，查看具体流程";
        _label04.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
        _imageView03.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _imageView04.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _button02.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
        [_button02 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        _button02.tag = 1;
        
        //支付位置复原
        _view03.frame = CGRectMake(0, height - 20 + (height - 100) / 2 + 40, width, (height - 100) / 2);
        _label06.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
        _label06.text = @"点击按钮，查看具体流程";
        _imageView05.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _imageView06.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _button03.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
        [_button03 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        _button03.tag = 2;
        
    }
    else if (btn.tag == 1)
    {
        _scrollView.contentSize = CGSizeMake(width, height * 3 / 2 - 10 + (height - 100) / 2 + 40);
        _view02.frame = CGRectMake(0, (height - 100) / 2 + 40, width, height - 60);
        _label04.text = _arrayData02[1];
        _label04.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, height - 60 - (height - 100) / 2 * 3 / 4 - 60);
//        _label04.numberOfLines = 0;
        //NSLog(@"%@",_arrayData02[1]);
        _button02.frame = CGRectMake(width / 2 - 15, height - 120, 30, 30);
        [_button02 setImage:[UIImage imageNamed:@"upBtn"] forState:UIControlStateNormal];
        _button02.tag = 3;
        [_button02 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //体育馆位置复原
        _view01.frame = CGRectMake(0, 0, width, (height - 100) / 2);
        _label03.text = @"点击按钮，查看具体流程";
        _label03.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
        _imageView01.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _imageView02.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _button01.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
        [_button01 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        _button01.tag = 0;
        
        //支付位置复原
        _view03.frame = CGRectMake(0, (height - 100) / 2 + 40 + height - 60 + 40, width, (height - 100) / 2);
        _label06.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
        _label06.text = @"点击按钮，查看具体流程";
        _imageView05.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _imageView06.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _button03.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
        [_button03 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        _button03.tag = 2;
    }
    else if (btn.tag == 3)
    {
        _scrollView.contentSize = CGSizeMake(width, height - 60 + (height - 100) / 2 + 100);
        
        //体育馆位置复原
        _view01.frame = CGRectMake(0, 0, width, (height - 100) / 2);
        _label03.text = @"点击按钮，查看具体流程";
        _label03.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
        _imageView01.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _imageView02.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _button01.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
        [_button01 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        _button01.tag = 0;
        
        //宿舍位置复原
        _view02.frame = CGRectMake(0, (height - 100) / 2 + 40, width, (height - 100) / 2);
        _label04.text = @"点击按钮，查看具体流程";
        _label04.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
        _imageView03.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _imageView04.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _button02.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
        [_button02 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        _button02.tag = 1;
        
        //支付位置复原
        _view03.frame = CGRectMake(0, ((height - 100) / 2 + 40) * 2, width, (height - 100) / 2);
        _label06.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
        _label06.text = @"点击按钮，查看具体流程";
        _imageView05.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _imageView06.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _button03.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
        [_button03 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        _button03.tag = 2;
    }
    else if (btn.tag == 2)
    {
        _scrollView.contentSize = CGSizeMake(width, height * 3 / 2 - 10 + (height - 100) / 2 + 40);
        
        //体育馆位置复原
        _view01.frame = CGRectMake(0, 0, width, (height - 100) / 2);
        _label03.text = @"点击按钮，查看具体流程";
        _label03.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
        _imageView01.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _imageView02.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _button01.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
        [_button01 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        _button01.tag = 0;
        
        //宿舍位置复原
        _view02.frame = CGRectMake(0, (height - 100) / 2 + 40, width, (height - 100) / 2);
        _label04.text = @"点击按钮，查看具体流程";
        _label04.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
        _imageView03.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _imageView04.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _button02.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
        [_button02 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        _button02.tag = 1;
        
        //支付位置
        _view03.frame = CGRectMake(0, ((height - 100) / 2 + 40) * 2, width, height - 60);
        _label06.text = _arrayData02[1];
        _label06.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, height - 60 - (height - 100) / 2 * 3 / 4 - 60);
        _button03.frame = CGRectMake(width / 2 - 15, height - 120, 30, 30);
        [_button03 setImage:[UIImage imageNamed:@"upBtn"] forState:UIControlStateNormal];
        _button03.tag = 3;
        [_button03 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

//网络请求

- (void)getTheData
{
    
    AFHTTPSessionManager *session02 = [AFHTTPSessionManager manager];
    
    NSString *path02 = @"http://wx.yyeke.com/welcome2018/data/get/byindex?index=报道流程&pagenum=1&pagesize=3";
    
    //中文转码
    path02 = [path02 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"%@",path02);
    [session02 GET:path02 parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"下载成功！");
        
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"dic = %@",responseObject);
            
            [self parseData:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        NSLog(@"下载失败！");
    }];
}

//解析数据
- (void)parseData:(NSDictionary *)dicData
{
    NSArray *arrayEntry = [dicData objectForKey:@"array"];
    //获取name;
    _arrayData01 = [[NSMutableArray alloc] init];
    //获取content
    _arrayData02 = [[NSMutableArray alloc] init];
    
    _arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arrayEntry)
    {
        [_arrayData01 addObject:[dic objectForKey:@"name"]];
        NSLog(@"%@",[dic objectForKey:@"name"]);
        
    
        [_arrayData02 addObject:[dic objectForKey:@"content"]];
        NSLog(@"%@",[dic objectForKey:@"content"]);
        
        _arrayData03 = [dic objectForKey:@"picture"];
        NSLog(@"%@ + hello",_arrayData03);
        [_arr addObject:_arrayData03[0]];
        [_arr addObject:_arrayData03[1]];
        //NSLog(@"%@ + %@",_arrayData03[0],_arrayData03[1]);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveSuccessful" object:self];

}

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

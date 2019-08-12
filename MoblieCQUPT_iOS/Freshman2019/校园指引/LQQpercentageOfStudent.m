//
//  LQQpercentageOfStudent.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/7.
//  Copyright © 2019 Orange-W. All rights reserved.
//
#import "LQQchooseCollegeViewController.h"
#import "LQQpercentageOfStudent.h"
@interface LQQpercentageOfStudent ()
{
    CGFloat percentageOfman;//男生所占百分比的小数形式
    NSTimer *timer;
    UIBezierPath *circlePath;
    CAShapeLayer*layer;
    int end;
    /*LQQ*/
    UIBezierPath *circlePath0;
    CAShapeLayer*layer0;
    int end0;
    NSString*userXueYuan;
}
@end
@implementation LQQpercentageOfStudent
- (instancetype)initWithArray:(NSArray<NSString *> *)biLiArray userXueYuan:(nonnull NSString *)xueYuan
{
    self = [super init];
    if (self) {
        _biliArray = biLiArray;
//        NSLog(@"QLLQ%@",_biliArray);
        percentageOfman = [[biLiArray[0] substringToIndex:2] floatValue]*0.01;
        userXueYuan = xueYuan;
    }
    return self;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    end=0;
    end0 = 0;
    [self draw];
    if (!timer)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                 target:self
                                               selector:@selector(updateLayer)
                                               userInfo:nil
                                                repeats:YES];
    }
    
    UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shuJuJieMiMan0.1"]];
        UIImageView*imageView0 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shuJuJieMiWoman0.1"]];
    UILabel*title = [[UILabel alloc]init];

    [self addSubview:imageView];
    [self addSubview:imageView0];
    [self addSubview:title];

    title.text =[NSString stringWithFormat:@"%@男女比例",userXueYuan];
    
    title.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15.0f];
    [title setTextColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.75f]];
//    self.backgroundColor = [UIColor redColor];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(35);
            make.top.equalTo(self).offset(35);
//            make.centerX.equalTo(self).offset(-self.width);
//            make.centerY.equalTo(self);
            make.width.equalTo(self).multipliedBy(120.0/750);
            make.height.equalTo(self.mas_width).multipliedBy(45.0/750);
        }];
    [imageView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView);
        make.top.equalTo(imageView.mas_bottom).offset(15);
        make.height.equalTo(imageView);
        make.width.equalTo(imageView);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView);
        make.bottom.equalTo(imageView.mas_top).offset(-15);
    }];
    
}
- (void)updateLayer
{
    //起始点为0，结束点不断增加，圆的弧线越来越长，到结束点闭合就变成了圆，我们这里按贝斯阿尔曲线路径到结束点为一扇形
    if ( end < 10)
    {
        end ++;
    }
    else
    {
        [timer invalidate];
    }
    layer.strokeEnd = end/10.0;
    
    if ( end0 < 10)
    {
        end0 ++;
    }
    else
    {
        [timer invalidate];
    }
    layer0.strokeEnd = end0/10.0;
}
- (void)draw
{
    layer0 = [CAShapeLayer layer];
    self.backgroundColor = [UIColor whiteColor];
    layer0.lineWidth = 1*self.frame.size.width*220.0/750;
    //拐角设置
    layer0.lineCap = kCALineCapButt;
    //绘制的线的颜色
    layer0.strokeColor = [[UIColor colorWithRed:105/255.0 green:203/255.0 blue:247/255.0 alpha:1] CGColor];
    layer0.fillColor = nil;
    layer0.strokeStart=0;
    layer0.strokeEnd=end/10;
    [self.layer addSublayer:layer0];
    //用贝塞尔曲线来画扇形，实际上画的是圆，因为半径为边线中间到原点的距离，所以设置半径为线宽的一半，这样线宽就覆盖了中间填充部分的颜色，形成扇形
    UIBezierPath *bezierPath0=[UIBezierPath bezierPathWithArcCenter:CGPointMake((self.frame.size.width)/2+6, (self.frame.size.height)/2) radius:0.5*self.frame.size.width*220.0/750 startAngle:M_PI_2 endAngle:percentageOfman*2*M_PI+M_PI_2 clockwise:NO];
    
    layer0.path = bezierPath0.CGPath;
    
    
    
    layer = [CAShapeLayer layer];
    //这里设置填充线的宽度，这个参数很重要
    layer.lineWidth = 1*self.frame.size.width*220.0/750;
    //拐角设置
    layer.lineCap = kCALineCapButt;
    //绘制的线的颜色
    layer.strokeColor = [[UIColor colorWithRed:253/255.0 green:137/255.0 blue:190/255.0 alpha:1] CGColor];
    layer.fillColor = nil;
    layer.strokeStart=0;
    layer.strokeEnd=end/10;
    [self.layer addSublayer:layer];
    //用贝塞尔曲线来画扇形，实际上画的是圆，因为半径为边线中间到原点的距离，所以设置半径为线宽的一半，这样线宽就覆盖了中间填充部分的颜色，形成扇形
    UIBezierPath *bezierPath=[UIBezierPath bezierPathWithArcCenter:CGPointMake((self.frame.size.width)/2+6, (self.frame.size.height)/2) radius:0.5*self.frame.size.width*220.0/750 startAngle:M_PI_2 endAngle:percentageOfman*2*M_PI+M_PI_2 clockwise:YES];
    
    
    
    
    

    
    CGRect rect = [self getEndPointFrameWithProgress:percentageOfman*2*M_PI+M_PI_2-M_PI_2];
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, 10, 10)];
    view.backgroundColor = [UIColor redColor];
//    [self addSubview:view];
    
    layer.path = bezierPath.CGPath;
}
-(CGRect)getEndPointFrameWithProgress:(float)angle//获取终点坐标
{

    float radius = 0.5*self.frame.size.width*220.0/750;
    int index = (angle)/M_PI_2;//用户区分在第几象限内
    float needAngle = angle - index*M_PI_2;//用于计算正弦/余弦的角度
    float x = 0,y = 0;//用于保存_dotView的frame
    switch (index) {
        case 0:
            NSLog(@"第一象限");
            x = radius + sinf(needAngle)*radius;
            y = radius - cosf(needAngle)*radius;
            break;
        case 1:
            NSLog(@"第二象限");
            x = radius + cosf(needAngle)*radius;
            y = radius + sinf(needAngle)*radius;
            break;
        case 2:
            NSLog(@"第三象限");
            x = radius - sinf(needAngle)*radius;
            y = radius + cosf(needAngle)*radius;
            break;
        case 3:
            NSLog(@"第四象限");
            x = radius - cosf(needAngle)*radius;
            y = radius - sinf(needAngle)*radius;
            break;
            
        default:
            break;
    }
    CGRect rect;
    rect.origin.x = x;
    rect.origin.y = y;
    return  rect;
}
    
@end

//
//  QuerCircleView.m
//  Query
//
//  Created by hzl on 2017/3/1.
//  Copyright © 2017年 c. All rights reserved.
//

#import "QuerCircleView.h"
#import "PointingCircleView.h"
#import "AppDelegate.h"

#define font(R) (R)*([UIScreen mainScreen].bounds.size.width)/375.0

CG_INLINE CGRect
CHANGE_CGRectMake(CGFloat x, CGFloat y,CGFloat width,CGFloat height){

    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleY;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}

//#define  DEGREES_TO_RADIANS(angle) ((M_PI * angle) / 180)

@interface QuerCircleView ()

//日均量显示标签
@property (nonatomic, strong) UILabel *avergaeElecLabel;

//电费数据显示标签
@property (nonatomic, strong) UILabel *centerLabel;

//度数显示标签
@property (nonatomic, strong) UILabel *elcLabel;

//月优惠显示标签
@property (nonatomic, strong) UILabel *freeElcLabel;

//电起度显示标签
@property (nonatomic, strong) UILabel *ElcStartLabel;

//电止度显示标签
@property (nonatomic, strong) UILabel *ElcEndLabel;

@property (nonatomic) CGFloat endAngle;
@property (nonatomic) CGPoint centerPoint;

@end

@implementation QuerCircleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.percentage = 0;
    }
    return self;
}

- (NSString *)chargeStr{
    if (!_chargeStr) {
        _chargeStr = [[NSString alloc] init];
    }
    return _chargeStr;
}


- (NSString *)ElectrolysisStr{
    if (!_ElectrolysisStr) {
        _ElectrolysisStr = [[NSString alloc] init];
    }
    return _ElectrolysisStr;
}

- (void)drawRect:(CGRect)rect {
    [self drawLightCircle];
    [self drawDrakCircle];
    [self drawChargeLabelWithData:_chargeStr];
    [self drawChargeUnitLabel];
    [self drawLeftSun];
    [self drawRightSun];
    [self drawMiddleCircle];
    [self drawOutCircle];
    [self drawPointingCircle];
    [self drawElectrolysisLabelWithData:_ElectrolysisStr];
    [self drawElectrolysisUnitLabel];
    [self drawAveragELecWithData:_AveragELecStr];
    [self drawFreeLabelWithData:_FreeElecStr];
    [self drawElcStartLabelWithData:_ElcStarStr];
    [self drawElcEndLabelWithData:_ElcEndStr];
    [self drawAverageElcUnitLabel];
    [self drawFreeElcUnitLabel];
    [self drawELcStartUnitLabel];
    [self drawElcEndUnitLabel];
}

- (void)drawElcEndUnitLabel{
    UILabel *label = [[UILabel alloc] init];
    [self maekLabel:label WithText:@"电止度/度" fontOfSize:font(12) textColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] frame:CHANGE_CGRectMake(295.5,303, 65, 20)];
    [self addSubview:label];
}

- (void)drawELcStartUnitLabel{
    UILabel *label = [[UILabel alloc] init];
    [self maekLabel:label WithText:@"电起度/度" fontOfSize:font(12) textColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] frame:CHANGE_CGRectMake(194.5,303, 65, 20)];
    [self addSubview:label];
}

- (void)drawFreeElcUnitLabel{
    UILabel *label = [[UILabel alloc] init];
    [self maekLabel:label WithText:@"月优惠量/度" fontOfSize:font(12) textColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] frame:CHANGE_CGRectMake(99.5,303, 68, 20)];
    [self addSubview:label];
}

- (void)drawAverageElcUnitLabel{
    UILabel *label = [[UILabel alloc] init];
    [self maekLabel:label WithText:@"日均量/度" fontOfSize:font(12) textColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] frame:CHANGE_CGRectMake(17.5,303, 50, 20)];
    [self addSubview:label];
}

- (void)drawElcEndLabelWithData:(NSString *)data{
    self.ElcEndLabel = [[UILabel alloc] init];
    [self maekLabel:self.ElcEndLabel WithText:data fontOfSize:font(25) textColor:[UIColor colorWithRed:18/255.0 green:185/255.0 blue:255/255.0 alpha:1] frame:CHANGE_CGRectMake(295.5,268, 65, 40)];
    [self addSubview:self.ElcEndLabel];
}

- (void)drawElcStartLabelWithData:(NSString *)data{
    self.ElcStartLabel = [[UILabel alloc] init];
    [self maekLabel:self.ElcStartLabel WithText:data fontOfSize:font(25) textColor:[UIColor colorWithRed:18/255.0 green:185/255.0 blue:255/255.0 alpha:1] frame:CHANGE_CGRectMake(194.5,268, 65, 40)];
    [self addSubview:self.ElcStartLabel];
}

- (void)drawFreeLabelWithData:(NSString *)data{
    self.freeElcLabel = [[UILabel alloc] init];
    [self maekLabel:self.freeElcLabel WithText:data fontOfSize:font(25) textColor:[UIColor colorWithRed:18/255.0 green:185/255.0 blue:255/255.0 alpha:1] frame:CHANGE_CGRectMake(114.5,268, 40, 40)];
    [self addSubview:self.freeElcLabel];
}

- (void)drawAveragELecWithData:(NSString *)data{
    self.avergaeElecLabel = [[UILabel alloc] init];
    [self maekLabel:self.avergaeElecLabel WithText:data fontOfSize:font(25) textColor:[UIColor colorWithRed:18/255.0 green:185/255.0 blue:255/255.0 alpha:1] frame:CHANGE_CGRectMake(24.5,268, 40, 40)];
    [self addSubview:self.avergaeElecLabel];
}

- (void)maekLabel:(UILabel *)label WithText:(NSString *)text fontOfSize:(CGFloat)size textColor:(UIColor *)color frame:(CGRect)frame{
    label.frame = frame;
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:size];
    label.adjustsFontSizeToFitWidth = YES;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.contentMode = UIViewContentModeRedraw;
}

- (void)addAnimationOnLayer:(CAShapeLayer *)layer duration:(CFTimeInterval)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = duration;
    [layer addAnimation:animation forKey:nil];
}


- (void)drawElectrolysisUnitLabel{
    UILabel *elcUnitLable = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(186, 155, 20, 20)];
    elcUnitLable.text = @"度";
    elcUnitLable.textAlignment = NSTextAlignmentCenter;
    elcUnitLable.backgroundColor = [UIColor clearColor];
    elcUnitLable.textColor = self.elcLabel.textColor;
    elcUnitLable.font = [UIFont systemFontOfSize:font(11)];
    elcUnitLable.adjustsFontSizeToFitWidth = YES;
    elcUnitLable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentMode = UIViewContentModeRedraw;
    [self addSubview:elcUnitLable];
}


- (void)drawElectrolysisLabelWithData:(NSString *)data{
    self.elcLabel = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(167.5, 153,20, 23)];
    self.elcLabel.text = data;
    self.elcLabel.textAlignment = NSTextAlignmentLeft;
    self.elcLabel.textColor = [UIColor colorWithRed:147/255.0 green:179/255.0 blue:194/255.0 alpha:1];
    self.elcLabel.backgroundColor = [UIColor clearColor];
    self.elcLabel.font = [UIFont systemFontOfSize:font(15)];
    self.elcLabel.adjustsFontSizeToFitWidth = YES;
    self.elcLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentMode = UIViewContentModeRedraw;
    [self addSubview:self.elcLabel];
}


//刻度圆环
- (void)drawPointingCircle{
    //根据bounds计算中心点
    CGRect bounds = self.bounds;
    CGPoint center;
    CGFloat lunetteRadius = (MIN(bounds.size.width, bounds.size.height) / 2.0) + 6.5;
    ;
    center.x = self.centerPoint.x - lunetteRadius * cos(self.percentage * M_PI);
    center.y = self.centerPoint.y - lunetteRadius * sin(self.percentage * M_PI);
    
    //指定路径
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 1.5;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    
    //这里不知道为啥要设置成逆时针。。。。但是顺时针有问题。。。
    CGPathAddArc(curvedPath, NULL, self.centerPoint.x, self.centerPoint.y, (MIN(bounds.size.width, bounds.size.height) / 2.0) - 3.5, M_PI, self.endAngle, NO);
    
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    PointingCircleView *pcv = [[PointingCircleView alloc] initWithFrame:CHANGE_CGRectMake(self.centerPoint.x - lunetteRadius, 132, 24, 24)];
    
    [pcv.layer addAnimation:pathAnimation forKey:@"moveTheCircle"];
    
    [self addSubview:pcv];

}

- (void)makeLayer:(CAShapeLayer *)layer WithFillColor:(UIColor *)color path:(UIBezierPath *)path lineWidth:(CGFloat)lineWidth{
    layer.lineWidth = lineWidth;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.fillColor = color.CGColor;
    layer.path = path.CGPath;
}

//显示半环
- (void)drawOutCircle{
    self.endAngle = self.percentage * (M_PI) + M_PI;
    CGRect bounds = self.bounds;
    CGFloat radius = (MIN(bounds.size.width, bounds.size.height) / 2.0) - 3.5;
    ;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.centerPoint.x, self.centerPoint.y) radius:radius startAngle:M_PI endAngle:self.endAngle clockwise:YES];
   
    UIBezierPath *markPath = [[UIBezierPath alloc] init];
    CGPoint markStartPoint;
    CGPoint markEndPoint;
    double markAngle = M_PI / 12;
    CGFloat pathEndPoint = self.centerPoint.x - radius * cos(self.percentage * M_PI);
    for (int i = 0; i <= 10; i++) {
        markStartPoint = CGPointMake(self.centerPoint.x - radius * cos(markAngle), self.centerPoint.y - radius * sin(markAngle));
        markEndPoint = CGPointMake(self.centerPoint.x - (radius - 6) * cos(markAngle), self.centerPoint.y - (radius - 6) * sin(markAngle));
        markAngle += M_PI / 12;
        if (markStartPoint.x <= pathEndPoint) {
            [markPath moveToPoint:markStartPoint];
            [markPath addLineToPoint:markEndPoint];
        }
    }

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 3.5;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    UIColor *fillColor = [UIColor colorWithRed:18/255.0 green:208/255.0 blue:255/255.0 alpha:1];
    layer.strokeColor = fillColor.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    
    CAShapeLayer *markLayer = [CAShapeLayer layer];
    markLayer.lineWidth = 3.5;
    markLayer.lineCap = kCALineCapRound;
    markLayer.lineJoin = kCALineJoinRound;
    markLayer.strokeColor = fillColor.CGColor;
    markLayer.fillColor = [UIColor clearColor].CGColor;
    markLayer.path = markPath.CGPath;
    [self.layer addSublayer:markLayer];
    
    
    [self addAnimationOnLayer:markLayer duration:1.7];
    [self addAnimationOnLayer:layer duration:1.5];
}

//辅助半环
- (void)drawMiddleCircle{
    CGRect bounds = self.bounds;
    CGFloat radius = (MIN(bounds.size.width, bounds.size.height) / 2.0) - 3.5;
    ;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius: radius startAngle:M_PI endAngle:2 * M_PI clockwise:YES];
    
    UIBezierPath *markPath = [[UIBezierPath alloc] init];
    CGPoint markStartPoint;
    CGPoint markEndPoint;
    double markAngle = M_PI / 12;
    for (int i = 0; i <= 10; i++) {
        markStartPoint = CGPointMake(self.centerPoint.x - radius * cos(markAngle), self.centerPoint.y - radius * sin(markAngle));
        markEndPoint = CGPointMake(self.centerPoint.x - (radius - 6) * cos(markAngle), self.centerPoint.y - (radius - 6) * sin(markAngle));
        markAngle += M_PI / 12;
        [markPath moveToPoint:markStartPoint];
        [markPath addLineToPoint:markEndPoint];
    }
    
    path.lineWidth = 3.5;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    UIColor *unfillColor = [UIColor colorWithRed:18/255.0 green:208/255.0 blue:255/255.0 alpha:0.16];
    [unfillColor setStroke];
    [path appendPath:markPath];
    [path stroke];
}

- (void)drawRightSun{
    UIImageView *rightSun = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightIcon.png"]];
    CGRect frame = CHANGE_CGRectMake(310,136, 15, 15);
    rightSun.frame = frame;
    [self addSubview:rightSun];
    
}

- (void)drawLeftSun{
    UIImageView *leftSun = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftIcon.png"]];
    CGRect frame = CHANGE_CGRectMake(50, 136, 15, 15);
    leftSun.frame = frame;
    [self addSubview:leftSun];
}

- (void)drawChargeUnitLabel{
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(247.5, 117.5, 14.5, 14.5)];
    unitLabel.text = @"元";
    unitLabel.textAlignment = NSTextAlignmentCenter;
    unitLabel.backgroundColor = [UIColor clearColor];
    unitLabel.textColor = [UIColor colorWithRed:18/255.0 green:208/255.0 blue:255/255.0 alpha:1];
    unitLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:font(16)];
    unitLabel.adjustsFontSizeToFitWidth = YES;
    unitLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentMode = UIViewContentModeRedraw;
    [self addSubview:unitLabel];
}

- (void)drawChargeLabelWithData:(NSString *)data{
    self.centerLabel = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(127.5 , 90, 120, 42)];
    self.centerLabel.text = data;
    self.centerLabel.textAlignment = NSTextAlignmentLeft;
    self.centerLabel.textColor = [UIColor colorWithRed:18/255.0 green:208/255.0 blue:255/255.0 alpha:1];
    self.centerLabel.backgroundColor = [UIColor clearColor];
    self.centerLabel.font = [UIFont systemFontOfSize:font(56)];
    self.centerLabel.adjustsFontSizeToFitWidth = YES;
    self.centerLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentMode = UIViewContentModeRedraw;
    [self addSubview:self.centerLabel];
}

//暗层圆环
- (void)drawDrakCircle{
    //根据bounds计算中心点
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    //计算圆形半径
    CGFloat radius = (MIN(bounds.size.width, bounds.size.height) / 2.0) - 20
    ;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    //画圆
    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:2.0 * M_PI clockwise:1];
    
    path.lineWidth = 8;
    
    [[UIColor colorWithRed:231/255.0 green:251/255.0 blue:255.0/255.0 alpha:0.64] setStroke];
    
    [path stroke];
}

//明层圆环
- (void)drawLightCircle{
    //根据bounds计算中心点
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    self.centerPoint = center;
    
    //计算圆形半径
    CGFloat radius = (MIN(bounds.size.width, bounds.size.height) / 2.0) - 14
    ;

    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    //画圆
    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:2.0 * M_PI clockwise:1];
    
    path.lineWidth = 5;
    
    [[UIColor colorWithRed:231/255.0 green:251/255.0 blue:255.0/255.0 alpha:0.4] setStroke];
    
    [path stroke];
}

@end

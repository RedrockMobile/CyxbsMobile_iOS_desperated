//
//  StatisticsTable.m
//  SegmentView
//
//  Created by xiaogou134 on 2017/8/5.
//  Copyright © 2017年 xiaogou134. All rights reserved.
//

#import "StatisticsTable.h"
#import "POP.h"
#import "PrefixHeader.pch"
#import "Masonry.h"
@interface StatisticsTable()<CAAnimationDelegate>

@property NSArray<NSArray*> *colors;
@property NSArray *context;
@property CGFloat lineWidth;
@property CGFloat blankWidth;
@end

@implementation StatisticsTable

- (void)drawRect:(CGRect)rect {
    
    for (int i = 0; i < self.colors.count; i ++) {
        UIBezierPath *sidePath1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2 , self.frame.size.height/2) radius:self.frame.size.width/2 + _lineWidth/2 - (_lineWidth+_blankWidth) * (i+1) + 1 startAngle:0.f endAngle:M_PI * 2  clockwise:YES];
        [self.colors[i][2] setStroke];
        sidePath1.lineWidth = 1.0;
        [sidePath1 stroke];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.frame.size.width/2 -(_lineWidth+_blankWidth) * (i+1) startAngle:0.f endAngle:M_PI * 2  clockwise:YES];
        [self.colors[i][3] setStroke];
        path.lineWidth = _lineWidth;
        [path stroke];
        
        UIBezierPath *sidePath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.frame.size.width/2 - _lineWidth/2 - (_lineWidth+_blankWidth) * (i +1)startAngle:0.f endAngle:M_PI * 2  clockwise:YES];
        [self.colors[i][2] setStroke];
        sidePath2.lineWidth = 1.0;
        [sidePath2 stroke];
        
    }
}
- (instancetype)initWithFrame:(CGRect)frame With:(NSArray<NSArray*> *) color{
    self = [super initWithFrame:frame];
    if (self) {
        self.colors = color;
        self.lineWidth = 18.0;
        self.blankWidth = 5.0;
    }
    return self;
}
- (void)drawLinesWithDetail:(NSArray<NSDictionary*>*) context With:(NSArray<NSArray *> *) color {
    for (int i = 0; i < context.count; i ++) {
//        [self removeFromSuperview];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.width/2) radius:self.frame.size.width/2 - (_lineWidth+_blankWidth) * (i+1)   startAngle:-M_PI/2-0.07 endAngle:M_PI * 2 * [context[i][@"score"]  floatValue] - 0.07 - M_PI/2 clockwise:YES];
        CAShapeLayer *sideshape = [CAShapeLayer layer];
        CAShapeLayer *shape = [CAShapeLayer layer];
        
        
        sideshape.lineWidth = 18;
        sideshape.fillColor = [UIColor clearColor].CGColor;
        sideshape.strokeColor = [(color[i][0]) CGColor];
        sideshape.lineCap = kCALineCapRound;
        shape.lineJoin = kCALineJoinRound;
        sideshape.path = path.CGPath;
        [self.layer addSublayer:sideshape];
        
        
        shape.lineWidth = 16;
        shape.fillColor = [UIColor clearColor].CGColor;
        shape.strokeColor = [color[i][1] CGColor];
        shape.lineCap = kCALineCapRound;
        shape.lineJoin = kCALineJoinRound;
        shape.path=path.CGPath;
        [sideshape addSublayer:shape];


        CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        checkAnimation.duration = 1.0f;
        checkAnimation.fromValue = @0;
        checkAnimation.toValue = @1;
        checkAnimation.delegate = self;
        checkAnimation.removedOnCompletion = NO;
        checkAnimation.fillMode = kCAFillModeForwards;
        checkAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [shape addAnimation:checkAnimation forKey:@"checkAnimation"];
        [sideshape addAnimation:checkAnimation forKey:@"checkAnimation"];
       
        UILabel *detailLable = [self newLable:CGRectMake(self.frame.size.width/2 - 28 ,_lineWidth+ (_lineWidth+_blankWidth)*i - 2, 22, 18) WithContext:[self turnFloat: context[i][@"score"]] WithColor:color[i][0]];
        [self addSubview:detailLable];
        
        UILabel *lables = [self detailLable:CGRectMake(SCREENWIDTH / 2 - self.size.width / 2 + 5,self.frame.size.width + 50 * i * SCREENWIDTH /375, self.size.width, 25* SCREENWIDTH /375) WithContext:context[i] With:color[i]];
        [self addSubview:lables];
        
    }

}
- (UILabel *) newLable:(CGRect)frame WithContext:(CGFloat )context WithColor:(UIColor *)color{
    UILabel *lab = [[UILabel alloc]init];
    lab.frame = frame;
    lab.adjustsFontSizeToFitWidth =  YES;
    lab.font = [UIFont systemFontOfSize:10* SCREENWIDTH /375];
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countDown" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.writeBlock = ^(id obj,const CGFloat values[]){
            UILabel *label = (UILabel*)obj;
            label.text = [NSString stringWithFormat:@"%d%%",(int)(values[0]*100)%100];
            label.textColor = color;
        };
    }];

    POPBasicAnimation *basic = [POPBasicAnimation linearAnimation];
    basic.property = prop;
    basic.fromValue = @(0);//从0开始
    basic.toValue = @(context);
    basic.duration = 1;
    [lab pop_addAnimation:basic forKey:nil];
    return lab;
}

- (UILabel *) detailLable:(CGRect)frame WithContext:(NSDictionary *)context With:(NSArray<UIColor *> *)color{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height)];

    UIColor *color1 = color[0];
    UIColor *color2 = COLOR_BULE1;
    UIColor *color3 = COLOR_YELLOW1;
    UIColor *color4 = COLOR_GREEN1;
    NSTextAttachment *imageText = [[NSTextAttachment alloc] init];
    if (CGColorEqualToColor(color1.CGColor,  color2.CGColor)) {
        imageText.image = [UIImage imageNamed:@"蓝色"];

    }
    else if (CGColorEqualToColor(color1.CGColor,  color3.CGColor)){
        imageText.image = [UIImage imageNamed:@"黄色"];
    }
    else if (CGColorEqualToColor(color1.CGColor,  color4.CGColor)){
        imageText.image = [UIImage imageNamed:@"绿色"];
    }
    else{
        imageText.image= [UIImage imageNamed:@"粉色"];
    }
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]init];
     NSAttributedString *imagestring = [NSAttributedString attributedStringWithAttachment:imageText];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSAttributedString *contextText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"  %@",context[@"name"]] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:15],NSBaselineOffsetAttributeName:@(3)}];
   
    [string appendAttributedString:imagestring];
    [string appendAttributedString:contextText];
//     string.attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    lable.attributedText = string;
    lable.textAlignment = NSTextAlignmentCenter;
    POPSpringAnimation *ani = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    ani.toValue = @(frame.origin.x);
    ani.springBounciness = 10.0f;
    [lable pop_addAnimation:ani forKey:@"position"];
//    NSArray<UILabel *> * lables = @[lable, colorLable];
    return lable;
}
- (float)turnFloat:(NSNumber *)number{
    float newNumber = [number floatValue];
    int turn = newNumber * 100;
    newNumber *= 100;
    if (newNumber-turn > 0.5) {
        newNumber = (newNumber+1)/100;
    }
    else{
        newNumber = newNumber/100;
    }
    return newNumber;
    
}
@end

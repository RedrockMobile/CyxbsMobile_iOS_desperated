#import "Timer.h"
@interface Timer ()
@property double radius;

@property float middleCircleRadius; //中心空白圆的半径
@property NSArray <NSNumber *> *nums; //构成饼图的百分比数字的数组
@end

@implementation Timer

const static int DEBUGING = 0;
const static double gapRadius = 3;

const static double color[10][3]     =
    {{185/255.0,230/255.0,254/255.0},
    {207/255.0,205/255.0,252/255.0},
    {254/255.0,199/255.0,227/255.0},
    {158/255.0,252/255.0,238/255.0},
    };

const static double colorLine[10][3] =
    {{125/255.0,201/255.0,241/255.0},
    {170/255.0,165/255.0,253/255.0},
    {238/255.0,135/255.0,187/255.0},
    {96/255.0,226/255.0,207/255.0},
    };

static inline float radians(double degrees) {
    return degrees * M_PI / 180;
}


- (id)initWithSquare:(CGRect)square Nums:(NSArray <NSNumber *>*)nums {
    self = [super initWithFrame:square];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        if (DEBUGING) {
            self.backgroundColor = [UIColor orangeColor];
        }
        self.nums = nums;
        self.middleCircleRadius = square.size.width / 4.0;
        _radius = self.frame.size.width / 30 * 14;
    }
    return self;
}

- (void)drawArcWithOrigin:(CGPoint)origin Radius:(NSInteger)radius StartAngle:(NSInteger)start EndAngle:(NSInteger)end Index:(NSInteger)index{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, color[index][0], color[index][1], color[index][2], 1);
    CGContextSetRGBStrokeColor(context, colorLine[index][0], colorLine[index][1], colorLine[index][2], 1);
    CGContextMoveToPoint(context, origin.x, origin.y);
    CGContextAddArc(context, origin.x, origin.y, radius, radians(start), radians(end), 1);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    CGContextFillPath(context);
    
    //
    CGContextSetRGBFillColor(context, 255, 255, 255, 1);
    CGContextSetRGBStrokeColor(context, colorLine[index][0], colorLine[index][1], colorLine[index][2], 1);
    
    CGContextMoveToPoint(context, origin.x, origin.y);
    CGContextAddArc(context, origin.x, origin.y, radius / 4, radians(start), radians(end), 1);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    CGContextFillPath(context);
}

- (void)drawRect:(CGRect)rect {
    CGPoint origin = CGPointMake(_radius, _radius);
    double sum = 0;
    for (NSNumber *num in self.nums) {
        sum += num.doubleValue;
    }
    double nowAngle = 285;
    for (int i = 0; i < self.nums.count; i++) {
        double nextAngle = nowAngle - self.nums[i].doubleValue / sum * 360;
        if (nextAngle < 0) {
            nextAngle += 360;
        }
        if(DEBUGING) {
            NSLog(@"now = %lf next = %lf" ,nowAngle,nextAngle);
        }
        [self drawArcWithOrigin:origin Radius:_radius StartAngle:nowAngle EndAngle:nextAngle + gapRadius Index:i];
        
        double trueNowAngle = nowAngle + 90;
        if (trueNowAngle >= 360) {
            trueNowAngle -= 360;
        }
        double trueNextAngle = nextAngle + 90;
        if (trueNextAngle >= 360) {
            trueNextAngle -= 360;
        }
        double trueAngle = (trueNowAngle + trueNextAngle) / 2 ;
        if (trueNowAngle < trueNextAngle) {
            trueAngle += 180;
        }
//        NSLog(@"now = %lf next = %lf true = %lf ",trueNowAngle,trueNextAngle, trueAngle);
        int labelX = _radius + (5.0/8 * _radius)  * sin(trueAngle / 57.3);
        int labelY = _radius - (5.0/8 * _radius)  * cos(trueAngle / 57.3);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 60, 20)];
        label.center = CGPointMake(labelX, labelY);
//        if (_nums[i].doubleValue<10) {
//            label.text = [NSString stringWithFormat:@""];
//        }
//        else{
            label.text = [NSString stringWithFormat:@"%.2f%%",self.nums[i].doubleValue];
//        }
        [label setTextColor:[UIColor colorWithRed:colorLine[i][0] green:colorLine[i][1] blue:colorLine[i][2] alpha:1]];
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        nowAngle = nextAngle;
    }
    
    //画圆
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetRGBFillColor(context, 255/255.0, 255/255.0, 255/255.0, 1);
    CGContextSetRGBStrokeColor(context, 255/255.0, 255/255.0, 255/255.0, 1);
    double circleRadius = _radius  / 4;
    CGRect circle = CGRectMake(circleRadius * 3 + 1.5, circleRadius * 3 + 1.5, circleRadius * 2 - 3, circleRadius * 2 - 3);
    CGContextAddEllipseInRect(context, circle);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    CGContextFillPath(context);
}

@end
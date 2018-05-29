//
//  rotaryCountView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/19.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "rotaryCountView.h"
@interface rotaryCountView()
@end
@implementation rotaryCountView
- (id)initWithFrame:(CGRect)frame andNum:(NSString *)num{
    if (self = [super initWithFrame:frame]){
        [self setUpView];
        [self selectNum:num];
    }
    return self;
}

- (void)setUpView{
    self.userInteractionEnabled=NO;
    self.contentSize = CGSizeMake(self.width, self.height * 6);
    self.backgroundColor = [UIColor whiteColor];
    
    NSArray *numArray = @[@"00", @"01", @"02", @"03",
                          @"04", @"05", @"06"];
    for (int i = 0; i < numArray.count; i++) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height * i, self.width, self.height)];
        tempLabel.text = numArray[i];
        tempLabel.font = [UIFont fontWithName:@"Arial" size:60];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        tempLabel.textColor = [UIColor colorWithHexString:@"839BFA"];
        [self addSubview:tempLabel];
    }
    
}

- (void)selectNum:(NSString *)num{
    [UIView animateWithDuration:0.4 animations:^{
        self.contentOffset = CGPointMake(0, self.height * [num floatValue]);
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

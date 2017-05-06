//
//  UIShortTapGestureRecognizer.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/24.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "UIShortTapGestureRecognizer.h"

#define UISHORT_TAP_MAX_DELAY 0.30

/**
 * 解决单击和双击手势共存情况下 单击延迟的问题
 *
 */


@implementation UIShortTapGestureRecognizer

-(instancetype)initWithTarget:(id)target action:(SEL)action{
    
    self=[super initWithTarget:target action:action];
    
    if(self){
        
        self.maxDelay = UISHORT_TAP_MAX_DELAY;
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.maxDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(self.state!=UIGestureRecognizerStateRecognized){
            
            self.state=UIGestureRecognizerStateFailed;
        }
    });
}

@end

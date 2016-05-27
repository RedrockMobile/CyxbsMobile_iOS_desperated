//
//  TWGameControllButton.h
//  Tower
//
//  Created by Jonear on 14/12/20.
//  Copyright (c) 2014年 Jonear. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TWGameControllButtonDelegate;

@interface TWGameControllButton : UIControl

@property (weak, nonatomic) id<TWGameControllButtonDelegate> deleage;

@end

@protocol TWGameControllButtonDelegate <NSObject>

- (void)didSelectClick:(NSInteger)index;

@end
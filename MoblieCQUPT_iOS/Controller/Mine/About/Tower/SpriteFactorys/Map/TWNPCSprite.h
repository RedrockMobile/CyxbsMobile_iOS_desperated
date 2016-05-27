//
//  TWNPCSprite.h
//  Tower
//
//  Created by Jonear on 14/12/21.
//  Copyright (c) 2014年 Jonear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

typedef void (^NPCCompleteBlock)(void);

@interface TWNPCSprite : NSObject  <UIAlertViewDelegate>

- (id)initWithType:(int)type;

- (void)talkToNpcWithComplete:(NPCCompleteBlock)block;

@end

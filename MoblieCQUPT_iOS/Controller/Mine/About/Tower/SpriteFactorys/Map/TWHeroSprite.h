//
//  TW_HeroSprite.h
//  Tower
//
//  Created by Jonear on 14-5-11.
//  Copyright (c) 2014年 Jonear. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum enumHeroMove {
    kMoveUp = 0,
    kMoveDown,
    kMoveLeft,
    kMoveRight,
}enumHeroMove;

@interface TWHeroSprite : SKSpriteNode

//血量
@property (nonatomic,assign) NSInteger HeroHP;
//攻击
@property (nonatomic,assign) NSInteger Attack;
//防御
@property (nonatomic,assign) NSInteger Defense;
//金币数
@property (nonatomic,assign) NSInteger Gold;
//经验值
@property (nonatomic,assign) NSInteger Experience;
//飞行器
@property (nonatomic,assign) BOOL Flight;
//查看器
@property (nonatomic,assign) BOOL Predict;
//可飞行的最大楼层
@property (nonatomic,assign) NSInteger MaxFloor;

//钥匙
@property (nonatomic,assign) NSInteger RedKeyCount;
@property (nonatomic,assign) NSInteger YellowKeyCount;
@property (nonatomic,assign) NSInteger BlueKeyCount;
@property (nonatomic,assign) NSInteger BlackKeyCount;

@property (assign, nonatomic) enumHeroMove currentDirection;
@property (assign, nonatomic) CGPoint      currectPoint;

- (id)initWithPosition:(CGPoint)position withScale:(CGFloat)scale;

- (void)heroMoveTo:(enumHeroMove)move;

@end

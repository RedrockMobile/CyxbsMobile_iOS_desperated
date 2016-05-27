//
//  TW_HeroSprite.h
//  Tower
//
//  Created by Jonear on 14-5-11.
//  Copyright (c) 2014年 Jonear. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TWEnemySprite : SKSpriteNode <NSCopying>

//怪物编号
@property (nonatomic,assign) int enemyID;
//怪物名
@property (nonatomic,retain) NSString *name;
//血量
@property (nonatomic,assign) int HP;
//攻击
@property (nonatomic,assign) int Attack;
//防御
@property (nonatomic,assign) int Defense;
//金币
@property (nonatomic,assign) int Coin;
//经验
@property (nonatomic,assign) int Experience;

-(TWEnemySprite*) initWithEmeny:(TWEnemySprite*) copyform;

+(id)initWithType:(int)typeID;

- (id)initWithTexture:(SKTexture *)texture withType:(int)type;

@end

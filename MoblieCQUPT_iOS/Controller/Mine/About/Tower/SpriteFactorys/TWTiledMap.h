//
//  TWTiledMap.h
//  Tower
//
//  Created by Jonear on 14/12/20.
//  Copyright (c) 2014年 Jonear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSTileMap.h"

@interface TWTiledMap : JSTileMap

@property (nonatomic,strong) TMXLayer *wall;
@property (nonatomic,strong) TMXLayer *road;
@property (nonatomic,strong) TMXLayer *enemy;
@property (nonatomic,strong) TMXLayer *item;
@property (nonatomic,strong) TMXLayer *upfloor;
@property (nonatomic,strong) TMXLayer *downfloor;
@property (nonatomic,strong) TMXLayer *door;
@property (nonatomic,strong) TMXLayer *other;
@property (nonatomic,strong) TMXLayer *npc;
@property (nonatomic,strong) TMXLayer *heroPoint;
@property (nonatomic,assign) CGPoint up;
@property (nonatomic,assign) CGPoint down;

-(id)initWithIndex:(int)index;

@end

//
//  TW_MyScene.h
//  Tower
//

//  Copyright (c) 2014年 Jonear. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
#import "TWHeroSprite.h"

typedef enum enumMapLayerType {
    kMapLayer_Wall = 0,
    kMapLayer_Road,
    kMapLayer_Enemy,
    kMapLayer_Item,
    kMapLayer_Upfloor,
    kMapLayer_Downfloor,
    kMapLayer_Door,
    kMapLayer_Other,
    kMapLayer_NPC,
    kMapLayer_HeroPoint,
}enumMapLayerType;

@interface TW_MyScene : SKScene

//主视图控制英雄移动
- (void)heroMoveTo:(enumHeroMove)move;

//飞行到某层
- (void)flyToMapWithIndex:(int)index;
//获得是否有飞行器
- (BOOL)getCanFlyFlag;
//获得能飞往的最大楼层
- (NSInteger)getMaxCanFlyIndex;
//获得当前楼层
- (NSInteger)getCurMapIndex;

//保存游戏
- (void)saveGame;
- (void)restartGame;
@end

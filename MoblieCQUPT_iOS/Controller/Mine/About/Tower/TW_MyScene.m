//
//  TW_MyScene.m
//  Tower
//
//  Created by Jonear on 14-5-10.
//  Copyright (c) 2014年 Jonear. All rights reserved.
//

#import "TW_MyScene.h"
#import "TWTiledMap.h"
#import "TWEnemySprite.h"
#import "ProgressHUD.h"
#import "TWNPCSprite.h"

#import "TWPredictScene.h"

#define DefaultMapIndex 0
#define ShopViewTag 2371
#define RESTARTALERTTAG 134

@interface TW_MyScene() <UIAlertViewDelegate, TWPredictSceneDelegate>

@end

@implementation TW_MyScene
{
    TWHeroSprite *_hero;
    NSMutableArray *_mapArray;
    TWTiledMap *_curtitleMap;
    NSInteger _curMapIndex;
    CGSize _mapSize;
    NSInteger _offsetTop;
    BOOL _isHeroBusy;
    BOOL _isInitHeroInfoUI;
    
    TWNPCSprite *_npcSprite;
    NSMutableArray *_removeItemArray;
    
    TWPredictScene *_predictScene;
    SKView *_parentView;
    SKSpriteNode *_restartSprite;
    
    CGFloat _mapScale;
    
    //label
    SKLabelNode *_labelNode_mapindex;
    SKLabelNode *_labelNode_hp;
    SKLabelNode *_labelNode_att;
    SKLabelNode *_labelNode_def;
    SKLabelNode *_labelNode_gold;
    SKLabelNode *_labelNode_exp;
    SKLabelNode *_labelNode_rkey;
    SKLabelNode *_labelNode_bkey;
    SKLabelNode *_labelNode_ykey;
    
    SKSpriteNode *_predictSpriteNode;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        _isHeroBusy = NO;
        _isInitHeroInfoUI = NO;
        _mapScale = 1;
        _removeItemArray = [[NSMutableArray alloc] init];
        
        [self initBackground];
        [self initMap];
        [self initHero];
        [self readGame];
        
        [self initReStartSprite];
    }
    return self;
}

- (void)initBackground {
//    SKSpriteNode *backNode = [[SKSpriteNode alloc] initWithImageNamed:@"background_image.jpg"];
//    [backNode setSize:CGSizeMake(PHOTOWIDTH, PHOTOHEIGHT)];
//    [backNode setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))];
//    [self addChild:backNode];
}

- (void)initReStartSprite {
    _restartSprite = [[SKSpriteNode alloc] initWithImageNamed:@"restart"];
    [_restartSprite setSize:CGSizeMake(25, 25)];
    [_restartSprite setPosition:CGPointMake(20, 20)];
    [self addChild:_restartSprite];
}

- (void)initHeroInfo {
    if (_isInitHeroInfoUI) {
        return;
    }
    
    _isInitHeroInfoUI = YES;
    
    int top = PHOTOHEIGHT-15*_mapScale;
    _labelNode_mapindex = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [_labelNode_mapindex setFontSize:12];
    [_labelNode_mapindex setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    _labelNode_mapindex.position = CGPointMake(10, top);
    [_labelNode_mapindex setText:[NSString stringWithFormat:@"---------%d层----------", _curMapIndex]];
    _labelNode_mapindex.xScale = _mapScale;
    _labelNode_mapindex.yScale = _mapScale;
    [self addChild:_labelNode_mapindex];

    top = top-15*_mapScale;
    _labelNode_hp = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [_labelNode_hp setFontSize:12];
    [_labelNode_hp setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    _labelNode_hp.position = CGPointMake(0, top);
    [_labelNode_hp setText:[NSString stringWithFormat:@"生命值: %d", _hero.HeroHP]];
    _labelNode_hp.xScale = _mapScale;
    _labelNode_hp.yScale = _mapScale;
    [self addChild:_labelNode_hp];
    
    top = top-15*_mapScale;
    _labelNode_att = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [_labelNode_att setFontSize:12];
    [_labelNode_att setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    _labelNode_att.position = CGPointMake(0, top);
    [_labelNode_att setText:[NSString stringWithFormat:@"攻击力: %d", _hero.Attack]];
    _labelNode_att.xScale = _mapScale;
    _labelNode_att.yScale = _mapScale;
    [self addChild:_labelNode_att];
    
    top = top-15*_mapScale;
    _labelNode_def = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [_labelNode_def setFontSize:12];
    [_labelNode_def setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    _labelNode_def.position = CGPointMake(0, top);
    [_labelNode_def setText:[NSString stringWithFormat:@"防御力: %d", _hero.Defense]];
    _labelNode_def.xScale = _mapScale;
    _labelNode_def.yScale = _mapScale;
    [self addChild:_labelNode_def];
    
    top = top-15*_mapScale;
    _labelNode_gold = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [_labelNode_gold setFontSize:12];
    [_labelNode_gold setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    _labelNode_gold.position = CGPointMake(0, top);
    [_labelNode_gold setText:[NSString stringWithFormat:@"金币数: %d", _hero.Gold]];
    _labelNode_gold.xScale = _mapScale;
    _labelNode_gold.yScale = _mapScale;
    [self addChild:_labelNode_gold];
    
    top = top-15*_mapScale;
    _labelNode_exp = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [_labelNode_exp setFontSize:12];
    [_labelNode_exp setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    _labelNode_exp.position = CGPointMake(0, top);
    [_labelNode_exp setText:[NSString stringWithFormat:@"经验值: %d", _hero.Experience]];
    _labelNode_exp.xScale = _mapScale;
    _labelNode_exp.yScale = _mapScale;
    [self addChild:_labelNode_exp];
    
    top = top-20*_mapScale;
    if (_mapArray.count > 1) {
        TWTiledMap *map = [_mapArray objectAtIndex:1];
        SKSpriteNode *redNode = [map.item tileAtCoord:CGPointMake(4, 9)];
        SKSpriteNode *redNodeCopy = [SKSpriteNode spriteNodeWithTexture:redNode.texture];
        redNodeCopy.position = CGPointMake(20*_mapScale, top);
        redNodeCopy.xScale = _mapScale;
        redNodeCopy.yScale = _mapScale;
        [self addChild:redNodeCopy];
        
        SKSpriteNode *blueNode = [map.item tileAtCoord:CGPointMake(10, 9)];
        SKSpriteNode *blueNodeCopy = [SKSpriteNode spriteNodeWithTexture:blueNode.texture];
        blueNodeCopy.position = CGPointMake(60*_mapScale, top);
        blueNodeCopy.xScale = _mapScale;
        blueNodeCopy.yScale = _mapScale;
        [self addChild:blueNodeCopy];
        
        SKSpriteNode *yellowNode = [map.item tileAtCoord:CGPointMake(10, 10)];
        SKSpriteNode *yellowNodeCopy = [SKSpriteNode spriteNodeWithTexture:yellowNode.texture];
        yellowNodeCopy.position = CGPointMake(100*_mapScale, top);
        yellowNodeCopy.xScale = _mapScale;
        yellowNodeCopy.yScale = _mapScale;
        [self addChild:yellowNodeCopy];

        SKSpriteNode *predictnode = [map.item tileAtCoord:CGPointMake(1, 10)];
        _predictSpriteNode = [SKSpriteNode spriteNodeWithTexture:predictnode.texture];
        _predictSpriteNode.position = CGPointMake(140*_mapScale, PHOTOHEIGHT-50);
        _predictSpriteNode.xScale = _mapScale;
        _predictSpriteNode.yScale = _mapScale;
        if (_hero.Predict) {
            [self addChild:_predictSpriteNode];
        }
        
        if (PHOTOWIDTH < 568) {
            redNodeCopy.alpha = 0.7;
            blueNodeCopy.alpha = 0.7;
            yellowNodeCopy.alpha = 0.7;
            _predictSpriteNode.alpha = 0.7;
        }
    }
    
    _labelNode_rkey = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [_labelNode_rkey setFontSize:12];
    [_labelNode_rkey setFontColor:[UIColor whiteColor]];
    [_labelNode_rkey setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeRight];
    _labelNode_rkey.position = CGPointMake(35*_mapScale, top-20);
    [_labelNode_rkey setText:[NSString stringWithFormat:@"%d", _hero.RedKeyCount]];
    _labelNode_rkey.xScale = _mapScale;
    _labelNode_rkey.yScale = _mapScale;
    [self addChild:_labelNode_rkey];
    
    _labelNode_bkey = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [_labelNode_bkey setFontSize:12];
    [_labelNode_bkey setFontColor:[UIColor whiteColor]];
    [_labelNode_bkey setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeRight];
    _labelNode_bkey.position = CGPointMake(75*_mapScale, top-20);
    [_labelNode_bkey setText:[NSString stringWithFormat:@"%d", _hero.BlueKeyCount]];
    _labelNode_bkey.xScale = _mapScale;
    _labelNode_bkey.yScale = _mapScale;
    [self addChild:_labelNode_bkey];
    
    _labelNode_ykey = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [_labelNode_ykey setFontSize:12];
    [_labelNode_ykey setFontColor:[UIColor whiteColor]];
    [_labelNode_ykey setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeRight];
    _labelNode_ykey.position = CGPointMake(115*_mapScale, top-20);
    [_labelNode_ykey setText:[NSString stringWithFormat:@"%d", _hero.YellowKeyCount]];
    _labelNode_ykey.xScale = _mapScale;
    _labelNode_ykey.yScale = _mapScale;
    [self addChild:_labelNode_ykey];
}

- (void)updateHeroInfo {
    [_labelNode_hp setText:[NSString stringWithFormat:@"生命值: %d", _hero.HeroHP]];
    [_labelNode_att setText:[NSString stringWithFormat:@"攻击力: %d", _hero.Attack]];
    [_labelNode_def setText:[NSString stringWithFormat:@"防御力: %d", _hero.Defense]];
    [_labelNode_gold setText:[NSString stringWithFormat:@"金币数: %d", _hero.Gold]];
    [_labelNode_exp setText:[NSString stringWithFormat:@"经验值: %d", _hero.Experience]];
    [_labelNode_rkey setText:[NSString stringWithFormat:@"%d", _hero.RedKeyCount]];
    [_labelNode_bkey setText:[NSString stringWithFormat:@"%d", _hero.BlueKeyCount]];
    [_labelNode_ykey setText:[NSString stringWithFormat:@"%d", _hero.YellowKeyCount]];
    
    if (_hero.Predict && !_predictSpriteNode.parent) {
        [self addChild:_predictSpriteNode];
    } else if (!_hero.Predict && _predictSpriteNode.parent){
        [_predictSpriteNode removeFromParent];
    }
}

- (void)updateMapIndexInfo {
    [_labelNode_mapindex setText:[NSString stringWithFormat:@"---------%d层----------", _curMapIndex]];
}

- (void)initHero
{
    _hero = [[TWHeroSprite alloc] initWithPosition:[self getPointWithIndexPoint:_curtitleMap.down] withScale:_mapScale];
    _hero.currectPoint = _curtitleMap.down;
    [self addChild:_hero];
    
    [self initHeroInfo];
}

- (void)initMap
{
    _mapArray = [[NSMutableArray alloc] initWithCapacity:21];
    for (int i=0; i<=21; i++) {
        TWTiledMap *map = [[TWTiledMap alloc] initWithIndex:i];
        [_mapArray addObject:map];
    }
    _curMapIndex = DefaultMapIndex;
    _curtitleMap = [_mapArray objectAtIndex:_curMapIndex];
    _mapSize = CGSizeMake(((_curtitleMap.mapSize.width)*_curtitleMap.tileSize.width), ((_curtitleMap.mapSize.height)*_curtitleMap.tileSize.height));
    [self addChild:_curtitleMap];
    
    [self updateMap:YES];
}

- (CGPoint)getPointWithIndexPoint:(CGPoint)point
{
    return CGPointMake(_curtitleMap.position.x+16*_mapScale+point.x*32*_mapScale, point.y*32*_mapScale+16*_mapScale);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    /* Called when a touch begins */
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    CGPoint point = [touch locationInNode:_predictSpriteNode];
    
    // 点击查看器
    if (point.x>-15 && point.x<15 && point.y>-15 && point.y<15) {
        [self showPredictScence];
        return;
    }
    
    point = [touch locationInNode:_restartSprite];

    if (point.x>-10 && point.x<10 && point.y>-10 && point.y<10) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"重新开始"
                                                        message:@"您是否确认要重新开始游戏，重新开始后原来的游戏记录都将被删除？"
                                                       delegate:self
                                              cancelButtonTitle:@"重新开始"
                                              otherButtonTitles:@"取消", nil];
        alert.tag = RESTARTALERTTAG;
        [alert show];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
//    NSLog(@"%f", currentTime);
}

- (void)showPredictScence {
    if (!_predictScene) {
        _predictScene = [[TWPredictScene alloc] initWithSize:self.size];
        _predictScene.scaleMode = SKSceneScaleModeAspectFill;
        [_predictScene setPredictDelegate:self];
        _parentView = self.view;
    }
    
    NSMutableArray *enemyArray = [[NSMutableArray alloc] init];
    for (int x = 0; x <= 10; x++)
    {
        for (int y = 0; y <= 10; y++)
        {
            CGPoint towerLoc = CGPointMake(x, y);
            int heroPoint_tileGid = [_curtitleMap.enemy tileGidAt:towerLoc];
            
            if (heroPoint_tileGid)
            {
                NSDictionary *props = [_curtitleMap propertiesForGid:heroPoint_tileGid];
                NSString *value = [props valueForKey:@"enemy"];
                int type = [value intValue];
                BOOL find = NO;
                for (TWEnemySprite *e in enemyArray) {
                    if (e.enemyID == type) {
                        find = YES;
                        break;
                    }
                }
                if (find) {
                    continue;
                }
                
                SKSpriteNode *spriteNode = [_curtitleMap.enemy tileAt:towerLoc];
                TWEnemySprite *enemy = [[TWEnemySprite alloc] initWithTexture:spriteNode.texture withType:type];
                [enemyArray addObject:enemy];
            }
        }
    }
    [_predictScene setEnemyDataArray:enemyArray withHero:_hero];
    
    _isHeroBusy = YES;
    [self.view presentScene:_predictScene];
}

#pragma mark - 英雄移动碰撞事件
//主视图控制英雄移动
- (void)heroMoveTo:(enumHeroMove)direction
{
    if (_isHeroBusy) {
        NSLog(@"英雄好忙，稍后再操作");
        return;
    }
    
    CGPoint pos = _hero.currectPoint;
    if (direction == kMoveDown) {
        pos.y --;
    } else if (direction == kMoveLeft) {
        pos.x --;
    } else if (direction == kMoveUp) {
        pos.y ++;
    } else if (direction == kMoveRight) {
        pos.x ++;
    }
    
    if (pos.x <0 || pos.y<0 || pos.x>10 || pos.x>10) {
        return ;
    }
    
    //获取建造位置地图坐标
    int road_tileGid = [_curtitleMap.road tileGidAt:pos];
    int enemy_tileGid = [_curtitleMap.enemy tileGidAt:pos];
    int item_tileGid = [_curtitleMap.item tileGidAt:pos];
    int door_tileGid = [_curtitleMap.door tileGidAt:pos];
    int npc_tileGid = [_curtitleMap.npc tileGidAt:pos];
    int downfloor_tileGid = [_curtitleMap.downfloor tileGidAt:pos];
    int upfloor_tileGid = [_curtitleMap.upfloor tileGidAt:pos];
    int other_tileGid = [_curtitleMap.other tileGidAt:pos];
    
    if (enemy_tileGid)
    {
        NSLog(@"enemy_tileGid:%d", enemy_tileGid);
        if ([self fightEnemyWithGid:enemy_tileGid position:pos]) {
            [self removeTileWithLayerType:kMapLayer_Enemy WithPoint:pos];
        } else {
            [ProgressHUD showError:@"根本不是对手"];
            return;
        }
    }
    if (item_tileGid)
    {
        NSLog(@"item_tileGid:%d", item_tileGid);
        [self getItemWithGid:item_tileGid];
        [self removeTileWithLayerType:kMapLayer_Item WithPoint:pos];
    }
    if (door_tileGid)
    {
        NSLog(@"door_tileGid:%d", door_tileGid);
        if ([self openTheDoorWithGid:door_tileGid]) {
            [self removeTileWithLayerType:kMapLayer_Door WithPoint:pos];
        } else {
            return;
        }
    }
    if (other_tileGid)
    {
        NSLog(@"other_tileGid:%d", other_tileGid);
        if ([self talkOtherWithGid:other_tileGid]) {
            [self removeTileWithLayerType:kMapLayer_Other WithPoint:pos];
        } else {
            return;
        }
    }
    if (upfloor_tileGid)
    {
        NSLog(@"upfloor_tileGid:%d", upfloor_tileGid);
        _curMapIndex ++;
        [self updateMap:YES];
        return;
    }
    if (downfloor_tileGid)
    {
        NSLog(@"downfloor_tileGid:%d", downfloor_tileGid);
        _curMapIndex --;
        [self updateMap:NO];
        return;
    }
    if (npc_tileGid)
    {
        NSLog(@"npc_tileGid:%d", npc_tileGid);
        [self talkToNPCWithGid:npc_tileGid point:pos];

        return;
    }
    if (road_tileGid)
    {
        NSLog(@"road_tileGid:%d", road_tileGid);

        [_hero heroMoveTo:direction];
    }
    
    [self moveMap];
}

// 飞行到某一层
- (void)flyToMapWithIndex:(int)index {
    if (_isHeroBusy) {
        return;
    }
    if (_mapArray.count > index) {
        _curMapIndex = index;
        [self updateMap:YES];
    }
}

//根据英雄移动移动地图
- (void)moveMap {
    [self moveMapWithNeedUpdate:NO];
}

- (void)moveMapWithNeedUpdate:(BOOL)isNeedUpdate {
//    if (PHOTOHEIGHT > 320) {
//        return;
//    }

    if (_hero.currectPoint.y > 4 && isNeedUpdate) {
        _offsetTop = -1;
        _curtitleMap.position = CGPointMake(_curtitleMap.position.x, PHOTOHEIGHT-_mapSize.height);
        _hero.position = CGPointMake(_hero.position.x, (_hero.currectPoint.y+_offsetTop)*32+16);
    } else if(_hero.currectPoint.y <= 4 && isNeedUpdate){
        _offsetTop = 0;
        _curtitleMap.position = CGPointMake(_curtitleMap.position.x, 0);
        _hero.position = CGPointMake(_hero.position.x, (_hero.currectPoint.y+_offsetTop)*32+16);
    }
    else if (_hero.currectPoint.y > 4 && _offsetTop!=-1) {
        _offsetTop = -1;
        [_curtitleMap runAction:[SKAction moveToY:PHOTOHEIGHT-_mapSize.height duration:0.15]];
        [_hero runAction:[SKAction moveToY:(_hero.currectPoint.y+_offsetTop)*32+16 duration:0.15]];
    } else if(_hero.currectPoint.y <= 4 && (_offsetTop!=0 || isNeedUpdate)){
        _offsetTop = 0;
        [_curtitleMap runAction:[SKAction moveToY:0 duration:0.1]];
        [_hero runAction:[SKAction moveToY:(_hero.currectPoint.y+_offsetTop)*32+16 duration:0.15]];
    }
}

// 上下楼更新地图
- (void)updateMap:(BOOL)isUpMap {
    if (_curMapIndex > _hero.MaxFloor) {
        _hero.MaxFloor = _curMapIndex;
    }
    [_curtitleMap removeFromParent];
    _curtitleMap = [_mapArray objectAtIndex:_curMapIndex];
    
//    if (PHOTOHEIGHT <= 320) {
//        _mapScale = 1;
//    } else {
//        _mapScale = PHOTOHEIGHT / _mapSize.height;
//    }
    _curtitleMap.xScale = _mapScale;
    _curtitleMap.yScale = _mapScale;
    _curtitleMap.position = CGPointMake(PHOTOWIDTH-_mapSize.width*_mapScale-32, 0);
    
    if (isUpMap) {
        _hero.position = [self getPointWithIndexPoint:_curtitleMap.down];
        _hero.currectPoint = _curtitleMap.down;
    } else {
        _hero.position = [self getPointWithIndexPoint:_curtitleMap.up];
        _hero.currectPoint = _curtitleMap.up;
    }
    [self moveMapWithNeedUpdate:YES];
    [self addChild:_curtitleMap];
    [self updateMapIndexInfo];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_RunToFloor object:[NSNumber numberWithInteger:_curMapIndex]];
}

// 其他
- (BOOL)talkOtherWithGid:(int)gid {
    NSDictionary *props = [_curtitleMap propertiesForGid:gid];
    
    // 商店
    NSString *value = [props valueForKey:@"shop"];
    if (value && [value integerValue] > 0) {
        [self showShopWithType:[value intValue]];
    }
    
    // 门砸
    value = [props valueForKey:@"door"];
    if (value && [value integerValue] > 0) {
        NSLog(@"门砸%d", [value integerValue]);
        return YES;
    }
    
    return NO;
}

- (void)showShopWithType:(int)type {
    // 小金币商店
    if (type == 1) {
        _isHeroBusy = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_StopControllerTimer object:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"商店" message:@"欢迎来到商店,你可以使用30个金币换取" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"+1000血",@"+5攻击力",@"+5防御力", nil];
        [alert setTag:ShopViewTag+type];
        [alert show];
    } else if (type == 2) {
        _isHeroBusy = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_StopControllerTimer object:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"商店" message:@"欢迎来到大商店,你可以使用300个金币换取" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"+10000血",@"+50攻击力",@"+50防御力", nil];
        [alert setTag:ShopViewTag+type];
        [alert show];
    } else if (type == 4) {
        _isHeroBusy = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_StopControllerTimer object:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"商店" message:@"欢迎来到经验商店,你可以使用30个经验换取" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"+1200血",@"+7攻击力",@"+7防御力", nil];
        [alert setTag:ShopViewTag+type];
        [alert show];
    }  else if (type == 5) {
        _isHeroBusy = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_StopControllerTimer object:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"商店" message:@"欢迎来到钥匙商店,你可以购买" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"花30买金币黄🔑",@"花50金币买蓝🔑",@"花100金币买红🔑", nil];
        [alert setTag:ShopViewTag+type];
        [alert show];
    } else if (type == 6) {
        _isHeroBusy = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_StopControllerTimer object:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"商店" message:@"友情打包购买，+2000血 +20攻击力 +20防御力 只需要花费100金币100经验" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"花100金币100经验购买", nil];
        [alert setTag:ShopViewTag+type];
        [alert show];
    } else if (type == 7) {
        _isHeroBusy = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_StopControllerTimer object:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"商店" message:@"欢迎来到经验商店,你可以使用300个经验换取" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"+12000血",@"+70攻击力",@"+70防御力", nil];
        [alert setTag:ShopViewTag+type];
        [alert show];
    }
}

- (void)talkToNPCWithGid:(int)gid point:(CGPoint)point{
    NSDictionary *props = [_curtitleMap propertiesForGid:gid];
    NSString *value = [props valueForKey:@"npc"];
    if (value) {
        _isHeroBusy = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_StopControllerTimer object:nil];
        int npcType = [value intValue];
        
        if (npcType == 4) {
            [self showShopWithType:4];
        } else if(npcType == 5) {
            [self showShopWithType:5];
        } else if(npcType == 6) {
            [self showShopWithType:6];
        } else if(npcType == 7) {
            [self showShopWithType:7];
        }

        _npcSprite = [[TWNPCSprite alloc] initWithType:npcType];
        [_npcSprite talkToNpcWithComplete:^{
            _isHeroBusy = NO;
            if (npcType == 0) {
                // 仙女
                [_curtitleMap.npc moveTileFromCoord:[_curtitleMap.npc coordForPoint:point] toCoord:[_curtitleMap.npc coordForPoint:CGPointMake(point.x-1, point.y)]];
            } else if (npcType == 1) {
                // 攻击老人
                [self removeTileWithLayerType:kMapLayer_NPC WithPoint:point];
                _hero.Attack += 10;
                [ProgressHUD showSuccess:@"攻击力 +10"];
            } else if (npcType == 2) {
                // 防御老人
                [self removeTileWithLayerType:kMapLayer_NPC WithPoint:point];
                _hero.Defense += 10;
                [ProgressHUD showSuccess:@"防御力 +10"];
            } else if (npcType == 3) {
                // 小偷
                [self removeTileWithLayerType:kMapLayer_NPC WithPoint:point];
                _hero.BlackKeyCount = 1;
            } else if (npcType == 8) {
                // 金币老人
                [self removeTileWithLayerType:kMapLayer_NPC WithPoint:point];
                _hero.Gold += 500;
            } else if (npcType == 9) {
                // 经验老人
                [self removeTileWithLayerType:kMapLayer_NPC WithPoint:point];
                _hero.Experience += 500;
            }
            
            [self updateHeroInfo];
        }];
    }

}

// 战斗敌人
- (BOOL)fightEnemyWithGid:(int)gid position:(CGPoint)pos{
    NSDictionary *props = [_curtitleMap propertiesForGid:gid];
    NSString *value = [props valueForKey:@"enemy"];
    int type = [value intValue];
    TWEnemySprite *enemy = [TWEnemySprite initWithType:type];

    if (_hero.Attack > enemy.Defense)
    {
        int lostHP = (enemy.HP/(float)(_hero.Attack-enemy.Defense))*(enemy.Attack-_hero.Defense);
        if (lostHP < 0) {
            lostHP = 0;
        }
        
        if (_hero.HeroHP > lostHP){
            [self showFightLostHPTip:lostHP position:pos];
            _hero.HeroHP -= lostHP;
            _hero.Gold += enemy.Coin;
            _hero.Experience += enemy.Experience;
            [self updateHeroInfo];
            return YES;
        }
    }


    return NO;
}

- (void)showFightLostHPTip:(NSInteger)lostHP position:(CGPoint)pos{
    
    SKLabelNode *node = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [node setFontSize:14];
    [node setText:[NSString stringWithFormat:@"-%d", lostHP]];
    node.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    node.position = CGPointMake(pos.x*32+_curtitleMap.position.x, (pos.y+_offsetTop)*32);
    [self addChild:node];
    
    [self performSelector:@selector(hideFightLostHPTip:) withObject:node afterDelay:1.0];
}

- (void)hideFightLostHPTip:(SKNode *)node {
    SKAction *action = [SKAction fadeOutWithDuration:1.0];
    SKAction *moveaction = [SKAction moveByX:0 y:10 duration:1.0];
    [node runAction:[SKAction group:@[action, moveaction]]];
}

// 获得道具
- (void)getItemWithGid:(int)gid {
    NSDictionary *props = [_curtitleMap propertiesForGid:gid];
    // 钥匙
    NSString *value = [props valueForKey:@"key"];
    if (value && [value integerValue] == 1) {
        _hero.YellowKeyCount ++;
        [ProgressHUD showSuccess:@"获得黄色钥匙"];
    } else if (value && [value integerValue] == 2) {
        _hero.BlueKeyCount ++;
        [ProgressHUD showSuccess:@"获得蓝色钥匙"];
    } else if (value && [value integerValue] == 3) {
        _hero.RedKeyCount ++;
        [ProgressHUD showSuccess:@"获得红色钥匙"];
    }  else if (value && [value integerValue] == 4) {
        _hero.YellowKeyCount ++;
        _hero.BlueKeyCount ++;
        _hero.RedKeyCount ++;
        [ProgressHUD showSuccess:@"所有钥匙+1"];
    }
    
    // 攻击力
    value = [props valueForKey:@"Attack"];
    if (value && [value integerValue] > 0) {
        _hero.Attack += [value integerValue];
        [ProgressHUD showSuccess:[NSString stringWithFormat:@"攻击力 +%d ", [value integerValue]]];
    }
    // 防御力
    value = [props valueForKey:@"Defense"];
    if (value && [value integerValue] > 0) {
        _hero.Defense += [value integerValue];
        [ProgressHUD showSuccess:[NSString stringWithFormat:@"防御力 +%d ", [value integerValue]]];
    }
    // 血
    value = [props valueForKey:@"HP"];
    if (value && [value integerValue] > 0) {
        _hero.HeroHP += [value integerValue];
        [ProgressHUD showSuccess:[NSString stringWithFormat:@"生命值 +%d ", [value integerValue]]];
    }
    value = [props valueForKey:@"double"];
    if (value && [value integerValue] > 0) {
        _hero.HeroHP *= 2;
        [ProgressHUD showSuccess:@"生命值 翻倍 "];
    }
    // 等级
    value = [props valueForKey:@"grade"];
    if (value && [value integerValue] > 0) {
        _hero.Experience += [value integerValue]*100;
        [ProgressHUD showSuccess:[NSString stringWithFormat:@"经验 +%d", [value integerValue]*100]];
    }
    // 金币
    value = [props valueForKey:@"coin"];
    if (value && [value integerValue] > 0) {
        _hero.Gold += [value integerValue];
        [ProgressHUD showSuccess:[NSString stringWithFormat:@"金币 +%d", [value integerValue]]];
    }
    
    // 1楼查看器
    value = [props valueForKey:@"predict"];
    if (value && [value integerValue] > 0) {
        _hero.Predict = YES;
        [ProgressHUD showSuccess:@"获得查看器，通过左侧的查看器可以看到怪物的属性"];
    }
    
    // 锄头
    value = [props valueForKey:@"hoe"];
    if (value && [value integerValue] > 0) {
        _hero.Attack += 100;
        [ProgressHUD showSuccess:@"攻击力 +100"];
    }
    
    // 7楼的十字架
    value = [props valueForKey:@"Promote"];
    if (value && [value integerValue] > 0) {
        //
        _hero.Experience += 150;
        [ProgressHUD showSuccess:@"获得经验十字架，经验 +150"];
    }
    
    // 9楼的飞行器
    value = [props valueForKey:@"flight"];
    if (value && [value integerValue] > 0) {
        //
        _hero.Flight = YES;
       [ProgressHUD showSuccess:@"获得飞行器,你可以在右侧选择要飞往的楼层"];
       [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_RunToFloor object:[NSNumber numberWithInteger:_curMapIndex]];
    }
    
    [self updateHeroInfo];
}

- (BOOL)getCanFlyFlag {
    return _hero.Flight;
}

- (NSInteger)getMaxCanFlyIndex {
    return _hero.MaxFloor;
}

- (NSInteger)getCurMapIndex {
    return _curMapIndex;
}

// 开门
- (BOOL)openTheDoorWithGid:(int)gid {
    NSDictionary *props = [_curtitleMap propertiesForGid:gid];
    NSString *value = [props valueForKey:@"door"];
    if (value && [value integerValue] == 0) {
        if (_hero.YellowKeyCount > 0) {
            _hero.YellowKeyCount --;
            [self updateHeroInfo];
            return YES;
        } else {
            [ProgressHUD showError:@"黄色钥匙不足"];
        }
    } else if (value && [value integerValue] == 1) {
        if (_hero.BlueKeyCount > 0) {
            _hero.BlueKeyCount --;
            [self updateHeroInfo];
            return YES;
        } else {
            [ProgressHUD showError:@"蓝色钥匙不足"];
        }
    } else if (value && [value integerValue] == 2) {
        if (_hero.RedKeyCount > 0) {
            _hero.RedKeyCount --;
            [self updateHeroInfo];
            return YES;
        } else {
            [ProgressHUD showError:@"红色钥匙不足"];
        }
    } else if (value && [value integerValue] == 3) {
        if (_hero.BlackKeyCount > 0) {
            return YES;
        } else {
        }
    }
    
    return NO;
}

- (void)removeTileWithLayerType:(enumMapLayerType)type WithPoint:(CGPoint)point {
    [self removeTileWithMapIndex:_curMapIndex withType:type WithPoint:point];
}

- (void)removeTileWithMapIndex:(NSInteger)mapIndex withType:(enumMapLayerType)type WithPoint:(CGPoint)point {
    if (_mapArray.count <= mapIndex) {
        return;
    }
    TWTiledMap *map = [_mapArray objectAtIndex:mapIndex];
    switch (type) {
        case kMapLayer_Wall:
            [map.wall removeTileAtCoord:[map.wall coordForPoint:point]];
            break;
        case kMapLayer_Road:
            [map.road removeTileAtCoord:[map.road coordForPoint:point]];
            break;
        case kMapLayer_Enemy:
            [map.enemy removeTileAtCoord:[map.enemy coordForPoint:point]];
            break;
        case kMapLayer_Item:
            [map.item removeTileAtCoord:[map.item coordForPoint:point]];
            break;
        case kMapLayer_Upfloor:
            [map.upfloor removeTileAtCoord:[map.upfloor coordForPoint:point]];
            break;
        case kMapLayer_Downfloor:
            [map.downfloor removeTileAtCoord:[map.downfloor coordForPoint:point]];
            break;
        case kMapLayer_Door:
            [map.door removeTileAtCoord:[map.door coordForPoint:point]];
            break;
        case kMapLayer_Other:
            [map.other removeTileAtCoord:[map.other coordForPoint:point]];
            break;
        case kMapLayer_NPC:
            [map.npc removeTileAtCoord:[map.npc coordForPoint:point]];
            break;
        case kMapLayer_HeroPoint:
            [map.heroPoint removeTileAtCoord:[map.heroPoint coordForPoint:point]];
            break;
        default:
            break;
    }
    
    [_removeItemArray addObject:@{@"MapIndex":[NSNumber numberWithInteger:mapIndex],
                                  @"LayerType":[NSNumber numberWithInteger:type],
                                  @"PointX":[NSNumber numberWithFloat:point.x],
                                  @"PointY":[NSNumber numberWithFloat:point.y]}];
}

#pragma mark - alertViewDelaget
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == RESTARTALERTTAG) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            [self restartGame];
        }
    }
    _isHeroBusy = NO;
    if (buttonIndex != alertView.cancelButtonIndex) {
        int shoptype = (int)alertView.tag - ShopViewTag;
        if (shoptype == 1) {
            // 小商店
            if (_hero.Gold >= 30) {
                _hero.Gold -= 30;
                if (buttonIndex == 1) {
                    _hero.HeroHP += 1000;
                } else if (buttonIndex == 2) {
                    _hero.Attack += 5;
                } else if (buttonIndex == 3) {
                    _hero.Defense += 5;
                }
                [self updateHeroInfo];
                
                if (_hero.Gold >= 30) {
                    [self showShopWithType:(int)(alertView.tag-ShopViewTag)];
                }
            } else {
                [ProgressHUD showError:@"金币不足"];
            }
        } else if (shoptype == 2) {
            // 大商店
            if (_hero.Gold >= 300) {
                _hero.Gold -= 300;
                if (buttonIndex == 1) {
                    _hero.HeroHP += 10000;
                } else if (buttonIndex == 2) {
                    _hero.Attack += 50;
                } else if (buttonIndex == 3) {
                    _hero.Defense += 50;
                }
                [self updateHeroInfo];
                
                if (_hero.Gold >= 300) {
                    [self showShopWithType:(int)(alertView.tag-ShopViewTag)];
                }
            } else {
                [ProgressHUD showError:@"金币不足"];
            }
        } else if (shoptype == 4) {
            // 经验商店
            if (_hero.Experience >= 30) {
                _hero.Experience -= 30;
                if (buttonIndex == 1) {
                    _hero.HeroHP += 1200;
                } else if (buttonIndex == 2) {
                    _hero.Attack += 7;
                } else if (buttonIndex == 3) {
                    _hero.Defense += 7;
                }
                [self updateHeroInfo];
                
                if (_hero.Experience >= 30) {
                    [self showShopWithType:(int)(alertView.tag-ShopViewTag)];
                }
            } else {
                [ProgressHUD showError:@"经验不足"];
            }
        } else if (shoptype == 5) {
            // 钥匙商店
            if (buttonIndex == 1) {
                if (_hero.Gold > 30) {
                    _hero.Gold -= 30;
                    _hero.YellowKeyCount += 1;
                } else {
                    [ProgressHUD showError:@"金币不足"];
                }
            } else if (buttonIndex == 2) {
                if (_hero.Gold > 50) {
                    _hero.Gold -= 50;
                    _hero.BlueKeyCount += 1;
                } else {
                    [ProgressHUD showError:@"金币不足"];
                }
            } else if (buttonIndex == 3) {
                if (_hero.Gold > 100) {
                    _hero.Gold -= 100;
                    _hero.RedKeyCount += 1;
                } else {
                    [ProgressHUD showError:@"金币不足"];
                }
            }
            [self updateHeroInfo];
            
        } else if (shoptype == 6) {
            // 联合商店
            if (_hero.Experience >= 100 && _hero.Gold >= 100 ) {
                _hero.Experience -= 100;
                _hero.Gold -= 100;
                _hero.HeroHP += 2000;
                _hero.Attack += 20;
                _hero.Defense += 20;

                [self updateHeroInfo];
                
                if (_hero.Experience >= 100 && _hero.Gold >= 100) {
                    [self showShopWithType:(int)(alertView.tag-ShopViewTag)];
                }
            } else if (_hero.Experience < 100){
                [ProgressHUD showError:@"经验不足"];
            } else {
                [ProgressHUD showError:@"金币不足"];
            }
        } else if (shoptype == 7) {
            // 经验商店
            if (_hero.Experience >= 300) {
                _hero.Experience -= 300;
                if (buttonIndex == 1) {
                    _hero.HeroHP += 12000;
                } else if (buttonIndex == 2) {
                    _hero.Attack += 70;
                } else if (buttonIndex == 3) {
                    _hero.Defense += 70;
                }
                [self updateHeroInfo];
                
                if (_hero.Experience >= 300) {
                    [self showShopWithType:(int)(alertView.tag-ShopViewTag)];
                }
            } else {
                [ProgressHUD showError:@"经验不足"];
            }
        }
        
    }
}

#pragma mark - 保存和读取
- (void)saveGame {
    // 楼层位置
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:_curMapIndex] forKey:@"NSUD_MAP_CurMapIndex"];
    // 英雄信息
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_hero.HeroHP] forKey:@"NSUD_HERO_HP"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_hero.Attack] forKey:@"NSUD_HERO_Attack"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_hero.Defense] forKey:@"NSUD_HERO_Defense"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_hero.Gold] forKey:@"NSUD_HERO_Gold"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_hero.Experience] forKey:@"NSUD_HERO_Experience"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_hero.Flight] forKey:@"NSUD_HERO_Flight"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_hero.Predict] forKey:@"NSUD_HERO_Predict"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_hero.MaxFloor] forKey:@"NSUD_HERO_MaxFloor"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_hero.RedKeyCount] forKey:@"NSUD_HERO_RedKeyCount"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_hero.YellowKeyCount] forKey:@"NSUD_HERO_YellowKeyCount"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_hero.BlueKeyCount] forKey:@"NSUD_HERO_BlueKeyCount"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_hero.BlackKeyCount] forKey:@"NSUD_HERO_BlackKeyCount"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_hero.currentDirection] forKey:@"NSUD_HERO_currentDirection"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:_hero.currectPoint.x] forKey:@"NSUD_HERO_CurrectPointX"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:_hero.currectPoint.y] forKey:@"NSUD_HERO_CurrectPointY"];
    // 已经消除了的点
    [[NSUserDefaults standardUserDefaults] setObject:_removeItemArray forKey:@"NSUD_MAP_RemoveItemInfo"];
}

- (void)readGame {
    NSNumber *curMapIndex = [[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_MAP_CurMapIndex"];
    if (curMapIndex) {
        NSInteger pointx = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_CurrectPointX"] integerValue];
        NSInteger pointy = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_CurrectPointY"] integerValue];
        CGPoint curpoint = CGPointMake(pointx, pointy);
        
        [_hero removeFromParent];
        _hero = nil;
        _hero = [[TWHeroSprite alloc] initWithPosition:[self getPointWithIndexPoint:curpoint] withScale:_mapScale];
        _hero.HeroHP = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_HP"] integerValue];
        _hero.Attack = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_Attack"] integerValue];
        _hero.Defense = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_Defense"] integerValue];
        _hero.Gold = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_Gold"] integerValue];
        _hero.Experience = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_Experience"] integerValue];
        _hero.Flight = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_Flight"] boolValue];
        _hero.Predict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_Predict"] boolValue];
        _hero.MaxFloor = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_MaxFloor"] integerValue];
        _hero.RedKeyCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_RedKeyCount"] integerValue];
        _hero.YellowKeyCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_YellowKeyCount"] integerValue];
        _hero.BlueKeyCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_BlueKeyCount"] integerValue];
        _hero.BlackKeyCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_BlackKeyCount"] integerValue];
        _hero.currentDirection = (enumHeroMove)[[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_HERO_currentDirection"] integerValue];

        if (curMapIndex > 0) {
            _curMapIndex = [curMapIndex integerValue];
            [self updateMap:YES];
        }
        
        [_hero setPosition:[self getPointWithIndexPoint:curpoint]];
        _hero.currectPoint = curpoint;
        [self moveMapWithNeedUpdate:YES];
        [self addChild:_hero];
        
        NSArray *removeItemArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_MAP_RemoveItemInfo"];
        for (NSDictionary *dict in removeItemArray) {
            [self removeTileWithMapIndex:[[dict objectForKey:@"MapIndex"] integerValue]
                                withType:(enumMapLayerType)[[dict objectForKey:@"LayerType"] integerValue]
                               WithPoint:CGPointMake([[dict objectForKey:@"PointX"] integerValue], [[dict objectForKey:@"PointY"] integerValue])];
        }
        
        [self updateHeroInfo];
    }
}

- (void)restartGame {
    [_curtitleMap removeFromParent];
    _curtitleMap = nil;
    [_mapArray removeAllObjects];
    [_removeItemArray removeAllObjects];
    [self initMap];
    
    [_hero removeFromParent];
    _hero = nil;
    [self initHero];
    
    [self updateHeroInfo];

    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_RunToFloor object:[NSNumber numberWithInteger:0]];
}

#pragma mark - TWPredictSceneDelegate
- (void)didRemovePredictScene {
    [_parentView presentScene:self];
    _isHeroBusy = NO;
}

@end

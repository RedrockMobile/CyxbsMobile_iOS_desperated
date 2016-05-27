//
//  TW_HeroSprite.m
//  Tower
//
//  Created by Jonear on 14-5-11.
//  Copyright (c) 2014年 Jonear. All rights reserved.
//


#import "TWHeroSprite.h"

#define MoveDistance (32 * _mapScale)
@implementation TWHeroSprite
{
    SKTextureAtlas *_atlas;
    CGFloat _mapScale;
}

- (id)initWithPosition:(CGPoint)position withScale:(CGFloat)scale
{
    _atlas = [SKTextureAtlas atlasNamed:@"hero"];
    self = (TWHeroSprite*)[TWHeroSprite spriteNodeWithTexture:[_atlas textureNamed:@"hero"]];
    if (self) {
        _mapScale = scale;
        self.xScale = scale;
        self.yScale = scale;
        self.position = position;
        self.HeroHP = 1000;
        self.Attack = 10;
        self.Defense = 10;
        self.Gold = 0;
        self.Experience = 0;
        self.RedKeyCount = 0;
        self.BlueKeyCount = 1;
        self.BlackKeyCount = 0;
        self.YellowKeyCount = 1;
        self.Flight = NO;
        self.Predict = NO;
        self.MaxFloor = 0;
        
        if (APPDEBUG) {
            self.HeroHP = 10000;
            self.Attack = 10000;
            self.Defense = 10000;
            self.Gold = 100000;
            self.Experience = 10000;
            self.RedKeyCount = 1000;
            self.BlueKeyCount = 1000;
            self.YellowKeyCount = 1000;
            self.BlackKeyCount = 1;
            self.MaxFloor = 20;
            self.Flight = YES;
            self.Predict = YES;
        }
    }
    return self;
}

- (void)heroMoveTo:(enumHeroMove)move
{
    if (![self isCanMove:move]) {
        return;
    }
    
//    [self removeAllActions];
    
    NSMutableArray *textures = [[NSMutableArray alloc] init];
    _atlas = [SKTextureAtlas atlasNamed:@"hero"];
    NSString *textureNameString;
    SKAction *moveAction;
    if (move == kMoveDown) {
        textureNameString = @"hero_down";
        moveAction = [SKAction moveByX:0 y:-MoveDistance duration:0.15];
    } else if (move == kMoveLeft) {
        textureNameString = @"hero_left";
        moveAction = [SKAction moveByX:-MoveDistance y:0 duration:0.15];
    } else if (move == kMoveUp) {
        textureNameString = @"hero_up";
        moveAction = [SKAction moveByX:0 y:MoveDistance duration:0.15];
    } else if (move == kMoveRight) {
        textureNameString = @"hero_right";
        moveAction = [SKAction moveByX:MoveDistance y:0 duration:0.15];
    }
    _currentDirection = move;
    
    for (int i=4; i>0; i--) {
        SKTexture *texture = [_atlas textureNamed:[NSString stringWithFormat:@"%@%d", textureNameString, i]];
        [textures addObject:texture];
    }
    
    SKAction *imageAction = [SKAction animateWithTextures:textures timePerFrame:0.15];
    
    [self runAction:[SKAction group:@[imageAction, moveAction]]];

}

- (BOOL)isCanMove:(enumHeroMove)direction
{
    if (direction == kMoveDown && _currectPoint.y==0) {
        return NO;
    } else if (direction == kMoveLeft && _currectPoint.x==0) {
        return NO;
    } else if (direction == kMoveUp && _currectPoint.y==10) {
        return NO;
    } else if (direction == kMoveRight && _currectPoint.x==10) {
        return NO;
    }
    
    
    if (direction == kMoveDown) {
        _currectPoint.y --;
    } else if (direction == kMoveLeft) {
        _currectPoint.x --;
    } else if (direction == kMoveUp) {
        _currectPoint.y ++;
    } else if (direction == kMoveRight) {
        _currectPoint.x ++;
    }
    
    NSLog(@"x=%f, y=%f", _currectPoint.x, _currectPoint.y);
    return YES;
}

@end

//
//  TWPredictScene.h
//  Tower
//
//  Created by Jonear on 14/12/25.
//  Copyright (c) 2014年 Jonear. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol TWPredictSceneDelegate;
@class TWHeroSprite;

@interface TWPredictScene : SKScene

@property (weak, nonatomic) id<TWPredictSceneDelegate> predictDelegate;

- (void)setEnemyDataArray:(NSArray *)array withHero:(TWHeroSprite *)hero;

@end

@protocol TWPredictSceneDelegate <NSObject>

- (void)didRemovePredictScene;

@end

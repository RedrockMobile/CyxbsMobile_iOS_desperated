//
//  TWPredictScene.m
//  Tower
//
//  Created by Jonear on 14/12/25.
//  Copyright (c) 2014年 Jonear. All rights reserved.
//

#import "TWPredictScene.h"
#import "TWEnemySprite.h"
#import "TWHeroSprite.h"

@implementation TWPredictScene {
    SKSpriteNode *_closeNode;
}

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        _closeNode = [[SKSpriteNode alloc] initWithImageNamed:@"close"];
        _closeNode.position = CGPointMake(PHOTOWIDTH-32*2, PHOTOHEIGHT-32);
        _closeNode.size = CGSizeMake(16, 16);

    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //    /* Called when a touch begins */
    if (_predictDelegate && [_predictDelegate respondsToSelector:@selector(didRemovePredictScene)]) {
        [_predictDelegate didRemovePredictScene];
    }
}

- (void)setEnemyDataArray:(NSArray *)array withHero:(TWHeroSprite *)hero {
    [self removeAllChildren];
    [self addChild:_closeNode];
    
    if (array.count == 0) {
        SKLabelNode *labelNode = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        labelNode.position = CGPointMake(PHOTOWIDTH-PHOTOHEIGHT-32, PHOTOHEIGHT-150);
        labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        labelNode.fontSize = 17;
        labelNode.text = [NSString stringWithFormat:@"这层没有怪物，到别的地方看看吧"];
        [self addChild:labelNode];
        return;
    }
    
    int i = 1;
    for (TWEnemySprite *node in array) {
        node.position = CGPointMake(PHOTOWIDTH-PHOTOHEIGHT, PHOTOHEIGHT - 37*i++ );
        [self addChild:node];
        
        SKLabelNode *labelNode = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        labelNode.position = CGPointMake(node.position.x+32, node.position.y);
        labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        labelNode.fontColor = [UIColor brownColor];
        labelNode.fontSize = 11;
        labelNode.text = [NSString stringWithFormat:@"%@ 生命值:%d 金币:%d 经验:%d", node.name, node.HP, node.Coin, node.Experience];
        [self addChild:labelNode];
        
        SKLabelNode *labelNode2 = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        labelNode2.position = CGPointMake(node.position.x+32, node.position.y-16);
        labelNode2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        labelNode2.fontColor = [UIColor whiteColor];
        labelNode2.fontSize = 11;
        
        if (node.Defense >= hero.Attack) {
            labelNode2.text = [NSString stringWithFormat:@"攻击力:%d 防御力:%d 需要消耗:未知", node.Attack, node.Defense];
        } else if (hero.Defense >= node.Attack){
            labelNode2.text = [NSString stringWithFormat:@"攻击力:%d 防御力:%d 需要消耗:0", node.Attack, node.Defense];
        } else {
            int dismissHp = (node.HP/(float)(hero.Attack-node.Defense))*(node.Attack-hero.Defense);
            
            labelNode2.text = [NSString stringWithFormat:@"攻击力:%d 防御力:%d 需要消耗:%d", node.Attack, node.Defense, dismissHp];
        }
        [self addChild:labelNode2];
    }
}

@end

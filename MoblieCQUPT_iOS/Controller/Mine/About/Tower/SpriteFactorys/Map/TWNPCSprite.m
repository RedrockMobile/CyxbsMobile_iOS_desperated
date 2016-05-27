//
//  TWNPCSprite.m
//  Tower
//
//  Created by Jonear on 14/12/21.
//  Copyright (c) 2014年 Jonear. All rights reserved.
//

#import "TWNPCSprite.h"

@interface TWNPCSprite() <UIAlertViewDelegate>

@end

@implementation TWNPCSprite {
    int _NPCType;
    NPCCompleteBlock _completeBlock;
    UIAlertView *_alertView;
}

- (id)initWithType:(int)type{
    self = [super init];
    if (self) {
        _NPCType = type;
    }
    return self;
}

- (void)talkToNpcWithComplete:(NPCCompleteBlock)block {
    _completeBlock = [block copy];
    NSLog(@"NPC:%d", _NPCType);
    if (_NPCType == 0) {
        [self showAlertTipViewWithName:@"仙女" WithString:@"欢迎来到魔塔世界，好了我就不多说什么了，加油"];
    } else if (_NPCType == 1) {
        [self showAlertTipViewWithName:@"老人" WithString:@"感谢你来救我，我把我的功力全部传授给你了，呵呵，其实我也是菜鸟啦"];
    } else if (_NPCType == 2) {
        [self showAlertTipViewWithName:@"老人" WithString:@"感谢你来救我，我把我的功力全部传授给你了，其实我是更大的菜鸟"];
    } else if (_NPCType == 3) {
        [self showAlertTipViewWithName:@"小偷" WithString:@"感谢你来救我，这是二层铜门的钥匙，再见了"];
    } else if (_NPCType == 8) {
        [self showAlertTipViewWithName:@"老人" WithString:@"我这有500点金币，就送给你了"];
    } else if (_NPCType == 9) {
        [self showAlertTipViewWithName:@"老人" WithString:@"我这有500点经验，就送给你了"];
    } else if (_NPCType == 10) {
        [self showAlertTipViewWithName:@"丫头" WithString:@"小猪，你终于来啦，我是丫头，我在这里，么么哒"];
    }
}

- (void)showAlertTipViewWithName:(NSString *)name WithString:(NSString *)string {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:name
                                                        message:string
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (_completeBlock) {
        _completeBlock();
        _completeBlock = nil;
    }
}

@end

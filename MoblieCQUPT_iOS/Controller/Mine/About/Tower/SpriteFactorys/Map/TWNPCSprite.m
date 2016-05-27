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
        [self showAlertTipViewWithName:@"主页君" WithString:@"快去追上公主呀,如果被你追上了,就让你嘿嘿嘿。"];
    } else if (_NPCType == 1) {
        [self showAlertTipViewWithName:@"老司机" WithString:@"感谢你来救我，我要把我毕生的功力全部传授给你,别说话，快上车!"];
    } else if (_NPCType == 2) {
        [self showAlertTipViewWithName:@"老司机" WithString:@"感谢你来救我，我把我的功力全部传授给你了，以后你也是老司机了"];
    } else if (_NPCType == 3) {
        [self showAlertTipViewWithName:@"小偷" WithString:@"感谢你来救我，这是二层铜门的钥匙，再见了"];
    } else if (_NPCType == 8) {
        [self showAlertTipViewWithName:@"老人" WithString:@"我这有500点金币，就送给你了"];
    } else if (_NPCType == 9) {
        [self showAlertTipViewWithName:@"老人" WithString:@"我这有500点经验，就送给你了"];
    } else if (_NPCType == 10) {
        [self showAlertTipViewWithName:@"小萝莉" WithString:@"呀,被追到了,要嘿嘿嘿了。~~~~(>_<)~~~~"];
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

//
//  emojiDetective.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface emojiDetective : NSObject
- (NSString *)detectiveAndChangeString:(NSString *)str;
- (NSString *)transferEmoji:(NSString *)str;
@end

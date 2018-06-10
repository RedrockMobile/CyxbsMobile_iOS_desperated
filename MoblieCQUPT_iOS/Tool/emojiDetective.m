//
//  emojiDetective.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "emojiDetective.h"

@implementation emojiDetective
- (NSString *)detectiveAndChangeString:(NSString *)str{
    const char *jsonString = "hello\\ud83d\\ude18\\ud83d\\ude18world\\u4e16\\u754chaha\\ud83d\\ude17bug\\ue056";
//    [str UTF8String];
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *goodMsg1 = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    return goodMsg1;
}
- (NSString *)transferEmoji:(NSString *)str{
    NSString *uniStr = [NSString stringWithUTF8String:[str UTF8String]];
    NSData *uniData = [uniStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *goodStr = [[NSString alloc] initWithData:uniData encoding:NSUTF8StringEncoding] ;
    return goodStr;
}
@end


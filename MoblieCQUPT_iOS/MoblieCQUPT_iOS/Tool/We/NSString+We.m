//
//  NSString+We.m
//  ConsultingTest
//
//  Created by RainyTunes on 8/21/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import "NSString+We.h"

@implementation NSString (We)
- (BOOL)isEmpty
{
    if ([self isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
@end

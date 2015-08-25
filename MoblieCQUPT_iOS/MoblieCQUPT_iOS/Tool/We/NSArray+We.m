//
//  NSArray+We.m
//  ConsultingTest
//
//  Created by RainyTunes on 8/21/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import "NSArray+We.h"

@implementation NSArray (We)
- (NSInteger)hasComponent:(NSString *)theComponent {
    NSInteger num = 0;
    for (NSString *aComponent in self) {
        if ([aComponent isEqualToString:theComponent]) {
            num++;
        }
    }
    return num;
}

@end
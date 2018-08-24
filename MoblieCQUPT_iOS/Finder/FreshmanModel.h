//
//  FreshmanModel.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/15.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FreshmanModel : NSObject
@property (nonatomic, strong)NSDictionary *dic;

- (void)networkLoadData:(NSString *)urlStr title:(NSString *)title;
@end

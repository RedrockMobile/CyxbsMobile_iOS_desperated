//
//  SYCCustomLayoutModel.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/9/26.
//  Copyright © 2018 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYCCustomLayoutModel : NSObject

@property (nonatomic, strong)NSMutableArray *inuseTools;
@property (nonatomic, strong)NSMutableArray *unuseTools;

+ (SYCCustomLayoutModel *)sharedInstance;

- (void)save;

@end

NS_ASSUME_NONNULL_END

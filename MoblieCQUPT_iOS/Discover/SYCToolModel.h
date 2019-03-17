//
//  SYCToolModel.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/9/26.
//  Copyright © 2018 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYCToolModel : NSObject

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *imageName;
@property (nonatomic, strong)NSString *className;

- (instancetype)initWithTitle:(NSString *)title ImageName:(NSString *)image ClassName:(NSString *)className;

@end

NS_ASSUME_NONNULL_END

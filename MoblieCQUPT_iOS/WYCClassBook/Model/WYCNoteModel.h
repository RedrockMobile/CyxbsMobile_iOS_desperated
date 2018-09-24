//
//  WYCNoteModel.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/9/23.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYCNoteModel : NSObject
@property (nonatomic, strong) NSMutableArray *noteArray;
- (void)getNote:(NSString *)stuNum idNum:(NSString *)idNum;
- (void)deleteNote:(NSString *)stuNum idNum:(NSString *)idNum noteId:(NSNumber *)noteId;

@end

NS_ASSUME_NONNULL_END

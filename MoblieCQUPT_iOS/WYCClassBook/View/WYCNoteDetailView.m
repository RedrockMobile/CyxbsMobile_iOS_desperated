//
//  WYCNoteDetailView.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/9/23.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "WYCNoteDetailView.h"
@interface WYCNoteDetailView()
@property (strong, nonatomic) IBOutlet UILabel *title;

@property (strong, nonatomic) IBOutlet UILabel *content;

@end
@implementation WYCNoteDetailView
+(WYCNoteDetailView *)initViewFromXib{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"WYCNoteDetailView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.frame = CGRectMake(0, 0, 270, 350);
        
    }
    return self;
}

-(void)initWithDic:(NSDictionary *)dic{
    
}

@end

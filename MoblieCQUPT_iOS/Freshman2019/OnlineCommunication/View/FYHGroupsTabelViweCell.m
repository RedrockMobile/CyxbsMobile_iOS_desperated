//
//  FYHGroupsTabelViweCell.m
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/3.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "FYHGroupsTabelViweCell.h"
//#import <Masonry.h>

@implementation FYHGroupsTabelViweCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.textColor = [UIColor colorWithRed:85.0f/255.0f green:85.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 15;
    frame.origin.y += 15;
    frame.size.width -= 30;
    frame.size.height -= 15;
    
    [super setFrame:frame];
}

@end

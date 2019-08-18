//
//  ActicytyQRCodeView.m
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/6.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "ActicytyQRCodeView.h"
//#import <Masonry.h>
#import <MBProgressHUD.h>

@interface ActicytyQRCodeView () <UIActionSheetDelegate>

@property (nonatomic, weak) UIImageView *QRCodeView;
@property (nonatomic, weak) UILabel *messageLabel;
@property (nonatomic, weak) UIView *messageWindow;
@property (nonatomic, weak) UILabel *note;              // 长按保存二维码提示
@property (nonatomic, weak) UIButton *cancelButton;

@end

@implementation ActicytyQRCodeView

- (instancetype)initWithImageURL:(NSString *)url andMessage:(NSString *)message
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
        
        UIButton *cancelButton = [[UIButton alloc] init];
        [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        self.cancelButton = cancelButton;
        
        UIView *messageWindow = [[UIView alloc] init];
        messageWindow.backgroundColor = [UIColor whiteColor];
        [self addSubview:messageWindow];
        self.messageWindow = messageWindow;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        self.QRCodeView.backgroundColor = [UIColor redColor];
        [self.messageWindow addSubview:imageView];
        self.QRCodeView = imageView;
        
//         加载图片
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSURL *imageURL = [NSURL URLWithString:url];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            UIImage *image = [UIImage imageWithData:imageData];

            dispatch_async(dispatch_get_main_queue(), ^{
                self.QRCodeView.image = image;
            });
        });
        
        // 添加长按手势
        UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imagelongTapClick:)];
        self.QRCodeView.userInteractionEnabled = YES;
        [self.QRCodeView addGestureRecognizer:longTap];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = message;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
        [self.messageWindow addSubview:label];
        self.messageLabel = label;
        
        UILabel *note = [[UILabel alloc] init];
        note.text = @"长按保存二维码";
        note.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
        note.font = [UIFont systemFontOfSize:13];
        note.textAlignment = NSTextAlignmentCenter;
        [self.messageWindow addSubview:note];
        self.note = note;
        
    };
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = [UIScreen mainScreen].bounds;
    
    self.cancelButton.frame = self.frame;
    
    [self.messageWindow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-TOTAL_TOP_HEIGHT);
        make.top.equalTo(self.QRCodeView).offset(-16);
        make.left.equalTo(self).offset(40);
        make.right.equalTo(self).offset(-40);
        make.bottom.equalTo(self.note).offset(5);
    }];
    
    [self.QRCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.messageLabel.mas_top).offset(-10);
        make.width.equalTo(self.QRCodeView.mas_height);
        make.left.equalTo(self.messageWindow).offset(16);
        make.right.equalTo(self.messageWindow).offset(-16);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageWindow).offset(40);
        make.right.equalTo(self.messageWindow).offset(-40);
    }];
    
    [self.note mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    }];
    
}

-(void)imagelongTapClick:(UILongPressGestureRecognizer*)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
//        UIImageWriteToSavedPhotosAlbum(self.QRCodeView.image, self, nil, nil);
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"保存成功";
//        [hud hide:YES afterDelay:1];
//
//        [self performSelector:@selector(dismissQRCode:) withObject:self afterDelay:1];
        UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
        actionSheet.title = @"保存二维码至手机";
        actionSheet.delegate = self;
        [actionSheet addButtonWithTitle:@"取消"];
        [actionSheet addButtonWithTitle:@"确定"];
        actionSheet.cancelButtonIndex = 0;
        
//        actionSheet
//        [self setButtonColor:actionSheet];
        [actionSheet showInView:self];
    }
}

//- (void)setButtonColor:(UIActionSheet *)actionSheet
//{
//    NSArray *actionSheetButtons = actionSheet.subviews;
//    for (UIView *subViwe in actionSheetButtons) {
//        if ([subViwe isKindOfClass:[UIButton class]]) {
//            UIButton *button = (UIButton*)subViwe;
//            if ([button.titleLabel.text isEqualToString:@"确定"]) {
//                [button setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
//            } else {
//                [button setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
//            }
//        }
//    }
//}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UIImageWriteToSavedPhotosAlbum(self.QRCodeView.image, self, nil, nil);
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"保存成功";
        [hud hide:YES afterDelay:1];
        
        [self performSelector:@selector(dismissQRCode:) withObject:self afterDelay:1];
    }
}

- (void)dismissQRCode:(ActicytyQRCodeView *)QRCode {
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)cancel {
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

@end

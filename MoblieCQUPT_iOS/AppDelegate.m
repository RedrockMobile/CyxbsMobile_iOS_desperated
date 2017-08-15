//
//  AppDelegate.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/8/18.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MineViewController.h"
#import "MBReleaseViewController.h"
#import "DetailTopicViewController.h"
#import "ExamScheduleViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UMSocialCore/UMSocialCore.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [MobClick setLogEnabled:YES];
    self.window.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager]setUmSocialAppkey:@""];
    [self configUSharePlatforms];
    [self confitUShareSettings];
    UMConfigInstance.appKey = @"573183a5e0f55a59c9000694";
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
   [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    //3D-Touch
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        [self creatShortCutItemWithIcon];
    }
    
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter]; //请求获取通知权限
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        //获取用户是否同意开启通知
        if (granted) {
            NSLog(@"request authorization successed!");
        }
    }];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    NSLog(@"%@",url);
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
        [tbc setSelectedIndex:1];
        NSString *topic_id = [url lastPathComponent];
        [NetWork NetRequestPOSTWithRequestURL:TOPICLIST_API WithParameter:nil WithReturnValeuBlock:^(id returnValue) {
            TopicModel *topic;
            NSArray *dataArray = returnValue[@"data"];
            for (NSDictionary *dic in dataArray) {
                if ([[dic[@"topic_id"] stringValue] isEqualToString:topic_id]) {
                    topic = [[TopicModel alloc]initWithDic:dic];
                    break;
                }
            }
            DetailTopicViewController *detailVC = [[DetailTopicViewController alloc]initWithTopic:topic];
            detailVC.hidesBottomBarWhenPushed = YES;
            [tbc.selectedViewController pushViewController:detailVC animated:YES];
            
            
        } WithFailureBlock:^{
            
        }];
//        [[tbc.viewControllers firstObject].navigationController pushViewController:vc animated:YES];
        // 其他如支付等SDK的回调
    }
    return result;
}

//- (void)applicationDidFinishLaunching:(UIApplication *)application{
//    
//}

#pragma mark - 友盟分享
- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxf06c56596c8b7c0e" appSecret:@"1d3e4421131ebb3320be2a8205fedc3c" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106178038"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3019710850"  appSecret:@"1542ea8cd042a11d8f16c615d9d82453" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}


#pragma mark - 3D-Touch

- (void)creatShortCutItemWithIcon{
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeDate];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeMail];
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeTime];
    UIApplicationShortcutIcon *icon4 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:[[UIApplicationShortcutItem alloc] initWithType:@"course" localizedTitle:@"本周课表" localizedSubtitle:nil icon:icon1 userInfo:nil]];
    [items addObject:[[UIApplicationShortcutItem alloc] initWithType:@"news" localizedTitle:@"社区热门" localizedSubtitle:nil icon:icon2 userInfo:nil]];
    [items addObject:[[UIApplicationShortcutItem alloc] initWithType:@"exam" localizedTitle:@"考试安排" localizedSubtitle:nil icon:icon3 userInfo:nil]];
    [items addObject:[[UIApplicationShortcutItem alloc] initWithType:@"release" localizedTitle:@"发送动态" localizedSubtitle:nil icon:icon4 userInfo:nil]];
    [UIApplication sharedApplication].shortcutItems = items;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
    if (![UserDefaultTool getStuNum]) {
        LoginViewController *login = [[LoginViewController alloc] init];
        login.loginSuccessHandler = ^(BOOL success) {
            if (success) {
                [self application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
            }
        };
        if (tbc.presentedViewController) {
            //要先dismiss结束后才能重新present否则会出现Warning: Attempt to present <UINavigationController: 0x7fdd22262800> on <UITabBarController: 0x7fdd21c33a60> whose view is not in the window hierarchy!就会present不出来登录页面
            [tbc.presentedViewController dismissViewControllerAnimated:NO completion:^{
                [tbc presentViewController:login animated:YES completion:nil];
            }];
        }else {
            [tbc presentViewController:login animated:NO completion:nil];
        }
    
    }
    else{
        if ([shortcutItem.type isEqualToString:@"course"]) {
            [tbc setSelectedIndex:0];
        }else if ([shortcutItem.type isEqualToString:@"news"]){
            [tbc setSelectedIndex:1];
        }else if ([shortcutItem.type isEqualToString:@"exam"]){
            [tbc setSelectedIndex:3];
          ExamScheduleViewController *vc = [[ExamScheduleViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [tbc.selectedViewController pushViewController:vc animated:YES];
        }else if ([shortcutItem.type isEqualToString:@"release"]){
            
            [tbc setSelectedIndex:1];
            MBReleaseViewController *vc = [[MBReleaseViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [tbc.selectedViewController pushViewController:vc animated:YES];
        }

    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end




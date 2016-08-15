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
#import "XBSGradeViewController.h"
#import "XBSFindClassroomViewController.h"
#import "MBReleaseViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //BUGHD
    //[BugHD handleCrashWithKey:@"24f1019e4d09ab778e0b9f2780ae4de0"];
    
    //3D-Touch
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        [self creatShortCutItemWithIcon];
    }
    
    //友盟统计
//    [MobClick startWithAppkey:@"573183a5e0f55a59c9000694" reportPolicy:BATCH   channelId:@""];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    [MobClick setAppVersion:version];
//    [MobClick startWithAppkey:@"55dc094a67e58e92f30048eb" reportPolicy:BATCH   channelId:@"Web"];
//    [MobClick setAppVersion:@"V2.3.0"];

    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault objectForKey:@"time"] != nil && [userDefault objectForKey:@"user_id"] != nil && ![[userDefault objectForKey:@"user_id"] isEqualToString:@""]) {
        NSDate *currentTime = [NSDate date];
        NSDate *dataTime = [userDefault objectForKey:@"time"];
        //选择是跳转到mainViewController还是loginViewController
        if ([dataTime timeIntervalSinceDate:currentTime] > 0) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            id view = [storyBoard instantiateViewControllerWithIdentifier:@"MainNavigation"];
            self.window.rootViewController = view;
            NSLog(@"%@,%@,%@",[userDefault objectForKey:@"user_id"],[userDefault objectForKey:@"nickname"],[userDefault objectForKey:@"photo_src"]);
        }else {
            [userDefault removeObjectForKey:@"stuNum"];
            [userDefault removeObjectForKey:@"idNum"];
            [userDefault removeObjectForKey:@"dataArray"];
            [userDefault removeObjectForKey:@"time"];
            [userDefault removeObjectForKey:@"user_id"];
            [userDefault removeObjectForKey:@"nickname"];
            [userDefault removeObjectForKey:@"photo_src"];
            [userDefault synchronize];
            LoginViewController *login = [[LoginViewController alloc]init];
            self.window.rootViewController = login;
        }
    }else {
        LoginViewController *login = [[LoginViewController alloc]init];
        self.window.rootViewController = login;
    }

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
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
    if ([shortcutItem.type isEqualToString:@"course"]) {
        [self launchViewController:0 withChoose:0];
    }else if ([shortcutItem.type isEqualToString:@"news"]){
        [self launchViewController:1 withChoose:0];
    }else if ([shortcutItem.type isEqualToString:@"exam"]){
        [self launchViewController:3 withChoose:1];
    }else if ([shortcutItem.type isEqualToString:@"release"]){
        [self launchViewController:1 withChoose:2];
    }
}

- (void)launchViewController:(NSInteger) selectIndex withChoose:(NSInteger) secondChooseIndex {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault objectForKey:@"time"] != nil) {
        NSDate *currentTime = [NSDate date];
        NSDate *dataTime = [userDefault objectForKey:@"time"];
        if ([dataTime timeIntervalSinceDate:currentTime] > 0) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *mainNavigationVC = [storyBoard instantiateViewControllerWithIdentifier:@"MainNavigation"];
            UITabBarController *tab = (UITabBarController *)mainNavigationVC.viewControllers[0];
            
            if (secondChooseIndex == 0) {
                tab.selectedIndex = selectIndex;
                self.window.rootViewController = mainNavigationVC;
            }else if (secondChooseIndex == 1) {
                tab.selectedIndex = selectIndex;
                self.window.rootViewController = mainNavigationVC;
            }else if (secondChooseIndex == 2) {
                tab.selectedIndex = selectIndex;
                self.window.rootViewController = mainNavigationVC;
                MBReleaseViewController *RVC = [[MBReleaseViewController alloc] init];
                [mainNavigationVC pushViewController:RVC animated:YES];
            }
        }else {
            [userDefault removeObjectForKey:@"stuNum"];
            [userDefault removeObjectForKey:@"idNum"];
            [userDefault removeObjectForKey:@"dataArray"];
            [userDefault removeObjectForKey:@"time"];
            [userDefault synchronize];
            LoginViewController *login = [[LoginViewController alloc]init];
            self.window.rootViewController = login;
        }
    }else {
        LoginViewController *login = [[LoginViewController alloc]init];
        self.window.rootViewController = login;
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




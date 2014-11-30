//
//  SRAppDelegate.m
//  DaZhe
//
//  Created by GeoBeans on 14-9-16.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRAppDelegate.h"
#import "MobClick.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SRPush1.h"
#import "Reward.h"
#import "SellerInfo.h"
#import "Evaluation.h"
#import "RewardEvaluation.h"
#import "RewardZan.h"
#import "ShopZan.h"
#import "KubeDetail.h"
#import "DiscountRecord.h"

@implementation SRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSThread sleepForTimeInterval:1.0];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if((![[NSUserDefaults standardUserDefaults] objectForKey:@"launchFirstTime"])||![[[NSUserDefaults standardUserDefaults] objectForKey:@"launchFirstTime"] isEqualToString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]){
        
        self.window.rootViewController = [story instantiateViewControllerWithIdentifier:@"introVC"];
    }
    else{
        self.window.rootViewController=[story instantiateViewControllerWithIdentifier:@"tabbarVC"];
    }
    
        
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //友盟
    [MobClick startWithAppkey:@"540fbde8fd98c5a4ec004878" reportPolicy:BATCH  channelId:nil];
    [MobClick checkUpdate:@"有新版本啦~" cancelButtonTitle:@"忽略此版本" otherButtonTitles:@"下载新版本"];
    
    [AVOSCloud setApplicationId:@"gtcxbmllzqs2xf95e9hx2xnyxfq156497mpljv4vfj36vk28"
                      clientKey:@"ca7q5647qv730cn15e9d5hq455ztqh4i9hk8poy4lpiy2q1u"];
    //注册子类
    [Reward registerSubclass];
    [RewardEvaluation registerSubclass];
    [RewardZan registerSubclass];
    [Evaluation registerSubclass];
    [SellerInfo registerSubclass];
    [ShopZan registerSubclass];
    [KubeDetail registerSubclass];
    [DiscountRecord registerSubclass];
    // 注册nofification
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0){
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
    }else{
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert
                                                | UIUserNotificationTypeBadge
                                                | UIUserNotificationTypeSound
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }

    //网络连接监测
    self.isReachable=YES;
    self.beenReachable=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.internetReachability = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    //开始监听，会启动一个run loop
    [self.internetReachability startNotifier];
    return YES;
}

#pragma mark - 网络通信检查
-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    
    //对连接改变做出响应处理动作
    NetworkStatus status = [curReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    
    if(status == NotReachable)
    {
        if (self.isReachable) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接异常" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            self.isReachable = NO;
        }
        return;
    }
    if (status==ReachableViaWiFi||status==ReachableViaWWAN) {
        
        if (!self.isReachable) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接信息" message:@"网络连接恢复" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            self.isReachable = YES;
        }
    }
}


- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    if (userInfo!=nil) {
       
        if ([[userInfo objectForKey:@"action"] isEqualToString:@"com.pushdemo.action"]) {
            
            SRPush1 *pushVC=[[SRPush1 alloc] init];
            
            pushVC.kubi=[userInfo objectForKey:@"kubi"];
            pushVC.sellerObjectId=[userInfo objectForKey:@"sellerObjectId"];
            pushVC.commentDiscountObjectId=[userInfo objectForKey:@"commentDiscountObjectId"];
            [self.window.rootViewController presentViewController:pushVC animated:YES completion:nil ];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

//
//  SRAppDelegate.h
//  DaZhe
//
//  Created by GeoBeans on 14-9-16.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface SRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability *internetReachability;
@property (nonatomic) BOOL isReachable;
@property (nonatomic) BOOL beenReachable;

@end

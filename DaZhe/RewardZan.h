//
//  RewardZan.h
//  DaZhe
//
//  Created by Mac on 11/10/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
  #import <AVOSCloud/AVOSCloud.h>
@interface RewardZan :AVObject <AVSubclassing>

@property(nonatomic,copy)NSString *rewardObjectId;

@property(nonatomic,copy)NSString *ZanUserObjectId;

@property(nonatomic,copy)NSString *UserLogoUrl;
@end

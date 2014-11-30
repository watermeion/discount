//
//  Reward.h
//  DaZhe
//
//  Created by Mac on 11/10/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
  #import <AVOSCloud/AVOSCloud.h>
@interface Reward : AVObject <AVSubclassing>
@property(nonatomic,copy) NSString *rewardContent;
@property(nonatomic,copy) NSNumber *rewardFee;
@property(nonatomic,copy) NSString *rewardShopName;
@property(nonatomic,copy) NSNumber *rewardAverage;
@property(nonatomic,copy) NSString *rewardStatus;
@property(nonatomic,copy) NSString *rewardShopType;
@property(nonatomic,copy) NSString *rewardSubTitle;
@property(nonatomic,copy) NSString *rewardTitle;
@property(nonatomic,copy) NSString *rewardUserAccount;
@property(nonatomic,copy) NSNumber *kubeFee;
@property(nonatomic,copy) NSNumber *kubeBalance;
@property(nonatomic,copy) NSNumber *rewardPriseCount;

@property(nonatomic,copy) NSString *rewardShopLocationDescri;
@property(nonatomic,copy) NSString *city;
@property(nonatomic,copy) NSString *district;

@property(nonatomic,copy) NSDate *rewardStartTime;
@property(nonatomic,copy) NSDate *rewardEndTime;



@property(nonatomic,copy) AVFile *rewardUserLogo;
@property(nonatomic,copy) AVFile *rewardImage;

@end

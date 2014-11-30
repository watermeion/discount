//
//  SROfferARewardDataObject.h
//  DaZhe
//
//  Created by Mac on 11/8/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SROfferARewardDataObject : NSObject

//定义属性
@property(strong,nonatomic)UIImage *usrProfileImage;
@property(strong,nonatomic)UIImage *usrLevelImage;
@property(strong,nonatomic)NSMutableArray *likersImageArray;
@property(strong,nonatomic)UIImage *storeImage;
@property(strong,nonatomic)NSString *storeAddress;
@property(strong,nonatomic)NSString *storeDetails;
@property(strong,nonatomic)NSString *storeRewardAverage;
@property(strong,nonatomic)NSString *storeZone;
@property(strong,nonatomic)NSString *storeName;
@property(strong,nonatomic)NSString *usrNikiName;
@property(strong,nonatomic)NSString *rewardTitleName;
@property(strong,nonatomic)NSString *rewardMoneyNumber;
@property(strong,nonatomic)NSString *storeBelongings;
@property(strong,nonatomic)NSString *likersNumber;
@property(strong,nonatomic)NSString *chanllageNum;



@end

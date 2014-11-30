//
//  DiscountRecord.h
//  DaZhe
//
//  Created by Mac on 11/26/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface DiscountRecord : AVObject <AVSubclassing>

@property (nonatomic,copy)NSNumber *consumptionFee;
@property (nonatomic,copy)NSNumber *discountFee;
@property(nonatomic,copy)NSString *discountMemberAccount;
@property(nonatomic,copy)NSString *discountMemberLogoURL;
@property(nonatomic,copy)NSString *discountMemberName;
@property(nonatomic,copy)NSString *discountMemberObjectID;
@property (nonatomic,copy)NSNumber *discountSellerValue;
@property(nonatomic,copy)NSString *discountShopLocationDescri;
@property(nonatomic,copy)NSString *discountShopObjectID;
@property(nonatomic,copy)NSString *discountShopPointer;
@property(nonatomic)BOOL isEvaluated;
@property(nonatomic,copy)NSString *shopName;
@property (nonatomic,copy)NSNumber *shopStar;
@end

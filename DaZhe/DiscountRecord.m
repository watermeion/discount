//
//  DiscountRecord.m
//  DaZhe
//
//  Created by Mac on 11/26/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "DiscountRecord.h"

@implementation DiscountRecord
@dynamic consumptionFee;
@dynamic discountFee;
@dynamic discountMemberAccount;
@dynamic discountMemberLogoURL;
@dynamic discountMemberName;
@dynamic discountMemberObjectID;
@dynamic discountSellerValue;
@dynamic discountShopLocationDescri;
@dynamic discountShopObjectID;
@dynamic discountShopPointer;
@dynamic isEvaluated;
@dynamic shopName;
@dynamic shopStar;
+(NSString *)parseClassName {
    return @"DiscountRecord";
}


@end
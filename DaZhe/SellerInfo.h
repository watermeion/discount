//
//  SellerInfo.h
//  DaZhe
//
//  Created by Mac on 11/15/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
@interface SellerInfo : AVObject <AVSubclassing>
@property(nonatomic,copy)NSString *sellerAccountBalance;
@property(nonatomic,copy)NSString *sellerAppointTip;
@property(nonatomic,copy)NSString *sellerAppointmentPhone;
@property(nonatomic,copy)NSNumber *sellerAllScore;
@property(nonatomic,copy)NSNumber *sellerAverageCost;
@property(nonatomic,copy)NSString *sellerBusinessHour;
@property(nonatomic,copy)NSString *sellerCardNumber;
@property(nonatomic,copy)AVFile *sellerCardPicture;
@property(nonatomic,copy)NSString *sellerCardType;
@property(nonatomic,copy)NSString *sellerCity;
@property(nonatomic,copy)NSString *sellerClass;

@property(nonatomic,copy)NSString *sellerContactName;
@property(nonatomic,copy)NSNumber *sellerDiscountNumber;
@property(nonatomic,copy)NSString *sellerDiscountOtherInfo;
@property(nonatomic,copy)NSNumber *sellerDiscountShopNumber;
@property(nonatomic,copy)NSNumber *sellerDiscountShopValue;
@property(nonatomic,copy)NSNumber *sellerDiscountValue;
@property(nonatomic,copy)AVGeoPoint *sellerGeoPoint;
@property(nonatomic,copy)NSString *sellerIntroductionURL;
@property(nonatomic,copy)NSString *sellerKeyword;
@property(nonatomic,copy)NSString *sellerLocationDesri;
@property(nonatomic,copy)NSString *sellerLoginEmail;
@property(nonatomic,copy)NSString *sellerLoginName;

@property(nonatomic,copy) AVFile  *sellerLogo;

@property(nonatomic,copy)NSString *sellerMobile;
@property(nonatomic,copy)NSString *sellerName;
@property(nonatomic,copy)NSString *sellerOIsWifi;
@property(nonatomic,copy)NSString *sellerObjectID;
@property(nonatomic,copy)NSString *sellerOtherService;
@property(nonatomic,copy)NSString *sellerPhone;
@property(nonatomic,copy)NSArray *sellerPicture;
@property(nonatomic,copy)NSNumber *sellerPriseCount;
@property(nonatomic,copy)NSString *sellerQQ;
@property(nonatomic,copy)NSString *sellerRuleTip;
@property(nonatomic,copy)NSString *sellerSubClass;
@property(nonatomic,copy)NSString *sellerVerifyInfo;
@property(nonatomic,copy)NSString *sellerVerifyResult;
@property(nonatomic,copy)NSString *sellerWarn;
@property(nonatomic,copy)NSString *showInHome;

@end

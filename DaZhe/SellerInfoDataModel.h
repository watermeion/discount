//
//  SellerInfoDataModel.h
//  DaZhe
//
//  Created by Mac on 11/19/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface SellerInfoDataModel : NSObject
@property(strong,nonatomic)NSString *sellerName;
@property(strong,nonatomic)NSString *sellerDisCountInfo;
@property(strong,nonatomic)NSString *sellerDiscountOtherInfo;
@property(strong,nonatomic)UIImage *sellerStarImage;
@property(strong,nonatomic)AVFile *sellerImageFile;
@property(strong,nonatomic)NSString *sellerPhone;
@property(strong,nonatomic)NSString *sellerAddress;
@property(strong,nonatomic)NSString *sellerBusinessHours;
@property(strong,nonatomic)NSString *sellerPriseCount;
@property(strong,nonatomic)NSString *sellerAverage;
@property(strong,nonatomic)NSString *sellWarn;
@property(strong,nonatomic)NSString *sellerIsWifi;
@property(strong,nonatomic)NSString *sellerAppointTip;
@property(strong,nonatomic)NSString *sellerKeyword;



@end

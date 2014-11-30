//
//  RTUserInfo.h
//  Health
//
//  Created by GeoBeans on 14-6-8.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface SRUserInfo : AVObject <AVSubclassing>{
    
}

@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *mobilePhoneNumber;
@property (nonatomic,strong) NSString *email;
@property (nonatomic) BOOL isGuest;

@property (nonatomic,strong) NSNumber *depositCount;
@property (nonatomic,strong) NSNumber *accountBalance;
@property (nonatomic,strong) NSNumber *discountCount;
@property (nonatomic,strong) AVGeoPoint *depositLocation;

@property (nonatomic,strong) AVFile *userLogo;


+ (SRUserInfo *)shareInstance;

@end

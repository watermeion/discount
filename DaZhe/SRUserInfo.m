//
//  RTUserInfo.m
//  Health
//
//  Created by GeoBeans on 14-6-8.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "SRUserInfo.h"

@implementation SRUserInfo

@dynamic username;
@dynamic password;
@dynamic mobilePhoneNumber;
@dynamic email;
@dynamic isGuest;
@dynamic depositCount;
@dynamic accountBalance;
@dynamic discountCount;
@dynamic depositLocation;
@dynamic userLogo;


+ (NSString *)parseClassName {
    return @"_User";
}

+ (SRUserInfo*)shareInstance{
    
    static SRUserInfo* userInfo=nil;
    
    @synchronized(self)
    {
        if (!userInfo){
            userInfo = [[SRUserInfo alloc] init];
        }
        return userInfo;
    }
}

- (id)init{
    if(self = [super init]){
        
    }
    return self;
}

@end

//
//  KubeDetail.h
//  DaZhe
//
//  Created by Mac on 11/25/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
@interface KubeDetail : AVObject <AVSubclassing>

@property(nonatomic)int kubeFee;
@property(nonatomic,copy)NSString * kubeInObjectId;
@property(nonatomic,copy)NSString * kubeInReason;
@property(nonatomic,copy)NSString * kubeInSource;
@property(nonatomic,copy)NSString * kubeOutObjectId;
@property(nonatomic,copy)NSString * kubeOutReason;
@property(nonatomic,copy)NSString * kubeOutSource;
@property(nonatomic)int kubiFee;

@end

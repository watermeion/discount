//
//  KubeDetail.m
//  DaZhe
//
//  Created by Mac on 11/25/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "KubeDetail.h"

@implementation KubeDetail
@dynamic kubeFee;
@dynamic kubeInObjectId;
@dynamic kubeInReason;
@dynamic kubeInSource;
@dynamic kubeOutObjectId;
@dynamic kubeOutReason;
@dynamic kubeOutSource;
@dynamic kubiFee;

+ (NSString *)parseClassName {
    return @"KubeDetail";
}
@end

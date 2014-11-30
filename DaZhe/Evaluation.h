//
//  Evaluation.h
//  DaZhe
//
//  Created by Mac on 11/15/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>
#import <Foundation/Foundation.h>
@interface Evaluation : AVObject<AVSubclassing>

@property(nonatomic,copy)NSString *evaluationContent;
@property(nonatomic,copy)NSString *evaluationMemberAccount;
@property(nonatomic,copy)NSString *evaluationMemberLocation;
@property(nonatomic,copy)NSString *evaluationMemberLocationDescri;
@property(nonatomic,copy)NSString *evaluationMemberLogoURL;
@property(nonatomic,copy)NSString *evaluationMemberName;
@property(nonatomic,copy)NSString *evaluationMemberObjectID;
@property(nonatomic,copy)NSNumber *evaluationScoreEnvironment;
@property(nonatomic,copy)NSNumber *evaluationScoreServe;
@property(nonatomic,copy)NSNumber *evaluationScoreTaste;
@property(nonatomic,copy)NSString *evaluationShopConsumption;
@property(nonatomic,copy)NSString *evaluationShopName;
@property(nonatomic,copy)NSString *evaluationShopObjectID;
@property(nonatomic,copy)NSString *evaluationShopPointer;
@property(nonatomic,copy)NSNumber *evaluationStar;
@property(nonatomic,copy)NSString *evaluationTitle;
@end

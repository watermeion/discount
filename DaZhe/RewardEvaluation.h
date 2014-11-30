//
//  RewardEvaluation.h
//  DaZhe
//
//  Created by Mac on 11/10/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
  #import <AVOSCloud/AVOSCloud.h>
@interface RewardEvaluation : AVObject <AVSubclassing>

@property(nonatomic,copy) NSString *evaluationContent;
@property(nonatomic,copy) NSString *evaluationMemberLocationDescri;
@property(nonatomic,copy) NSString *evaluationMemberAccount;
@property(nonatomic,copy) NSString *evaluationMemberLocation;
@property(nonatomic,copy) NSString *evaluationMemberLogoURL;
@property(nonatomic,copy) NSString *evaluationMemberName;
@property(nonatomic,copy) NSString *evaluationMemberObjectID;
@property(nonatomic,copy) NSString *evaluationRewardObjectID;
@property(nonatomic,copy) NSString *evaluationRewardPointer;
@property(nonatomic,copy) NSString *evaluationTitle;



@end

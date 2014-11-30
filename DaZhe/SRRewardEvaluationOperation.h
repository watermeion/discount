//
//  SRRewardEvaluationOperation.h
//  DaZhe
//
//  Created by Mac on 11/13/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

//初始化shi，必须要初始化的数据  rewardObjectId dataSoure


#import <Foundation/Foundation.h>
#import "SRRewardEvaluationOperation.h"
#import "RewardZan.h"
#import "Reward.h"
#import "CommonMacro.h"
#import "SROfferARewardDataObject.h"
@interface SRRewardEvaluationOperation : NSObject

@property(nonatomic,strong)NSMutableDictionary *results;

@property NSInteger allCount;

@property(nonatomic,strong)NSString *rewardObjectId;
@property(nonatomic,weak)SROfferARewardDataObject *dataSoure;

//添加判断赞是否存在的函数
-(BOOL)checkObjectExistency:(NSString *)usrObjectId className:(NSString *)name Keyname:(NSString*)key;

-(BOOL)checkObjectExistencyWith2Conditions_value:(NSString *)usrObjectId className:(NSString *)name Keyname1:(NSString*)key keyname2:(NSString*)key2 value2:(NSString *)value2;
//点赞
-(void)pushPrise;
//评论
-(void)saveComment:(NSString *)comment;

//领赏
-(void)gainReward;

-(void)requestOnAVOS:(NSUInteger) numberOfPage;
-(void)receiveData:(NSArray *) objects;
-(void)handleError;

@end

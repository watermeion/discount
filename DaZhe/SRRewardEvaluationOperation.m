//
//  SRRewardEvaluationOperation.m
//  DaZhe
//
//  Created by Mac on 11/13/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "SRRewardEvaluationOperation.h"
#import "RewardEvaluation.h"

#import <AVOSCloud/AVOSCloud.h>
@implementation SRRewardEvaluationOperation


//提交请求
-(void)requestOnAVOS:(NSUInteger) numberOfPage
{
    AVQuery *query=[AVQuery queryWithClassName:@"RewardEvaluation"];
    query.cachePolicy=kPFCachePolicyNetworkElseCache;
    query.limit=3;
    query.skip=numberOfPage*(query.limit);
    if (self.rewardObjectId!=nil)
    {
        [query whereKey:@"evaluationRewardObjectID" equalTo:self.rewardObjectId];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error==nil)
            {
                //
                [self receiveData:objects];
                //提交query，查询每个悬赏的评论总条数
                AVQuery *queryCount=[AVQuery queryWithClassName:@"RewardEvaluation"];
                query.cachePolicy=kPFCachePolicyNetworkElseCache;
                [queryCount whereKey:@"evaluationRewardObjectID" equalTo:self.rewardObjectId];
                [queryCount countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
                    if (error==nil) {
                        self.allCount=number;
                    }
                    else
                    {
                        self.allCount=0;
                    }
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"RewardEvaluationDataChanged" object:nil];
                }];
                

            }
            else
            {
                NSLog(@"error at RewardEvaluation:%@",error.description);
                [self handleError];
            }
        }];
    }
}

//处理请求结果
-(void)receiveData:(NSArray *) objects
{
    if (self.results==nil) {
        self.results=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    for (RewardEvaluation *evaluationObj in objects) {
        [self.results setObject:evaluationObj forKey:evaluationObj.objectId];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RewardEvaluationDataChanged" object:nil];
}

//处理错误结果
-(void)handleError
{
    
    //向上级调用，通知结果出错
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RewardEvaluationError" object:nil];
    
    
}

-(BOOL)checkObjectExistency:(NSString *)usrObjectId className:(NSString *)name Keyname:(NSString*)key
{
    AVQuery *query=[AVQuery queryWithClassName:name];
    query.cachePolicy=kPFCachePolicyNetworkElseCache;
    [query whereKey:key equalTo:usrObjectId];
    if ([query countObjects]==0) {
        return YES;
    }
    return NO;
}


//校验两个条件同时存在的情况
-(BOOL)checkObjectExistencyWith2Conditions_value:(NSString *)usrObjectId className:(NSString *)name Keyname1:(NSString*)key keyname2:(NSString*)key2 value2:(NSString *)value2
{
    AVQuery *query1=[AVQuery queryWithClassName:name];
    query1.cachePolicy=kPFCachePolicyNetworkElseCache;
    [query1 whereKey:key equalTo:usrObjectId];
    AVQuery *query2=[AVQuery queryWithClassName:name];
    [query2 whereKey:key2 equalTo:value2];
    query2.cachePolicy=kPFCachePolicyNetworkElseCache;
    AVQuery *query=[AVQuery andQueryWithSubqueries:[NSArray arrayWithObjects:query1,query2,nil]];
    query.cachePolicy=kPFCachePolicyNetworkElseCache;
    if ([query countObjects]==0) {
        return YES;
    }
    return NO;
}



-(void)pushPrise
{
    AVUser *usr=[AVUser currentUser];
    if(usr==nil)
    {
        //没有登录交互操作
        [[NSNotificationCenter defaultCenter]postNotificationName:@"DidNotLoginError" object:nil];
    }
    else{
        if (![self checkObjectExistency:self.rewardObjectId className:@"RewardZan" Keyname:@"rewardObjectId"])
        {
            //重复点赞
            [[NSNotificationCenter defaultCenter]postNotificationName:@"OverDoneError" object:nil];
        }
        else
        {
                        //点赞的逻辑1
            RewardZan *zanObj=[[RewardZan alloc]init];
            zanObj.rewardObjectId=self.rewardObjectId;
            zanObj.ZanUserObjectId=usr.objectId;
            [zanObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //点赞成功
                    //点击赞，酷币加1，rewardPriseCount 加1
                    Reward *rewardObj=[Reward object];
                    rewardObj.objectId=self.rewardObjectId;
                    rewardObj.rewardPriseCount=[[NSNumber alloc]initWithInt:([self.dataSoure.likersNumber intValue]+1)];
                    rewardObj.rewardFee=[[NSNumber alloc]initWithInt:([self.dataSoure.rewardMoneyNumber intValue]+1)];
                    
                    
                    [rewardObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (error==nil) {
                            
                            
                            self.dataSoure.likersNumber=NSStringFromInt([self.dataSoure.likersNumber intValue]+1);
                            self.dataSoure.rewardMoneyNumber=NSStringFromInt([self.dataSoure.rewardMoneyNumber intValue]+1);
                            //更新界面
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"PriseSucceed" object:nil];
                        }else
                        {
                            //处理失败
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"RequestError" object:nil];
                        }
                    }];
                }
                else
                {
                    //点赞失败
                    //处理失败
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"RequestError" object:nil];
                }
            }];
        }
    }
}
-(void)saveComment:(NSString *)comment
{
    RewardEvaluation *evaluationObj=[[RewardEvaluation alloc]init];
    AVUser *usr=[AVUser currentUser];
    evaluationObj.evaluationMemberObjectID=usr.objectId;
    evaluationObj.evaluationMemberAccount=[usr objectForKey:@"account"];
    //    @dynamic evaluationMemberLocationDescri;
    //    @dynamic evaluationMemberLocation;
    evaluationObj.evaluationMemberName=[usr objectForKey:@"name"];
    evaluationObj.evaluationRewardObjectID=self.rewardObjectId;
    if (comment!=nil) {
        evaluationObj.evaluationContent=comment;
        [evaluationObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                //评论成功
                [[NSNotificationCenter defaultCenter]postNotificationName:@"CommentSucceed" object:nil];
                //重新加载数据
                [[NSNotificationCenter defaultCenter]postNotificationName:@"RewardEvaluationDataChanged" object:nil];
                 [self requestOnAVOS:0];
            }
        }];
    }
}

-(void)gainReward
{
    AVObject *getRewardObj=[[AVObject alloc]initWithClassName:@"GetReward"];
    AVUser *usr=[AVUser currentUser];
    if(usr==nil)
    {
        //没有登录交互操作
        [[NSNotificationCenter defaultCenter]postNotificationName:@"DidNotLoginError" object:nil];
    }
    else{
        if (![self checkObjectExistencyWith2Conditions_value:usr.objectId className:@"GetReward" Keyname1:@"getUserObjectId" keyname2:@"rewardObjectId" value2:self.rewardObjectId])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"OverDoneError" object:nil];
        }
        else{
        [getRewardObj setObject:usr.objectId forKey:@"GetUserObjectId"];
        [getRewardObj setObject:self.rewardObjectId forKey:@"rewardObjectId"];
        [getRewardObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                self.dataSoure.chanllageNum=NSStringFromInt([self.dataSoure.chanllageNum intValue]+1);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GainRewardSucceed" object:nil];
            }
            else
            {
                //处理失败
                [[NSNotificationCenter defaultCenter]postNotificationName:@"RequestError" object:nil];
            }
        }];
        }
    }
}

@end

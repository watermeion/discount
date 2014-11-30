//
//  ShowEvaluationOperation.m
//  DaZhe
//
//  Created by Mac on 11/19/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "ShowEvaluationOperation.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ShowEvaluationDataModel.h"
@implementation ShowEvaluationOperation

-(void)requestDataFromAVOS:(NSUInteger)pageNum
{
    AVQuery *query=[AVQuery queryWithClassName:@"Evaluation"];
    
    if (self.sellerObjectId!=nil) {
        [query whereKey:@"evaluationShopObjectID" equalTo:self.sellerObjectId];
        query.limit=5;
        query.skip=pageNum*5;
        query.cachePolicy=kPFCachePolicyNetworkElseCache;
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(error==nil)
            {
                [self receiveData:objects];
                
            }else
            {
                
                [self handleError];
                
            }
        }];
    }
    
}

-(void)receiveData:(NSArray *)objects
{
    
    if (self.result==nil) {
        self.result=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    for (Evaluation *obj in objects) {
        //处理数据，将evaluation 处理成ShowEvaluationDataObject
        //这里进行数据拼接和判空
        ShowEvaluationDataModel *dataModel=[[ShowEvaluationDataModel alloc]init];
        //处理name
        
        if ([self isNotNilOrBlank:obj.evaluationMemberAccount])
        {
            dataModel.usrName=obj.evaluationMemberAccount;
            
        }
        else if([self isNotNilOrBlank:obj.evaluationMemberName])
        {
            dataModel.usrName=obj.evaluationMemberName;
        }
        else
        {
            dataModel.usrName=@"匿名用户";
        }
        //处理评论内容
        if ([self isNotNilOrBlank:obj.evaluationContent]) {
            dataModel.usrComment=obj.evaluationContent;
        }
        else
        {
            //抛弃该评论
            continue;
        }
        
        //处理用户头像
        if ([self isNotNilOrBlank:obj.evaluationMemberLogoURL]) {
            NSURL *url=[[NSURL alloc]initWithString:obj.evaluationMemberLogoURL];
            NSData *dImage=[[NSData alloc]initWithContentsOfURL:url];
            
            if (dImage!=nil) {
                
                UIImage *image=[UIImage imageWithData:dImage];
                dataModel.usrLogo=image;
            }else
            {
                UIImage *image=[UIImage imageNamed:@"appicon_58.png"];
                
                dataModel.usrLogo=image;
            
            }
            
        }
        else
        {
            UIImage *image=[UIImage imageNamed:@"appicon_58.png"];
            
            dataModel.usrLogo=image;
        }
        
        //处理时间
        if(obj.updatedAt!=nil)
        {
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
            dataModel.time=[dateFormatter stringFromDate:obj.updatedAt];
            NSLog(@"%@",dataModel.time);
        }
        
        
        [self.result setObject:dataModel forKey:obj.objectId];
        
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DataDidLoad" object:nil];
}


-(BOOL)isNotNilOrBlank:(NSString *)object
{
    if (object!=nil && ![object isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
@end

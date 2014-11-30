//
//  SRDataObjectOperation.m
//  ;
//
//  Created by Mac on 11/11/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//


//数据层处理函数


#import "SRDataObjectOperation.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SROfferARewardDataObject.h"
#import "Reward.h"
#import "RewardZan.h"
#import "CommonMacro.h"
@implementation SRDataObjectOperation

//withoutImage
-(void)requestOnAVOS:(NSUInteger) numberOfPage
{
    if (_results==nil)
    {
        _results=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    
    AVQuery *query = [AVQuery queryWithClassName:@"Reward"];
    query.cachePolicy=kPFCachePolicyNetworkElseCache;
    query.limit=2;
    query.skip=numberOfPage*2;
    [query orderByDescending:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //结果处理函数
            [self receiveData:objects];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self handleError];
        }
    }];
    
    
    
};



-(void)receiveData:(NSArray *) objects
{
    //拼接数据
    if ([objects count]!=0)
    {
        for (Reward *obj in objects)
        {
            SROfferARewardDataObject *dataObject=[[SROfferARewardDataObject alloc]init];
            
            //                dataObject.rewardTitleName=[obj objectForKey:@"rewardTitle"];
            //                dataObject.storeAddress=[obj objectForKey:@"rewardTitle"];
            //                dataObject.likersNumber=[numberFormatter stringFromNumber:[obj objectForKey:@"rewardPriseCount"]];
            //                dataObject.storeName=[obj objectForKey:@"rewardShopName"];
            //                dataObject.rewardMoneyNumber=[numberFormatter stringFromNumber:[obj objectForKey:@"rewardFee"]];
            //                dataObject.storeDetails=[obj objectForKey:@"rewardContent"];
            //                dataObject.storeBelongings=[obj objectForKey:@"rewardShopType"];
            //                dataObject.usrNikiName=[obj objectForKey:@"rewardUserAccount"];
            
            if(obj.rewardTitle){
                dataObject.rewardTitleName=obj.rewardTitle;
            }
            else
            {
                dataObject.rewardTitleName=@"这个人很懒什么都没留下~";
            }
            if(obj.rewardShopLocationDescri){
                dataObject.storeAddress=obj.rewardShopLocationDescri;
            }else
            {
                dataObject.storeAddress=@"未知";
            }
            if (obj.city ||obj.district) {
                dataObject.storeZone=[NSString stringWithFormat:@"%@  %@",obj.city,obj.district];
            }
            else{
                dataObject.storeZone=@"地球上~";
            }
            if (obj.rewardPriseCount!=nil) {
                dataObject.likersNumber=NSStringFromNumber(obj.rewardPriseCount);
            }
            else{
                dataObject.likersNumber=@"0";
            }
            
            if (obj.rewardShopName) {
                dataObject.storeName=obj.rewardShopName;
            }
            else
            {
                dataObject.storeName=@"商铺名字未知";
            }
            
            if(obj.rewardFee)
            {
                dataObject.rewardMoneyNumber=NSStringFromNumber(obj.rewardFee);
            }
            else
            {
                dataObject.rewardMoneyNumber=@"0";
                
            }
            if (obj.rewardAverage) {
                dataObject.storeRewardAverage=NSStringFromNumber(obj.rewardAverage);
            }else
            {
                dataObject.storeRewardAverage=@"0";
            }
            
            if(obj.rewardContent){
                dataObject.storeDetails=obj.rewardContent;
            }else
            {
                dataObject.storeDetails=@"很懒什么都没留下";
            }
            if(obj.rewardShopType){
                dataObject.storeBelongings=obj.rewardShopType;
            }else
            {
                dataObject.storeBelongings=@"未知";
                
            }
            if (obj.rewardUserAccount) {
                dataObject.usrNikiName=obj.rewardUserAccount;
            }else
            {
                dataObject.usrNikiName=@"匿名用户";
            }
            //dataObject.usrLevelImage
            if ([obj.rewardImage getData]==nil) {
                dataObject.storeImage=[UIImage imageNamed:@"resturant1.png"];
            }
            else{
                dataObject.storeImage=[UIImage imageWithData:[obj.rewardImage getData]];
            }
            if ([obj.rewardUserLogo getData]==nil) {
                dataObject.usrProfileImage=[UIImage imageNamed:@"appicon_58.png"];
            }
            else{
                dataObject.usrProfileImage=[UIImage imageWithData:[obj.rewardUserLogo getData]];
            }
            
            if (dataObject.likersImageArray==nil)
            {
                dataObject.likersImageArray=[[NSMutableArray alloc]initWithCapacity:0];
            }
            
            if (obj.rewardPriseCount!=0)
            {
                //请求点赞的人的头像
                AVQuery *query = [AVQuery queryWithClassName:@"RewardZan"];
                //
                [query whereKey:@"rewardObjectId" equalTo:obj.objectId];
                query.cachePolicy=kPFCachePolicyNetworkElseCache;
                query.limit=5;
                [query orderByDescending:@"updatedAt"];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
                 {
                     if (error==nil)
                     {
                         if ([objects count]<=5 )
                         {
                             int i=0;
                             //循环拼接likersImageArray
                             for (RewardZan *zanObj in objects)
                             {
                                 
                                 //假如没有图片，使用默认图片 usr_image_white.png
                                 if ([zanObj.UserLogoUrl isEqualToString:@""] ||zanObj.UserLogoUrl==nil ) {
                                     UIImage *image=[UIImage imageNamed:@"user_image_white.png"];
                                     [dataObject.likersImageArray addObject:image];
                                 }
                                 //否则从服务器上下载
                                 else{
                                     NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:zanObj.UserLogoUrl]];
                                     UIImage *image=[UIImage imageWithData:data];
                                     //如果图像没有，使用默认图片
                                     if (image==nil) {
                                         UIImage *image=[UIImage imageNamed:@"user_image_white.png"];
                                         [dataObject.likersImageArray addObject:image];
                                     }
                                     else{
                                         [dataObject.likersImageArray addObject:image];
                                     }
                                 }
                                 //游标加1
                                 i++;
                                 
                             }
                             //不足个点赞用户图片，图片加
                             if ([dataObject.likersImageArray count]==i)
                             {
                                 for (; i<5; i++)
                                 {
                                     UIImage *image=[UIImage imageNamed:@"mine.png"];
                                     [dataObject.likersImageArray addObject:image];
                                 }
                             }
                         }
                         //加载图片成功
                         if (_results==nil)
                         {
                             _results=[[NSMutableDictionary alloc]initWithCapacity:0];
                             
                         }
                         [self CountChanllegeNum:dataObject keyValue:obj.objectId];
                         
                     }
                     else
                     {
                         //加载图片不成功，继续返回
                         [self CountChanllegeNum:dataObject keyValue:obj.objectId];
                         NSLog(@"%@",error.description);
                     }
                     
                 }];
            }
            //如果点赞人数为0
            else
            {
                
                for (int i=0; i<5; i++)
                {
                    UIImage *image=[UIImage imageNamed:@"mine.png"];
                    [dataObject.likersImageArray addObject:image];
                }
                
                if (_results==nil)
                {
                    _results=[[NSMutableDictionary alloc]initWithCapacity:0];
                    
                }
                //加载挑战人数
                [self CountChanllegeNum:dataObject keyValue:obj.objectId];
                
            }
        }
    }
    
};


-(void)handleError
{
    
    //出错了直接通知mainVC
    NSLog(@"requstError");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DataError" object:nil];
    
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"ResultsChanged" context:nil];
    [self removeObserver:self forKeyPath:@"DataError" context:nil];
    
}

-(void)CountChanllegeNum:(SROfferARewardDataObject *)object keyValue:(NSString*)keyValue
{
    AVQuery *query=[AVQuery queryWithClassName:@"GetReward"];
    [query whereKey:@"rewardObjectId" equalTo:keyValue];
    [query countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
        if (error==nil) {
            object.chanllageNum=NSStringFromInt(number);
            [self.results setObject:object forKey:keyValue];
        }
        else
        {
            object.chanllageNum=0;
            [self.results setObject:object forKey:keyValue];
        }
        if (_results!=nil)
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ResultsChanged" object:nil];
        }
    }];
}


@end

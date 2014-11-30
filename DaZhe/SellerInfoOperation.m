//
//  SellerInfoOperation.m
//  DaZhe
//
//  Created by Mac on 11/15/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "SellerInfoOperation.h"
#import "SellerInfo.h"
#import "Evaluation.h"
#import "SellerInfoDataModel.h"
#import "CommonMacro.h"
@implementation SellerInfoOperation

-(SellerInfoDataModel*)sellerInfoData
{
    if (!_sellerInfoData) {
        return _sellerInfoData=[[SellerInfoDataModel alloc]init];
    }
    
    return _sellerInfoData;
}



-(void)requestToAVOS:(NSString *)classname ID:(NSString *)Id
          Key:(NSString*)kword PageNumber:(NSUInteger)pagenumber Count:(NSUInteger) countNumber
{
    AVQuery *query=[AVQuery queryWithClassName:classname];
    query.cachePolicy=kPFCachePolicyNetworkElseCache;
    query.limit=countNumber;
    query.skip=countNumber*pagenumber;
    if (Id==nil && kword==nil)
    {
        [self handleError];
    }
    else{
        [query whereKey:kword equalTo:Id];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
         {
            if (error==nil)
            {
                if ([classname isEqualToString:@"SellerInfo"]) {
                     [self receiveData:objects];
                }
                else if([classname isEqualToString: @"Evaluation"])
                {
                    [self receiveEvaluationData:objects];
                }
               
            }
            else
            {
                [self handleError];
            }
        }];
        
    }
}





-(void)receiveData:(NSArray*) objs
{
    SellerInfo *obj=[objs objectAtIndex:0];
    
        self.sellerInfoData.sellerName=obj.sellerName;
        self.sellerInfoData.sellerAverage=NSStringFromNumber(obj.sellerAverageCost);
        self.sellerInfoData.sellerPriseCount=NSStringFromNumber(obj.sellerPriseCount);
        self.sellerInfoData.sellWarn=obj.sellerWarn;
        self.sellerInfoData.sellerPhone=obj.sellerPhone;
        self.sellerInfoData.sellerIsWifi=obj.sellerOIsWifi;
        self.sellerInfoData.sellerKeyword=obj.sellerKeyword;
        self.sellerInfoData.sellerBusinessHours=obj.sellerBusinessHour;
        self.sellerInfoData.sellerAppointTip=obj.sellerAppointTip;
        self.sellerInfoData.sellerAddress=obj.sellerLocationDesri;
        self.sellerInfoData.sellerDiscountOtherInfo=obj.sellerDiscountOtherInfo;
        self.sellerInfoData.sellerStarImage=[UIImage imageNamed:[NSString stringWithFormat:@"%dx.png",[self checkSellerCore:obj.sellerAllScore]]];

        self.sellerInfoData.sellerImageFile=obj.sellerLogo;
    
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Data1HasBeenPrepared" object:nil];
    
}


-(void)receiveEvaluationData:(NSArray*) objs
{
    self.result=nil;
    if (self.result==nil) {
        self.result=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    for (Evaluation *obj in objs) {
        [self.result setObject:obj forKey:obj.objectId];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Data2HasBeenPrepared" object:nil];
}


-(int)checkSellerCore:(NSNumber *)number
{
    NSLog(@"sellerScore:%d",[number intValue]);
    return [number intValue];
}
@end

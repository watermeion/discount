//
//  ShopZanServices.m
//  DaZhe
//
//  Created by Mac on 11/22/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "ShopZanServices.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SellerInfo.h"
//功能操作ShopZan表

@implementation ShopZanServices


-(void)save:(ShopZan *)shopZanObj
{
    [shopZanObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
         //成功了在Sellor表上sellerPriseCount+1;
            SellerInfo *sellerObj=[SellerInfo object];
            sellerObj.objectId=shopZanObj.sellerInfoObjectId;
            sellerObj.fetchWhenSave=YES;
            [sellerObj incrementKey:@"sellerPriseCount"];
            [sellerObj saveEventually];
            [self operationFeedBack:succeeded];
        }
        else
        {
            [self operationFeedBack:NO];
        }
    }];
}


-(BOOL)checkObjectExistency:(NSString *)usrObjectId className:(NSString *)name Keyname:(NSString*)key
{
    AVQuery *query=[AVQuery queryWithClassName:name];
    query.cachePolicy=kPFCachePolicyNetworkElseCache;
    [query whereKey:key equalTo:usrObjectId];
    if ([query countObjects]==0) {
        //不存在返回YES
        return YES;
    }
    //存在返回NO
    return NO;
    
    
}


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

-(void)operationFeedBack:(BOOL) flag
{
    if (flag) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Succeed" object:nil];
    }
    else
    {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Failed" object:nil];
    
    }
    

}

@end

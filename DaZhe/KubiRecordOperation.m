//
//  KubiRecordOperation.m
//  DaZhe
//
//  Created by Mac on 11/25/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "KubiRecordOperation.h"
#import <AVOSCloud/AVOSCloud.h>
@implementation KubiRecordOperation

-(NSMutableDictionary *)resultsDict
{
    if (!_resultsDict) {
        _resultsDict=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return _resultsDict;

}


//检查用户是否登录
-(BOOL)usrLoginCheck
{
    return [AVUser currentUser]?YES:NO;
}
//请求用户酷币总数
-(void)queryUsrHasKubeFee
{
    if ([self usrLoginCheck]) {
        AVQuery *query=[AVQuery queryWithClassName:@"_User"];
        query.limit=1;
        query.cachePolicy=kPFCachePolicyNetworkElseCache;
        [query whereKey:@"objectId" equalTo:[AVUser currentUser].objectId];
        [query selectKeys:@[@"kubiFee"]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error==nil && [objects count]==1) {
                
                //处理数据
                [self receiveUsrKubiFee:objects];
                
            }
            else
            {
                [self handleError];
            }
        }];
    }
    else
    {
        [self.delegate usrUnloginAction];
    
    }



}


-(void)receiveUsrKubiFee:(NSArray *)objects
{
    if ([objects count]==1) {
        AVObject *obj=[objects firstObject];
        self.usrKubiFee=[obj objectForKey:@"kubiFee"];
        [self.delegate updateUsrKubeFeeWhenGetData];
        
    }
    else
    {
        [self handleError];
    }


}


-(void)queryKubiRecordFromAVOS:(NSUInteger) pageNum
{
    if([self usrLoginCheck]){
    AVQuery *query1=[AVQuery queryWithClassName:@"KubeDetail"];
    query1.limit=10;
    query1.skip=pageNum*10;
    query1.cachePolicy=kPFCachePolicyNetworkElseCache;
        [query1 whereKey:@"kubeInObjectId" equalTo:[AVUser currentUser].objectId];
//    AVQuery *query2=[AVQuery queryWithClassName:@"KubeDetail"];
//        query2.limit=10;
//        query2.skip=pageNum*10;
//        query2.cachePolicy=kPFCachePolicyNetworkElseCache;
//        [query2 whereKey:@"kubeOutObjectId" equalTo:[AVUser currentUser].objectId];
//        
//        AVQuery *query=[AVQuery orQueryWithSubqueries:@[query1,query2]];
//        query.limit=10;
//        query.skip=pageNum*10;
//        query.cachePolicy=kPFCachePolicyNetworkElseCache;
//        
      [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
          if (error==nil && [objects count]>0) {
              [self receiveKubiRecordData:objects];
              
          }else
          {
              [self handleError];
              //通知数据加载错误
          
          }
      }];
        
    }
    else
    {
//        [self.delegate usrUnloginAction];
    }

}

-(void)receiveKubiRecordData:(NSArray *) objects
{
    for (KubeDetail *obj in objects) {
        [self.resultsDict setObject:obj forKey:obj.objectId];
    }
    [self.delegate updateKuBiFeeDetailWhenGetData];
}




@end

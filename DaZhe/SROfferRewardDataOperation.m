//
//  SROfferRewardDataOperation.m
//  DaZhe
//
//  Created by Mac on 11/10/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "SROfferRewardDataOperation.h"
#import "SRDataObjectOperation.h"
#import <AVOSCloud/AVOSCloud.h>
@implementation SROfferRewardDataOperation

//初始化
-(void)initilize
{

    self.handler=[[SRDataObjectOperation alloc]init];
    pageNumber=1;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(respond) name:@"ResultsChanged" object:nil];
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"ResultsChanged" context:nil];
    
}

//功能第一次调用
-(void)requestFirstItemFromAVOS
{
    [self.handler requestOnAVOS:0];
}
//请求更多
-(void)requestItemsFromAVOS
{
    [self.handler requestOnAVOS:pageNumber];
    pageNumber++;
};

//处理请求返回
-(void)respond;
{
    if (self.handler.results!=nil) {
        self.dataDict=self.handler.results;
        //通知上级view controller  数据加载完毕
    }
};






@end

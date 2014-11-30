//
//  SROfferRewardDataOperation.h
//  DaZhe
//
//  Created by Mac on 11/10/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//


//RewardViewBusiness
/*
 功能：实现SROfferARewardViewController 中的数据的请求，加载工作
 1、第一次请求，加载三个
 2、每次增量更新，三个
 3、
 */
#import <Foundation/Foundation.h>
//引入对象模型
#import "SROfferARewardDataObject.h"
@class SRDataObjectOperation;
@interface SROfferRewardDataOperation : NSObject
{
NSUInteger pageNumber;
}
@property (nonatomic,strong)NSMutableDictionary *dataDict;
@property(nonatomic,strong)SRDataObjectOperation* handler;
-(void)initilize;
//第一次提交请求
-(void)requestFirstItemFromAVOS;
//请求更多
-(void)requestItemsFromAVOS;

//更新数据

//处理请求返回
-(void)respond;

////
//-(void)addSubmmitRewardContentToAVOS:(SROfferARewardDataObject*) object;

@end

//
//  ShopZanServices.h
//  DaZhe
//
//  Created by Mac on 11/22/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopZan.h"
@interface ShopZanServices : NSObject

//请求

//数据接收


//上传新的记录

-(void)save:(ShopZan *)shopZanObj;


//结果反馈
-(void)operationFeedBack:(BOOL) flag;

-(BOOL)checkObjectExistency:(NSString *)usrObjectId className:(NSString *)name Keyname:(NSString*)key;

-(BOOL)checkObjectExistencyWith2Conditions_value:(NSString *)usrObjectId className:(NSString *)name Keyname1:(NSString*)key keyname2:(NSString*)key2 value2:(NSString *)value2;
@end

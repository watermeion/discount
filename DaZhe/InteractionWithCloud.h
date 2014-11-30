//
//  InteractionWithCloud.h
//  DaZhe
//
//  Created by Mac on 11/15/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
@interface InteractionWithCloud : NSObject

@property (strong,nonatomic)NSMutableDictionary *result;
//请求
//-(void)requestToAVOS:(NSString *)classname :(NSUInteger)pageNumber :(NSUInteger)count;

//-(void)receiveData;
//网络条件判断
-(BOOL)isOnline;
-(void)handleError;

-(BOOL)usrLoginCheck;
@end

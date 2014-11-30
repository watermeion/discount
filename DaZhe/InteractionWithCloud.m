//
//  InteractionWithCloud.m
//  DaZhe
//
//  Created by Mac on 11/15/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "InteractionWithCloud.h"

@implementation InteractionWithCloud
//请求

-(void)handleError
{
    
    NSLog(@"网络请求出错");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Error" object:nil];

}
-(void)receiveData
{

}
//网络条件判断
-(BOOL)isOnline
{
    return YES;
}

//检查用户是否登录
-(BOOL)usrLoginCheck
{
    return [AVUser currentUser]?YES:NO;
}
@end

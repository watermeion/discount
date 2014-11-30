//
//  SRSubmitRewardOperation.h
//  DaZhe
//
//  Created by Mac on 11/14/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRSubmitRewardOperation : NSObject

-(void)requestOnAVOS:(NSUInteger) numberOfPage;
-(void)receiveData:(NSArray *) objects;
-(void)handleError;

@end

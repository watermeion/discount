//
//  SRRegistBussiness.h
//  Health
//
//  Created by Mac on 6/4/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface SRRegistBussiness : NSObject
{
   

}
@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *pwd;
@property (nonatomic,strong)NSString *mobilePhoneNumber;
@property (nonatomic,strong)NSString *feedback;


-(void)NewUserRegistInBackground:(NSString*)username Pwd:(NSString*)password Phone:(NSString*) phone;
-(BOOL)NewUserRegist:(NSString*)username Pwd:(NSString*)password Phone:(NSString*) phone;

-(void) RegistHasSucceed;
-(void) RegistHasFailed:(NSError*)error;


@end

//
//  SRRegistBussiness.m
//  Health
//
//  Created by Mac on 6/4/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "SRRegistBussiness.h"

@implementation SRRegistBussiness
@synthesize feedback;
@synthesize username;
@synthesize pwd;
@synthesize mobilePhoneNumber;

-(void)NewUserRegistInBackground:(NSString*)_username Pwd:(NSString*)_password Phone:(NSString *)_phone{
    
    AVUser * user = [AVUser user];
    user.username = _username;
    user.password = _password;
    [user setObject:_phone forKey:@"mobilePhoneNumber"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
           [self RegistHasSucceed];
            
        } else {
            
            [self RegistHasFailed:error];

        }
    }];
}


-(BOOL)NewUserRegist:(NSString*)_username Pwd:(NSString*)_password Phone:(NSString*)_phone{
    static BOOL isSuccess=NO;
    NSError  *error;

    AVUser * user = [AVUser user];
    user.username = _username;
    user.password = _password;
    [user setObject:_phone forKey:@"mobilePhoneNumber"];
    [user setObject:[NSNumber numberWithInt:1] forKey:@"isGuest"];
    isSuccess=[user signUp:&error];
    
    if (!isSuccess) {
        
        [self RegistHasFailed:error];
    
    }
    else{

        [self RegistHasSucceed];
    }
    return isSuccess;
}

-(void) RegistHasFailed:(NSError*)error
{
    if([[[error userInfo]objectForKey:@"code"] integerValue]==214){
        self.feedback=@"该用户名已经被注册";
    }
}

-(void) RegistHasSucceed
{
    self.feedback=@"注册成功";
}

@end

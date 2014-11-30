//
//  RTLoginBusiness.m
//  Health
//
//  Created by Mac on 6/4/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//



//NSUserDefault  对应key-value 说明

//CurrentUserName                   --  username             of  RTUserInfo
//CurrentUserAge                    --  userAge              of  RTUserInfo
//CurrentUserGender                 --  userGenderName       of  RTUserInfo
//CurrentUserProtaitImageName       --  userImageName        of  RTUserInfo
//CurrentUserHeight                 --  height               of  RTUserInfo
//CurrentUserWeight                 --  weight               of  RTUserInfo
//CurrentUserBMI                    --  BMI                  of  RTUserInfo
//CurrentUserPhone                  --  phone                of  RTUserInfo
//CurrentUserEmail                  --  email                of  RTUserInfo
//CurrentUserSalt                   --  salt                 of  RTUserInfo
//CurrentUserNewsChannel            --  userChannelNews      of  RTUserInfo
//CurrentUserHealthIndex            --  CurrentUserHealthIndex   of  RTUserInfo
//
//auto_login                        --  (BOOL)               是否自动登录


#import "SRLoginBusiness.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation SRLoginBusiness

-(void)loginInbackground:(NSString *)username Pwd:(NSString *)pwd
{
    [AVUser logInWithUsernameInBackground:username password:pwd block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            [self loginIsSucceed:YES];
        }
        else {
            [self loginIsSucceed:NO];
            self.feedback=[self.feedback stringByAppendingString:[error localizedDescription]];

        }
        
    }];
}

-(void)login:(NSString *)username Pwd:(NSString *)pwd
{
    NSError *error;
    AVUser *loginUser=[AVUser logInWithMobilePhoneNumber:username password:pwd error:&error];
    
    if (loginUser!=nil) {
        
        [self findUser:loginUser username:username Pwd:pwd];
        
    }
    else {
        
        AVUser *loginUser1=[AVUser logInWithUsername:username password:pwd error:&error];
        
        if (loginUser1!=nil) {
            
            [self findUser:loginUser1 username:username Pwd:pwd];
            
        }
        else{
            
            [self loginIsSucceed:NO];
            
            self.feedback=[self.feedback stringByAppendingString:[error localizedDescription]];
        }
    }
}

- (void)findUser:(AVUser *)_user username:(NSString *)username Pwd:(NSString *)pwd{
    
    AVQuery *query=[AVQuery queryWithClassName:@"_User"];
    [query whereKey:@"objectId" equalTo:_user.objectId];
    NSArray *objects=[query findObjects];
    
    AVObject *user=[objects objectAtIndex:0];
    //BOOL isGuest=[[user objectForKey: @"isGuest"] boolValue];
 
        
    if ([[user objectForKey: @"userLoginStatus"] boolValue])
    {
            
        [SRLoginBusiness logOut];
            
        [self loginIsSucceed:NO];
            
        self.feedback=[self.feedback stringByAppendingString:@"您的账户已被登录"];
            
    }else{
        //登录成功后的操作
        [self loginIsSucceed:YES];
            
        [self saveUserBasicInfoLocally:username Pwd:pwd];
            
        [self dragUserDataFromAVOS];
        
        
        //改变后台登陆状态
        AVUser *_user=[AVUser currentUser];
        [_user setObject:[NSNumber numberWithInt:1] forKey:@"userLoginStatus"];
        [_user saveInBackground];
            
    }
}


-(BOOL)loginIsSucceed:(BOOL)result
{
    
    if (result) {
        self.feedback=@"登录成功";
        self.isSucceed=YES;
    }
    else
    {
        self.feedback=@"登录失败";
        self.isSucceed=NO;
    }
    return result;
}



-(BOOL)saveUserBasicInfoLocally:(NSString*) username
{
    //save username
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    [mySettingData setObject:username forKey:@"CurrentUserName"];
    //注意此处是明文存储，可能会带来安全性问题

    [mySettingData setValue:@YES forKey:@"auto_login"];
    return YES;
}


-(BOOL)saveUserBasicInfoLocally:(NSString*) username Pwd:(NSString*) pwd
{
    //save username
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    
    [mySettingData setObject:username forKey:@"CurrentUserName"];
    //注意此处是明文存储，可能会带来安全性问题
    
    [mySettingData setObject:pwd forKey:@"CurrentUserPassword"];
        
        
    [mySettingData setBool:YES  forKey:@"auto_login"];
    
    
    return YES;

}


-(BOOL)saveUserInfoLocally:(id)userProfilwInfo
{
    
    //设置NSUserdefault
    SRUserInfo *userinfo=userProfilwInfo;
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    
    if (userinfo.username!=nil) {
        [mySettingData setObject:userinfo.username forKey:@"CurrentUserName"];
    }
    
    [mySettingData synchronize];  
    
    return YES;
}


-(BOOL)checkIfAuto_login
{
    AVUser *cuser=[AVUser currentUser];
    if(cuser!=nil)
    {
        [self saveUserBasicInfoLocally:cuser.username];
        return YES;
    }
    else
    {
     return NO;
    }

}



+(BOOL)logOut
{
    //退出机制
   
    //设置NSUserdefault
   
    AVUser *_user=[AVUser currentUser];
    [_user setObject:[NSNumber numberWithInt:0] forKey:@"userLoginStatus"];
    [_user saveEventually];
    
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    
    [mySettingData setBool:NO forKey:@"auto_login"];
    
    [mySettingData removeObjectForKey: @"CurrentUserName"];

    [mySettingData synchronize];

    [AVUser logOut];  //清除缓存用户对象
    
    if ([AVUser currentUser]==nil) {
        return YES;
    }
    else
        return NO;
}

-(void)dragUserDataFromAVOS
{
    AVUser *current=[AVUser currentUser];
    AVQuery * query = [AVUser query];
    [query whereKey:@"objectId" equalTo:current.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            SRUserInfo *user=[objects objectAtIndex:0];
            [self saveUserInfoLocally:user];
            
        } else {
            
            [self loginIsSucceed:NO];
        }
    }];
}



@end

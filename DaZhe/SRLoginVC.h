//
//  SRLoginVC.h
//  DaZhe
//
//  Created by GeoBeans on 14-10-20.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SRLoginBusiness.h"

@protocol finishLogin <NSObject>
@required
- (void)finishLogin;
@end

@interface SRLoginVC : UIViewController{
    SRLoginBusiness *loginer;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIView *floatView;

@property (weak, nonatomic) IBOutlet UITextField *userAccount;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UIView *floatView2;

@property (nonatomic) CGRect rect1;
@property (weak, nonatomic) IBOutlet UILabel *loginInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property(nonatomic,weak) id<finishLogin> loginDelegate;

+(id)shareLoginVC;

@end

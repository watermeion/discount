//
//  SRRegisterVC.h
//  DaZhe
//
//  Created by GeoBeans on 14-10-20.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"
#import "SRRegistBussiness.h"

@protocol successRegistered <NSObject>
@required
- (void)successRegistered;
@end

@interface SRRegisterVC : UIViewController<QCheckBoxDelegate>{
    
    SRRegistBussiness *Register;
    NSString *inputPhoneNumber;
    NSString *verifyCode;
    NSString *inputPassword;
    BOOL agreed;
    NSTimer *timer;
    int seconds;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *securityCode;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIView *floatView;

@property (nonatomic) CGRect rect1;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UIButton *verificationButton;

@property(nonatomic,weak) id<successRegistered> registerDelegate;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@end

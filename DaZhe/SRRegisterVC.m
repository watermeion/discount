//
//  SRRegisterVC.m
//  DaZhe
//
//  Created by GeoBeans on 14-10-20.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRRegisterVC.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SRLoginVC.h"

@interface SRRegisterVC ()

@end

@implementation SRRegisterVC
@synthesize phoneNumber=_phoneNumber;
@synthesize securityCode=_securityCode;
@synthesize userPassword=_userPassword;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QCheckBox *_check1 = [[QCheckBox alloc] initWithDelegate:self];
    _check1.frame = CGRectMake(36, 360, 25, 25);
    [_check1 setTitle:nil forState:UIControlStateNormal];
    [_check1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_check1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_check1];
    [_check1 setChecked:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.rect1=self.floatView.frame;
    
    self.verificationButton.enabled=NO;
    
    self.registerButton.enabled=NO;
    
    agreed=YES;
    
    Register=[[SRRegistBussiness alloc]init];
    
    self.timerLabel.hidden=YES;
}

- (void)viewWillLayoutSubviews{
    [self.navBar setFrame:CGRectMake(0, 0, 320, 64)];
    self.navBar.translucent=NO;
}

- (IBAction)startEditing:(id)sender {

}
- (IBAction)endEditing:(id)sender {

}
- (IBAction)inputVerifyCode:(id)sender {
    verifyCode=self.securityCode.text;
    [self checkFinishedInput];
}

- (IBAction)inputPassword:(id)sender {
    inputPassword=self.userPassword.text;
    [self checkFinishedInput];
}

- (IBAction)inputPhoneNumber:(id)sender {
    if(self.phoneNumber.text.length==11)
    {
        inputPhoneNumber=self.phoneNumber.text;
        self.verificationButton.enabled=YES;
    }else{
        inputPhoneNumber=nil;
        self.verificationButton.enabled=NO;
    }
    [self checkFinishedInput];
}
- (IBAction)touchRegister:(id)sender {
    [AVOSCloud verifySmsCode:verifyCode callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            Register.username=inputPhoneNumber;
            Register.pwd=inputPassword;
            Register.mobilePhoneNumber=inputPhoneNumber;
            
            BOOL isRegistedSeccuss=[Register NewUserRegist:Register.username Pwd:Register.pwd Phone:Register.mobilePhoneNumber];
            if (isRegistedSeccuss) {
                
                [self dismissViewControllerAnimated:NO completion:^{
                    [self.registerDelegate successRegistered];
                }];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册失败" message:Register.feedback delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码错误" message:Register.feedback delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (IBAction)verification:(id)sender {
    if (inputPhoneNumber!=nil) {
        [AVOSCloud requestSmsCodeWithPhoneNumber:inputPhoneNumber
                                         appName:@"折扣联盟"
                                       operation:@"用户注册验证"
                                      timeToLive:10
                                        callback:^(BOOL succeeded, NSError *error) {
                                            if (succeeded){
                                              
                                             [NSThread detachNewThreadSelector:@selector(initTimer) toTarget:self withObject:nil];
                                                
                                            }else{
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码获取失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                                [alert show];
                                            }
                                        }];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification{
    if (DEVICE_IS_IPHONE4) {
        CGRect rect2=CGRectMake(self.rect1.origin.x, self.rect1.origin.y-100, self.rect1.size.width, self.rect1.size.height);
        [UIView animateWithDuration:0.3 animations:^{
            
            self.floatView.frame=rect2;
        }];
    }
}

- (void)keyboardWillhide:(NSNotification *)notification{
    if (DEVICE_IS_IPHONE4) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.floatView.frame=self.rect1;
        }];
    }
}


- (IBAction)touchBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - QCheckBoxDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    agreed=checked;
    [self checkFinishedInput];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phoneNumber resignFirstResponder];
    [_securityCode resignFirstResponder];
    [_userPassword resignFirstResponder];
}

- (void)checkFinishedInput{
    if (self.phoneNumber.text.length==11&&self.securityCode.text.length>0&&self.userPassword.text.length>0&&agreed) {
        self.registerButton.enabled=YES;
    }else
        self.registerButton.enabled=NO;
}

-(void)initTimer
{
    self.timerLabel.text=[NSString stringWithFormat:@"%d秒",10];
    self.timerLabel.hidden=NO;
    self.verificationButton.hidden=YES;
    
    NSTimeInterval timeInterval =1.0 ;
    //定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(handleMaxShowTimer:) userInfo:nil repeats:YES];
    seconds=10;
    [[NSRunLoop currentRunLoop] run];
}

//触发事件
-(void)handleMaxShowTimer:(NSTimer *)theTimer
{
    NSLog(@"%d",seconds);
    seconds--;

    [self performSelectorOnMainThread:@selector(showTimer) withObject:nil waitUntilDone:YES];
    
}

- (void)showTimer{
    self.timerLabel.text=[NSString stringWithFormat:@"%d秒",seconds];
    
    if (seconds==0) {
        [timer invalidate];
        self.timerLabel.hidden=YES;
        self.verificationButton.hidden=NO;
        seconds=10;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

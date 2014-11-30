//
//  SRLoginVC.m
//  DaZhe
//
//  Created by GeoBeans on 14-10-20.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRLoginVC.h"
#import "SRRegisterVC.h"
#import <AVOSCloud/AVOSCloud.h>
@interface SRLoginVC ()<successRegistered>

@end

@implementation SRLoginVC
@synthesize userAccount=_userAccount;
@synthesize userPassword=_userPassword;

static  SRLoginVC *thisController=nil;

+(id)shareLoginVC
{
    if (thisController==nil) {
        thisController=[[SRLoginVC alloc] initWithNibName:@"SRLoginVC" bundle:nil];
    }
    return thisController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.rect1=self.floatView2.frame;
    
    loginer=[[SRLoginBusiness alloc]init];
}

- (void)viewWillLayoutSubviews{
    [self.navBar setFrame:CGRectMake(0, 0, 320, 64)];
    self.navBar.translucent=NO;
    
    if (DEVICE_IS_IPHONE4)
        self.floatView.frame=CGRectMake(0, 372, 320, 108);
}

- (IBAction)touchBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)touchRegister:(id)sender {
    SRRegisterVC *registerVC=[[SRRegisterVC alloc]init];
    registerVC.registerDelegate=self;
    [self presentViewController:registerVC animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_userAccount resignFirstResponder];
    [_userPassword resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    if (DEVICE_IS_IPHONE4) {
        CGRect rect2=CGRectMake(self.rect1.origin.x, self.rect1.origin.y-50, self.rect1.size.width, self.rect1.size.height);
        [UIView animateWithDuration:0.3 animations:^{
            
            self.floatView2.frame=rect2;
        }];
    }
}

- (void)keyboardWillhide:(NSNotification *)notification{
    if (DEVICE_IS_IPHONE4) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.floatView2.frame=self.rect1;
        }];
    }

}

- (IBAction)touchLoginButton:(id)sender {
    
    if ([loginer.username length]==0) {

        self.loginInfoLabel.text=@"请输入登陆账户";
    }
    else if ([loginer.pwd length]==0){
        
        self.loginInfoLabel.text=@"请输入登陆密码";
    }
    else
    {
        [loginer login:loginer.username Pwd:loginer.pwd];
        
        if(loginer.isSucceed)
        {
            [self logIn];
            self.loginInfoLabel.text=nil;
        }
        else
        {
            self.loginInfoLabel.text=loginer.feedback;
        }
    }
}

- (IBAction)userAccountInput:(id)sender {
    
    loginer.username=self.userAccount.text;
}

- (IBAction)userPasswordInput:(id)sender {

    loginer.pwd=self.userPassword.text;
}

- (void)logIn{
    
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation setObject:currentInstallation.deviceToken forKey:@"installationid"];
    [currentInstallation saveInBackground];

    AVUser *_user=[AVUser currentUser];
    [_user setObject:currentInstallation.deviceToken forKey:@"installationid"];
    [_user saveInBackground];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.loginDelegate finishLogin];
    }];
}

- (void)successRegistered{
    [self logIn];
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

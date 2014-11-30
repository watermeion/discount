//
//  SRForthVC.m
//  DaZhe
//
//  Created by GeoBeans on 14-10-16.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRForthVC.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SRWebView.h"

#import "KuBiRecordListViewTableViewController.h"
#import "DiscountRecordTableViewController.h"
#import "CommentsListViewTableViewController.h"
#import "MyProfileViewController.h"
#import "UsrFeedBackViewController.h"
@interface SRForthVC ()<UIAlertViewDelegate>

@end

@implementation SRForthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scollView.frame=CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height+20);
    self.scollView.scrollEnabled=YES;
    
    //动态绑定LoginButton响应函数
    [self.LoginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setNeedsStatusBarAppearanceUpdate];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden=YES;

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([AVUser currentUser]!=nil) {
        [self finishLogin];
    }
    else {
        [self finishLogout];
    }
}

- (IBAction)login:(id)sender {
    
    if ([AVUser currentUser]==nil){
        SRLoginVC *loginVC=[SRLoginVC shareLoginVC];
        loginVC.loginDelegate=self;
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}

- (IBAction)logout:(id)sender {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定退出账户？" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        alert.delegate=self;
        [alert show];
 
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==400851) {
        if (buttonIndex==1) {
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4008519138"];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }
  
    }
    else{
    if (buttonIndex==0) {
        
        BOOL isLogout=[SRLoginBusiness logOut];
        if (isLogout) {
            [self finishLogout];
        }
    }
    }
}

- (void)finishLogin{
    
    self.buttonLabel.text=[NSString stringWithFormat:@"%@",[AVUser currentUser].username];
    
    if (DEVICE_IS_IPHONE4)
        self.scollView.contentSize=CGSizeMake(self.view.frame.size.width, 748);
    else
        self.scollView.contentSize=CGSizeMake(self.view.frame.size.width, 658);
    
    self.LogoutButton.hidden=NO;
    //动态绑定LoginButton响应函数
    [self.LoginButton addTarget:self action:@selector(myProfileInfo) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)finishLogout{
    
    self.buttonLabel.text=[NSString stringWithFormat:@"点击登录"];

    if (DEVICE_IS_IPHONE4)
        self.scollView.contentSize=CGSizeMake(self.view.frame.size.width, 698);
    else
        self.scollView.contentSize=CGSizeMake(self.view.frame.size.width, 608);
    
    self.LogoutButton.hidden=YES;
    //动态绑定LoginButton响应函数
    [self.LoginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)exchangeGift:(id)sender {
    SRWebView *webVC=[[SRWebView alloc]init];
    webVC.webUrl=@"http://123.57.132.146/mall/index.html";
    webVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (IBAction)forum:(id)sender {
    SRWebView *webVC=[[SRWebView alloc]init];
    webVC.webUrl=@"http://123.57.132.146:8080/zk_discuz/upload/forum.php";
    webVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:webVC animated:YES];
}
- (IBAction)activity:(id)sender {
    SRWebView *webVC=[[SRWebView alloc]init];
    webVC.webUrl=@"http://123.57.132.146/prize.html";
    webVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:webVC animated:YES];
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

- (IBAction)callServiceCenterAction:(id)sender {
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"亲，您即将拨打折扣联盟官方客服电话，我们等您哦~" delegate:self cancelButtonTitle:@"我再看看" otherButtonTitles:@"拨打客服", nil];
    alertView.tag=400851;
    [alertView show];
}

- (IBAction)userFeedBackAction:(id)sender {
//    UsrFeedBackViewController *feedBackVC=[[UsrFeedBackViewController alloc]init];
//    feedBackVC.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:feedBackVC animated:YES];
    
    AVUserFeedbackAgent *agent = [AVUserFeedbackAgent sharedInstance];
    [agent showConversations:self title:@"feedback" contact:@"Email或QQ号 （点击屏幕左上角返回）"];
}

- (IBAction)seeMyCommentsListAction:(id)sender {
    CommentsListViewTableViewController *commentVC=[[CommentsListViewTableViewController alloc]init];
    
    commentVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (IBAction)seeMyKubiRecordAction:(id)sender {
    
    KuBiRecordListViewTableViewController *recordVC=[[KuBiRecordListViewTableViewController alloc]init];
    
    recordVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:recordVC animated:YES];
    
}

- (IBAction)seeMyDiscountRecordAction:(id)sender {
    DiscountRecordTableViewController *discountVC=[[DiscountRecordTableViewController alloc]init];
    
    discountVC.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:discountVC animated:YES];
    
}


-(void)myProfileInfo
{
    MyProfileViewController *myProfileVC=[[MyProfileViewController alloc]init];
    
    myProfileVC.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:myProfileVC animated:YES];
}

@end

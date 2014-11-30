//
//  UsrFeedBackViewController.m
//  DaZhe
//
//  Created by Mac on 11/27/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "UsrFeedBackViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface UsrFeedBackViewController ()

@end

@implementation UsrFeedBackViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationItem.title=@"个人资料";
    //设置导航栏标题颜色及返回按钮颜色
    self.navigationController.navigationBar.hidden=NO;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarAttributes];
    
    AVUserFeedbackAgent *agent = [AVUserFeedbackAgent sharedInstance];
    [agent showConversations:self title:@"feedback" contact:@"Email或QQ号"];
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

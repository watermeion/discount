//
//  SRCodeVC.m
//  DaZhe
//
//  Created by GeoBeans on 14-10-12.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRCodeVC.h"
#import "QRCodeGenerator.h"

@interface SRCodeVC ()

@end

@implementation SRCodeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"我的二维码";
    
    self.shareButton.backgroundColor=[UIColor colorWithRed:0.97 green:0.31 blue:0.36 alpha:1.0];
    self.navigationItem.backBarButtonItem=nil;
    
    self.codeImageView.image=self.codeImage;
}
- (IBAction)share:(id)sender {
    
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

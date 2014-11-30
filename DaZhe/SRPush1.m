//
//  SRPush1.m
//  DaZhe
//
//  Created by RAY on 14/11/15.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRPush1.h"
#import "SRRecomendVC.h"
@interface SRPush1 ()<successRecomended>

@end

@implementation SRPush1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.priceLabel.text=self.kubi;
    
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillLayoutSubviews{
    [self.navBar setFrame:CGRectMake(0, 0, 320, 64)];
    [self.navBar setBarTintColor:[UIColor colorWithRed:0.97 green:0.31 blue:0.36 alpha:1.0]];
    
}
- (IBAction)recomend:(id)sender {
    SRRecomendVC *recVC=[[SRRecomendVC alloc]init];
    recVC.RecomendDelegate=self;
    recVC.selleObjectId=self.sellerObjectId;
    recVC.commentDiscountObjectId=self.commentDiscountObjectId;
    [self presentViewController:recVC animated:YES completion:nil];
}

- (void)successRecomended{
    [self dismissViewControllerAnimated:YES completion:nil];
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

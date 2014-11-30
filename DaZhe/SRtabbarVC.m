//
//  SRtabbarVC.m
//  DaZhe
//
//  Created by GeoBeans on 14-9-16.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRtabbarVC.h"
#import "SRIntroduceVC.h"


@interface SRtabbarVC ()

@end

@implementation SRtabbarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
//
//- (void)viewWillAppear:(BOOL)animated{
//
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    [[self.tabBar.items objectAtIndex:0] setFinishedSelectedImage:[UIImage imageNamed:@"home_selected"] withFinishedUnselectedImage:nil];
//    [[self.tabBar.items objectAtIndex:1] setFinishedSelectedImage:[UIImage imageNamed:@"find_selected"] withFinishedUnselectedImage:nil];
//    [[self.tabBar.items objectAtIndex:2] setFinishedSelectedImage:[UIImage imageNamed:@"activity_selected"] withFinishedUnselectedImage:nil];
//    [[self.tabBar.items objectAtIndex:3] setFinishedSelectedImage:[UIImage imageNamed:@"mine_selected"] withFinishedUnselectedImage:nil];
}

- (void)viewWillLayoutSubviews{
    
    [self.tabBar setSelectedImageTintColor: [UIColor colorWithRed:0.98 green:0.30 blue:0.37 alpha:1.0]];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    //NSLog(@"%ld",(long)item.tag);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

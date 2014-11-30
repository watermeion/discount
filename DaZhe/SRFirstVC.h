//
//  SRFirstVC.h
//  DaZhe
//
//  Created by GeoBeans on 14-9-22.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRAdvertisingView.h"
#import "JGProgressHUD.h"

@interface SRFirstVC : UIViewController<ValueClickDelegate,UITableViewDataSource,UITableViewDelegate,JGProgressHUDDelegate>
{
    BOOL firstLoad;

    BOOL headerRefreshing;
    BOOL footerRefreshing;
    int skipTimes;
    NSInteger cellNum;
    JGProgressHUD *HUD;
    NSMutableArray *recordArray;
    
}
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *headView2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;
@property (strong, nonatomic) UIImage *codeImage;
@property (strong, nonatomic) NSString *objectID;

@end

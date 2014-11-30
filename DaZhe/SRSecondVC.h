//
//  SRSecondVC.h
//  DaZhe
//
//  Created by GeoBeans on 14-10-15.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"
#import "JGProgressHUD.h"

@interface SRSecondVC : UIViewController<DropDownChooseDelegate,DropDownChooseDataSource,UITableViewDataSource,UITableViewDelegate,JGProgressHUDDelegate>
{
    NSMutableArray *chooseArray;
    
    BOOL firstLoad;
    
    BOOL headerRefreshing;
    BOOL footerRefreshing;
    int skipTimes;
    NSInteger cellNum;
    JGProgressHUD *HUD;
    NSMutableArray *recordArray;
    
    NSString *_sellerClass;
    NSString *_sellerSubClass;
    NSString *_sellerDistrict;
    int _rankStyle;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

//
//  SROfferARewardMainViewController.h
//  DaZhe
//
//  Created by Mac on 11/8/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SROfferARewardDataObject.h"
#import "SROfferRewardDataOperation.h"

@interface SROfferARewardMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (strong,nonatomic)UIAlertView *alertView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)SROfferRewardDataOperation *businessLayerObject;


@property(nonatomic,strong)NSArray* dataKeyForTableView;
@property(nonatomic,weak)NSDictionary* dataDictForTableView;


@property (nonatomic, strong) UIRefreshControl* refreshControl;

@end

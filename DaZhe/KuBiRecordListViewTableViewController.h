//
//  KuBiRecordListViewTableViewController.h
//  DaZhe
//
//  Created by Mac on 11/25/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KubiRecordOperation.h"
@interface KuBiRecordListViewTableViewController : UITableViewController<KubeFeeOperationDelagate>

@property(nonatomic,strong)KubiRecordOperation *businessLayer;


@end

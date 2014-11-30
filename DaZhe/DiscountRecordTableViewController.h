//
//  DiscountRecordTableViewController.h
//  DaZhe
//
//  Created by Mac on 11/26/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscountRecordOperation.h"
@interface DiscountRecordTableViewController : UITableViewController<DiscountRecordOperationDelegate>

@property(nonatomic,strong)DiscountRecordOperation *businessLayer;
@end

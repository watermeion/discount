//
//  SRShowEvaluationTableViewController.h
//  DaZhe
//
//  Created by Mac on 11/18/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowEvaluationOperation.h"
@interface SRShowEvaluationTableViewController : UITableViewController<UIAlertViewDelegate>

{
    NSUInteger PageNumber;

}
@property (nonatomic,strong)UIRefreshControl *refreshControl;
@property(nonatomic,strong)NSString *sellerObjectId;

@property (nonatomic,strong)ShowEvaluationOperation *showEvaluationBusinessLayer;

@property (nonatomic,strong)UIAlertView *alertView;
@end

//
//  SROfferARewardDetailViewController.h
//  DaZhe
//
//  Created by Mac on 11/8/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SROfferARewardDataObject.h"
#import "SRRewardEvaluationOperation.h"

@interface SROfferARewardDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSString *comment;

}


@property(weak,nonatomic)NSString *RewardObjectId;


@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *view7;

@property (weak,nonatomic)SROfferARewardDataObject *dataSoure;

@property (strong,nonatomic) SRRewardEvaluationOperation *businessLayerObject;

@property(strong,nonatomic)UIAlertView *alert;


//界面IBOutlet
//信息内容
@property (strong, nonatomic) IBOutlet UILabel *rewardTitleName;
@property (strong, nonatomic) IBOutlet UILabel *rewardMoneyNumber;
@property (strong, nonatomic) IBOutlet UILabel *usrNikiName;
@property (strong, nonatomic) IBOutlet UILabel *storeName;
@property (strong, nonatomic) IBOutlet UILabel *storeBelongings;
@property (strong, nonatomic) IBOutlet UILabel *storeZone;
@property (strong, nonatomic) IBOutlet UILabel *storeAddress;
@property (strong, nonatomic) IBOutlet UILabel *storeDetails;
@property (strong, nonatomic) IBOutlet UILabel *likersNumber;


@property (strong, nonatomic) IBOutlet UIImageView *storeImage;
@property (strong, nonatomic) IBOutlet UIImageView *usrProfileImage;
@property (strong, nonatomic) IBOutlet UIImageView *usrLevelImage;

@property (weak, nonatomic) IBOutlet UITextView *rewardDetailWordsText;
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;
@property (weak, nonatomic) IBOutlet UILabel *challegersNumber;

@property (weak, nonatomic) IBOutlet UIButton *submitRewardZan;

@property (weak, nonatomic) IBOutlet UIButton *gainRewards;

- (IBAction)submitRewardZan:(id)sender;

- (IBAction)makeCommentAction:(id)sender;
- (IBAction)gainRewardAction:(id)sender;

@end

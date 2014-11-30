//
//  SROfferARewardTableViewCell.h
//  DaZhe
//
//  Created by Mac on 11/8/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SROfferARewardDataObject.h"
#import "SROfferRewardDataOperation.h"
@interface SROfferARewardTableViewCell : UITableViewCell

-(void)cellDataInit:(SROfferARewardDataObject*)data;


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
@property (strong, nonatomic) IBOutlet UIImageView *likersImage0;
@property (strong, nonatomic) IBOutlet UIImageView *likersImage1;
@property (strong, nonatomic) IBOutlet UIImageView *likersImage2;
@property (strong, nonatomic) IBOutlet UIImageView *likersImage3;
@property (strong, nonatomic) IBOutlet UIImageView *likersImage4;


@end

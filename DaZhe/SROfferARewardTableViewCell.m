//
//  SROfferARewardTableViewCell.m
//  DaZhe
//
//  Created by Mac on 11/8/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "SROfferARewardTableViewCell.h"

@implementation SROfferARewardTableViewCell

-(void)cellDataInit:(SROfferARewardDataObject *)data
{
    // 加载数据
    self.rewardTitleName.text=data.rewardTitleName;
    self.rewardMoneyNumber.text=data.rewardMoneyNumber;
    self.storeName.text=data.storeName;
    self.storeDetails.text=data.storeDetails;
    self.storeZone.text=data.storeZone;
    self.storeBelongings.text=data.storeBelongings;
    self.storeImage.image=data.storeImage;
    self.usrNikiName.text=data.usrNikiName;
    self.likersNumber.text=data.likersNumber;
    self.usrProfileImage.image=data.usrProfileImage;
    self.storeAddress.text=data.storeAddress;
    //    self.usrLevelImage.image=data.usrLevelImage;
        self.likersImage0.image=[data.likersImageArray objectAtIndex:0];
        self.likersImage1.image=[data.likersImageArray objectAtIndex:1];
        self.likersImage2.image=[data.likersImageArray objectAtIndex:2];
        self.likersImage3.image=[data.likersImageArray objectAtIndex:3];
        self.likersImage4.image=[data.likersImageArray objectAtIndex:4];
    //
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

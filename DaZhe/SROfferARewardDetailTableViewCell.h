//
//  SROfferARewardDetailTableViewCell.h
//  DaZhe
//
//  Created by Mac on 11/8/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RewardEvaluation.h"
@interface SROfferARewardDetailTableViewCell : UITableViewCell
{
    NSInteger height;
}

@property BOOL isResponeMsg;
@property (weak,nonatomic)RewardEvaluation *data;

@property (strong, nonatomic) IBOutlet UIImageView *conmenterImage;
@property (strong, nonatomic) IBOutlet UILabel *conmenterNickName;
@property (strong, nonatomic) IBOutlet UILabel *conmentTime;
@property (strong, nonatomic) IBOutlet UILabel *toUsrNickName;
@property (strong, nonatomic) IBOutlet UILabel *responeLabelUnchanged;
@property (strong, nonatomic) IBOutlet UITextView *commentContent;


-(void)dataInit:(RewardEvaluation *)data;


@end

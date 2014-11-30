//
//  DiscountRecordTableViewCell.h
//  DaZhe
//
//  Created by Mac on 11/26/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscountRecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventFavorLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventConsumeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eventTagImage;
@property (weak, nonatomic) IBOutlet UILabel *eventTimeTag;

@end

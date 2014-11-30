//
//  SRCell1.h
//  DaZhe
//
//  Created by GeoBeans on 14-9-22.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import <QuartzCore/QuartzCore.h>

@interface SRCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sellerNameLabel;
@property (weak, nonatomic) IBOutlet EGOImageView *sellerImage;
@property (weak, nonatomic) IBOutlet UIImageView *sellerScore;
@property (weak, nonatomic) IBOutlet UILabel *sellerKeyWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *customAverage;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priseCount;

@end

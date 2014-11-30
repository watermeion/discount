//
//  SRShowEvaluationTableViewCell.h
//  DaZhe
//
//  Created by Mac on 11/19/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowEvaluationDataModel.h"
@interface SRShowEvaluationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *usrImageView;

@property (weak, nonatomic) IBOutlet UILabel *userEvaluationContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usrNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTimeLabel;


-(void)initFromData:(ShowEvaluationDataModel *)data;
@end
